package nd.flutter.plugins.gpu_video_filters

import VideoFilterApiImpl
import android.content.Context
import android.net.Uri
import android.util.Log
import android.util.LongSparseArray
import android.view.Surface
import android.view.View
import androidx.annotation.NonNull
import com.google.android.exoplayer2.ExoPlayer
import com.google.android.exoplayer2.MediaItem
import com.google.android.exoplayer2.Player
import com.google.android.exoplayer2.util.EventLogger
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import java.io.File


/** GpuVideoFiltersPlugin */
class GpuVideoFiltersPlugin : FlutterPlugin {

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val videoFilterApiImpl = VideoFilterApiImpl(flutterPluginBinding)
        val videoPreviewApiImpl = VideoPreviewApiImpl(flutterPluginBinding, videoFilterApiImpl)
        FilterMessages.FilterApi.setup(flutterPluginBinding.binaryMessenger, videoFilterApiImpl)
        PreviewMessages.VideoPreviewApi.setup(flutterPluginBinding.binaryMessenger, videoPreviewApiImpl)

        flutterPluginBinding
                .platformViewRegistry
                .registerViewFactory("GPUVideoPreview", videoPreviewApiImpl)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {

    }
}

class VideoTexture(context: Context) {
    var filter: DynamicTextureProcessor? = null
    val player: ExoPlayer = ExoPlayer.Builder(context).build()
}

class VideoPreviewApiImpl(private val binding: FlutterPluginBinding, private val videoFilters: VideoFilterApiImpl) : PlatformViewFactory(StandardMessageCodec.INSTANCE), PreviewMessages.VideoPreviewApi {
    var videosSources: LongSparseArray<VideoTexture> = LongSparseArray();
    var videosPreviews: LongSparseArray<VideoPreview> = LongSparseArray();

    override fun create(): Long {
        val texture = binding.textureRegistry.createSurfaceTexture();
        val videoTexture = VideoTexture(binding.applicationContext)
        videoTexture.player.setVideoSurface(Surface(texture.surfaceTexture()))
        videosSources.put(texture.id(), videoTexture)
        return texture.id()
    }

    override fun connect(textureId: Long, filterId: Long, embedded: Boolean) {
        if (embedded) {
            val videoSource = videosPreviews[textureId]
            val filter = videoFilters.filters[filterId]
            filter.onUniformsUpdater = videoSource
        } else {
            val videoSource = videosSources[textureId]
            val filter = videoFilters.filters[filterId]
            videoSource.filter = filter
        }
    }

    override fun disconnect(textureId: Long, embedded: Boolean) {

    }

    override fun setSource(msg: PreviewMessages.SourcePreviewMessage, embedded: Boolean) {
        val mediaUri = if (msg.asset) {
            val asset = binding.flutterAssets.getAssetFilePathByName(msg.path)
            Uri.parse("asset:///$asset")
        } else {
            Uri.fromFile(File(msg.path))
        }

        val mediaItem = MediaItem.Builder().setUri(mediaUri).build()
        if (!embedded) {
            val videoSource = videosSources[msg.textureId]
            videoSource.player.repeatMode = Player.REPEAT_MODE_ONE
            videoSource.player.setMediaItem(mediaItem)
            videoSource.player.prepare()
            videoSource.player.play()
        }
        if (embedded) {
            val videoPreview = videosPreviews[msg.textureId]
            videoPreview.player.repeatMode = Player.REPEAT_MODE_ALL
            videoPreview.player.setMediaItem(mediaItem)
            videoPreview.player.prepare()
            videoPreview.player.play()
            videoPreview.videoProcessingGLSurfaceView.setPlayer(videoPreview.player)
            videoPreview.player.addAnalyticsListener(EventLogger())
        }
    }

    override fun resume(textureId: Long, embedded: Boolean) {
        if (!embedded) {
            val videoSource = videosSources[textureId]
            videoSource.player.play()
        }
        if (embedded) {
            val videoPreview = videosPreviews[textureId]
            videoPreview.player.play()
        }
    }

    override fun pause(textureId: Long, embedded: Boolean) {
        if (!embedded) {
            val videoSource = videosSources[textureId]
            videoSource.player.pause()
        }
        if (embedded) {
            val videoPreview = videosPreviews[textureId]
            videoPreview.player.play()
        }
    }

    override fun dispose(textureId: Long, embedded: Boolean) {
        if (!embedded) {
            val videoSource = videosSources[textureId]
            videoSource.player.stop()
            videoSource.player.release()
            videosSources.remove(textureId)
        }
        if (embedded) {
            val videoPreview = videosPreviews[textureId]
            videoPreview.player.stop()
            videoPreview.player.release()
            videosPreviews.remove(textureId)
        }
    }

    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        val params = args as Map<String, *>
        val vertex = params["vertex"] as String
        val fragment = params["fragment"] as String
        val defaultFloats = HashMap<String, Float>()
        val defaultArrayFloats = HashMap<String, FloatArray>()
        for (key in params.keys) {
            if (key == "vertex" || key == "fragment") {
                continue;
            }
            val value = params[key]
            if (value is Double) {
                defaultFloats[key] = value.toFloat()
            } else if (value is FloatArray) {
                defaultArrayFloats[key] = value;
            }
        }
        val preview = VideoPreview(context!!, vertex, fragment, defaultFloats, defaultArrayFloats)
        videosPreviews.put(viewId.toLong(), preview)
        return preview
    }
}

class VideoPreview(context: Context,
                   vertexGlsl: String,
                   fragmentGlsl: String,
                   defaultFloats: Map<String, Float>,
                   defaultArrayFloats: Map<String, FloatArray>) : PlatformView, OnUniformsUpdater {

    val player: ExoPlayer = ExoPlayer.Builder(context).build()
    private val processor: DynamicVideoProcessor = DynamicVideoProcessor(vertexGlsl, fragmentGlsl, defaultFloats, defaultArrayFloats)
    val videoProcessingGLSurfaceView: VideoProcessingGLSurfaceView = VideoProcessingGLSurfaceView(
            context, false, processor);

    override fun getView(): View? {
        return videoProcessingGLSurfaceView
    }

    override fun dispose() {
        player.stop()
        player.release()
    }

    override fun setFloatUniform(name: String?, value: Float) {
        processor.setFloatUniform(name, value)
    }

    override fun setFloatsUniform(name: String?, value: FloatArray?) {
        Log.e(javaClass.simpleName, "$name == $value")
        processor.setFloatsUniform(name, value)
    }
}