package nd.flutter.plugins.gpu_video_filters

import android.content.Context
import android.graphics.BitmapFactory
import android.net.Uri
import android.os.Handler
import android.os.Looper.getMainLooper
import android.util.Log
import android.util.LongSparseArray
import androidx.media3.common.C
import androidx.media3.common.Effect
import androidx.media3.common.MediaItem
import androidx.media3.common.audio.AudioProcessor
import androidx.media3.effect.GlEffect
import androidx.media3.effect.RgbFilter
import androidx.media3.transformer.Composition
import androidx.media3.transformer.DefaultEncoderFactory
import androidx.media3.transformer.DefaultMuxer
import androidx.media3.transformer.EditedMediaItem
import androidx.media3.transformer.EditedMediaItemSequence
import androidx.media3.transformer.Effects
import androidx.media3.transformer.ExportException
import androidx.media3.transformer.ExportResult
import androidx.media3.transformer.ProgressHolder
import androidx.media3.transformer.TransformationRequest
import androidx.media3.transformer.Transformer
import com.google.common.collect.ImmutableList
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import java.io.File

class VideoFilterApiImpl(private val binding: FlutterPlugin.FlutterPluginBinding) : FilterMessages.FilterApi {
    var filters: LongSparseArray<DynamicTextureProcessor> = LongSparseArray()
    private var filterSequenceId: Long = 0
    private var transformerSequenceId: Long = 0

    override fun create(vertexShader: String, fragmentShader: String, defaults: MutableMap<String, Double>, arrays: MutableMap<String, DoubleArray>, texture: String?): Long {
        val processor = DynamicTextureProcessor(vertexShader, fragmentShader,
                defaults.mapValues { it.value.toFloat() },
                arrays.mapValues { el -> el.value.map { it.toFloat() }.toFloatArray() },
                texture)
        val filterId = filterSequenceId
        filterSequenceId++
        filters.put(filterId, processor)

        return filterId
    }

    override fun exportVideoFile(filterId: Long, asset: Boolean, input: String, output: String, format: String, period: Long): Long {
        val processor = filters[filterId]
        val mediaUri = if (asset) {
            val assetPath = binding.flutterAssets.getAssetFilePathByName(input)
            Uri.parse("asset:///$assetPath")
        } else {
            Uri.fromFile(File(input))
        }
        val transformerId = transformerSequenceId
        transformerSequenceId++
        val eventChannel = EventChannel(binding.binaryMessenger, "Transformer_$transformerId")
        val transform = createTransformer()

        val streamHandler = TransformerStreamHandler(transform, processor, mediaUri, output, period)
        eventChannel.setStreamHandler(streamHandler)
        return transformerId
    }


    override fun setFloatParameter(filterId: Long, key: String, value: Double) {
        val processor = filters[filterId]
        processor.setFloatUniform(key, value.toFloat())

    }

    override fun setFloatArrayParameter(filterId: Long, key: String, value: DoubleArray) {
        val array = value.map { it.toFloat() }.toFloatArray()
        val processor = filters[filterId]
        processor.setFloatsUniform(key, array)
    }

    override fun setBitmapParameter(filterId: Long, key: String, data: ByteArray) {
        val processor = filters[filterId]
        processor.setBitmap(key, BitmapFactory.decodeByteArray(data, 0, data.size))
    }

    override fun setBitmapSourceParameter(filterId: Long, key: String, asset: Boolean, path: String) {
        val processor = filters[filterId]
        if (asset) {
            val assetPath = binding.flutterAssets.getAssetFilePathByName(path)
            val stream = binding.applicationContext
                    .assets.open(assetPath)
            processor.setBitmap(key, BitmapFactory.decodeStream(stream))
        } else {
            processor.setBitmap(key, BitmapFactory.decodeFile(path))
        }
    }

    override fun dispose(filterId: Long) {
        val processor = filters[filterId]
        processor.dispose()
        filters.remove(filterId)
    }

    private fun createTransformer(): Transformer {
        val transformerBuilder = Transformer.Builder(binding.applicationContext)
        val requestBuilder = TransformationRequest.Builder()
        transformerBuilder
                .setTransformationRequest(requestBuilder.build())
                .setEncoderFactory(
                        DefaultEncoderFactory.Builder(binding.applicationContext)
                                .setEnableFallback(true)
                                .build())
        transformerBuilder.setMuxerFactory(
                DefaultMuxer.Factory( /* maxDelayBetweenSamplesMs= */C.TIME_UNSET))
        return transformerBuilder
                .build()
    }

}

class TransformerStreamHandler(private val transform: Transformer,
                               private var processor: DynamicTextureProcessor,
                               private val mediaUri: Uri,
                               private val outputPath: String,
                               private val period: Long) : EventChannel.StreamHandler, Transformer.Listener, Runnable {
    private var eventSink: EventChannel.EventSink? = null
    private val progressHolder: ProgressHolder = ProgressHolder()
    private val mainHandler: Handler = Handler(getMainLooper())

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
        transform.addListener(this)
        transform.start(createComposition(MediaItem.Builder().setUri(mediaUri).build()), outputPath)
        mainHandler.post(this)
    }

    override fun run() {
        if (transform.getProgress(progressHolder)
                != Transformer.PROGRESS_STATE_NOT_STARTED) {
            eventSink?.success(progressHolder.progress)
            mainHandler.postDelayed(this, period)
        }
    }

    override fun onCancel(arguments: Any?) {
        transform.removeListener(this)
        mainHandler.removeCallbacksAndMessages(null)
        transform.cancel()
        eventSink = null
    }

    private fun createComposition(mediaItem: MediaItem): Composition {
        val editedMediaItemBuilder = EditedMediaItem.Builder(mediaItem)

        val audioProcessors: ImmutableList<AudioProcessor> = ImmutableList.of()
        val videoEffects = ImmutableList.Builder<Effect>()
        videoEffects.add(
                GlEffect { _: Context?, useHdr: Boolean ->
                    processor.create(useHdr)
                })
        editedMediaItemBuilder
                .setRemoveAudio(false)
                .setRemoveVideo(false)
                .setFlattenForSlowMotion(false)
                .setEffects(Effects(audioProcessors, videoEffects.build()))

        val editedMediaItems: MutableList<EditedMediaItem> = ArrayList()
        editedMediaItems.add(editedMediaItemBuilder.build())
        val sequences: MutableList<EditedMediaItemSequence> = ArrayList()
        sequences.add(EditedMediaItemSequence(editedMediaItems))
        return Composition.Builder(sequences)
                .experimentalSetForceAudioTrack(false)
                .build()
    }

    override fun onCompleted(composition: Composition, exportResult: ExportResult) {
        eventSink?.endOfStream()
        mainHandler.removeCallbacksAndMessages(null)
    }

    override fun onError(composition: Composition, exportResult: ExportResult, exportException: ExportException) {
        eventSink?.error("gpu-video-filters", exportException.localizedMessage, exportException)
        mainHandler.removeCallbacksAndMessages(null)
    }
}
