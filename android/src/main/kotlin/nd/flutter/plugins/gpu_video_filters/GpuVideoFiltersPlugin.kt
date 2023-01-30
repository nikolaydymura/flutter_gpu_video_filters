package nd.flutter.plugins.gpu_video_filters

import android.content.Context
import android.net.Uri
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.util.LongSparseArray
import android.view.Surface
import android.view.SurfaceHolder
import android.view.SurfaceView
import android.view.View
import android.widget.FrameLayout
import androidx.annotation.NonNull
import com.google.android.exoplayer2.ExoPlayer
import com.google.android.exoplayer2.MediaItem
import com.google.android.exoplayer2.Player
import com.google.android.exoplayer2.transformer.*
import com.google.android.exoplayer2.transformer.Transformer.DebugViewProvider
import com.google.common.collect.ImmutableList
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import java.io.File
import java.util.concurrent.CountDownLatch


/** GpuVideoFiltersPlugin */
class GpuVideoFiltersPlugin: FlutterPlugin {

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val videoFilterApiImpl = VideoFilterApiImpl(flutterPluginBinding)
        FilterMessages.FilterApi.setup(flutterPluginBinding.binaryMessenger, videoFilterApiImpl)
        PreviewMessages.VideoPreviewApi.setup(flutterPluginBinding.binaryMessenger, VideoPreviewApiImpl(flutterPluginBinding, videoFilterApiImpl))

        flutterPluginBinding
                .platformViewRegistry
                .registerViewFactory("GPUVideoPreview", VideoPreviewFactory())
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {

    }
}

class VideoTexture(private val context: Context) {
    var filter: DynamicProcessor? = null
    val player: ExoPlayer = ExoPlayer.Builder(context).build()

    fun createTransformer(filePath: String?): Transformer? {
        if (filter == null) {
            return null
        }
        val transformerBuilder = Transformer.Builder(context)
        val requestBuilder = TransformationRequest.Builder()
        transformerBuilder
                .setTransformationRequest(requestBuilder.build())
                .setRemoveAudio(true)
                .setEncoderFactory(
                        DefaultEncoderFactory(
                                EncoderSelector.DEFAULT, true))
        val effects: ImmutableList.Builder<GlEffect> = ImmutableList.Builder()
        effects.add { filter!! }
        transformerBuilder.setVideoFrameEffects(effects.build())
        return transformerBuilder
                .addListener(
                        object : Transformer.Listener {
                            override fun onTransformationCompleted(inputMediaItem: MediaItem) {
                                Log.e(javaClass.simpleName, "onTransformationCompleted $filePath $inputMediaItem")
                            }

                            override fun onTransformationError(inputMediaItem: MediaItem, exception: TransformationException) {
                                Log.e(javaClass.simpleName, "onTransformationError $inputMediaItem", exception)
                            }
                        })
                .build()
    }
}

class VideoFilterApiImpl(private val binding: FlutterPluginBinding) : FilterMessages.FilterApi {
    var filters: LongSparseArray<DynamicProcessor> = LongSparseArray();
    private var filterSequenceId: Long = 0;

    override fun create(fragmentShader: String): Long {
        val processor = DynamicProcessor(fragmentShader)
        var filterId = filterSequenceId
        filterSequenceId++
        filters.put(filterId, processor)

        return filterId
    }

    override fun setInputAsset(filterId: Long, path: String) {
        TODO("Not yet implemented")
    }

    override fun setInputFile(filterId: Long, path: String) {
        TODO("Not yet implemented")
    }

    override fun setFloatParameter(filterId: Long, key: String, value: Double) {
        TODO("Not yet implemented")
    }

    override fun setFloatArrayParameter(filterId: Long, key: String, value: MutableList<Double>) {
        TODO("Not yet implemented")
    }

    override fun setBitmapParameter(filterId: Long, key: String, data: ByteArray) {
        TODO("Not yet implemented")
    }

    override fun setBitmapSourceParameter(filterId: Long, key: String, asset: Boolean, path: String) {
        TODO("Not yet implemented")
    }

    override fun dispose(filterId: Long) {
        val processor = filters[filterId]
        processor.release()
        filters.remove(filterId)
    }

}

class VideoPreviewApiImpl(private val binding: FlutterPluginBinding, private val videoFilters: VideoFilterApiImpl) : PreviewMessages.VideoPreviewApi {
    private var videosSources: LongSparseArray<VideoTexture> = LongSparseArray();

    override fun create(): Long {
        val texture = binding.textureRegistry.createSurfaceTexture();
        val videoTexture = VideoTexture(binding.applicationContext)
        videoTexture.player.setVideoSurface(Surface(texture.surfaceTexture()))
        videosSources.put(texture.id(), videoTexture)
        return texture.id()
    }

    override fun connect(textureId: Long, filterId: Long) {
        val videoSource = videosSources[textureId]
        val filter = videoFilters.filters[filterId];
        videoSource.filter = filter
    }

    override fun disconnect(textureId: Long) {

    }

    override fun setSource(msg: PreviewMessages.SourcePreviewMessage) {
        val videoSource = videosSources[msg.textureId]
        videoSource.player.repeatMode = Player.REPEAT_MODE_ONE
        val mediaUri = if (msg.asset) {
            val asset = binding.flutterAssets.getAssetFilePathByName(msg.path)
            Uri.parse("asset:///$asset")
        } else {
            Uri.fromFile(File(msg.path))
        }
        val mediaItem = MediaItem.Builder().setUri(mediaUri).build()
        videoSource.player.setMediaItem(mediaItem)
        videoSource.player.prepare()
        videoSource.player.play()
    }

    override fun resume(textureId: Long) {
        val videoSource = videosSources[textureId]
        videoSource.player.play()
    }

    override fun pause(textureId: Long) {
        val videoSource = videosSources[textureId]
        videoSource.player.pause()
    }

    override fun dispose(textureId: Long) {
        val videoSource = videosSources[textureId]
        videoSource.player.stop()
        videoSource.player.release()
        videosSources.remove(textureId)
    }
}

class VideoPreviewFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        val creationParams = args as Map<String?, Any?>?
        return VideoPreview(context!!)
    }
}

class VideoPreview(private val context: Context) : PlatformView, DebugViewProvider {
    private var debugFrame: FrameLayout = FrameLayout(context)
    override fun getView(): View? {
        /*
        TODO:
        val mediaUri = Uri.parse("asset:///flutter_assets/videos/BigBuckBunny.mp4")
        try {
            val externalCacheFile = File(context.externalCacheDir, "temp.mp4")
            if (externalCacheFile.exists()) {
                externalCacheFile.delete()
            } else {
                externalCacheFile.createNewFile()
            }
            val filePath = externalCacheFile.absolutePath
            val transformer: Transformer = createTransformer(filePath)
            transformer.startTransformation(MediaItem.Builder().setUri(mediaUri).build(), filePath)
        } catch (e: Exception) {
            e.printStackTrace()
        }
        */
        return debugFrame
    }

    override fun dispose() {
        TODO("Not yet implemented")
    }

    override fun getDebugPreviewSurfaceView(width: Int, height: Int): SurfaceView? {

        // Update the UI on the main thread and wait for the output surface to be available.
        val surfaceCreatedCountDownLatch = CountDownLatch(1)
        val surfaceView = SurfaceView(context)
        Handler(Looper.getMainLooper()!!).post {
            debugFrame.addView(surfaceView)
            //debugFrame.setAspectRatio(width.toFloat() / height)
            surfaceView
                    .holder
                    .addCallback(
                            object : SurfaceHolder.Callback {
                                override fun surfaceCreated(surfaceHolder: SurfaceHolder) {
                                    surfaceCreatedCountDownLatch.countDown()
                                }

                                override fun surfaceChanged(
                                        surfaceHolder: SurfaceHolder, format: Int, width: Int, height: Int) {
                                    // Do nothing.
                                }

                                override fun surfaceDestroyed(surfaceHolder: SurfaceHolder) {
                                    // Do nothing.
                                }
                            })
        };
        try {
            surfaceCreatedCountDownLatch.await()
        } catch (e: InterruptedException) {
            Log.w(javaClass.simpleName, "Interrupted waiting for debug surface.")
            Thread.currentThread().interrupt()
            return null
        }
        return surfaceView
    }


}