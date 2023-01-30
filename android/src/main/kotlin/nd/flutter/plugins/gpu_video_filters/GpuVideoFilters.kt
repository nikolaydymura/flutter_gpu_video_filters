import android.net.Uri
import android.os.Handler
import android.os.Looper.getMainLooper
import android.util.Log
import android.util.LongSparseArray
import com.google.android.exoplayer2.MediaItem
import com.google.android.exoplayer2.transformer.*
import com.google.common.collect.ImmutableList
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import nd.flutter.plugins.gpu_video_filters.DynamicProcessor
import nd.flutter.plugins.gpu_video_filters.FilterMessages
import java.io.File

class VideoFilterApiImpl(private val binding: FlutterPlugin.FlutterPluginBinding) : FilterMessages.FilterApi {
    var filters: LongSparseArray<DynamicProcessor> = LongSparseArray();
    private var filterSequenceId: Long = 0
    private var transformerSequenceId: Long = 0
    override fun create(vertexShader: String, fragmentShader: String, defaults: MutableMap<String, Double>): Long {
        val processor = DynamicProcessor(vertexShader, fragmentShader, defaults)
        val filterId = filterSequenceId
        filterSequenceId++
        filters.put(filterId, processor)

        return filterId
    }

    override fun exportVideoFile(filterId: Long, asset: Boolean, input: String, output: String, format: String): Long {
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
        val transform = createTransformer(processor)

        val streamHandler = TransformerStreamHandler(transform, mediaUri, output)
        eventChannel.setStreamHandler(streamHandler)
        transform.getProgress(ProgressHolder())
        return transformerId
    }


    override fun setFloatParameter(filterId: Long, key: String, value: Double) {
        val processor = filters[filterId]
        processor.setFloatUniform(key, value.toFloat())
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

    private fun createTransformer(filter: DynamicProcessor): Transformer {
        val transformerBuilder = Transformer.Builder(binding.applicationContext)
        val requestBuilder = TransformationRequest.Builder()
        transformerBuilder
                .setTransformationRequest(requestBuilder.build())
                .setEncoderFactory(
                        DefaultEncoderFactory(
                                EncoderSelector.DEFAULT, true))
        val effects: ImmutableList.Builder<GlEffect> = ImmutableList.Builder()
        effects.add { filter }
        transformerBuilder.setVideoFrameEffects(effects.build())
        return transformerBuilder
                .build()
    }

}

class TransformerStreamHandler(private val transform: Transformer,
                               private val mediaUri: Uri,
                               private val outputPath: String) : EventChannel.StreamHandler, Transformer.Listener, Runnable {
    private var eventSink: EventChannel.EventSink? = null
    private val progressHolder: ProgressHolder = ProgressHolder()
    private val mainHandler: Handler = Handler(getMainLooper())

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
        transform.addListener(this)
        transform.startTransformation(MediaItem.Builder().setUri(mediaUri).build(), outputPath)
        mainHandler.post(this)
    }

    override fun run() {
        if (transform.getProgress(progressHolder)
                != Transformer.PROGRESS_STATE_NO_TRANSFORMATION) {
            eventSink?.success(progressHolder.progress)
            mainHandler.postDelayed(this, 1000)
        }
    }

    override fun onCancel(arguments: Any?) {
        transform.removeListener(this)
        mainHandler.removeCallbacksAndMessages(null)
        transform.cancel()
        eventSink = null
    }

    override fun onTransformationCompleted(inputMediaItem: MediaItem, transformationResult: TransformationResult) {
        Log.i(javaClass.simpleName, "onTransformationCompleted $outputPath $inputMediaItem")
        eventSink?.success(-100)
        eventSink?.endOfStream()
        mainHandler.removeCallbacksAndMessages(null)
    }

    override fun onTransformationError(inputMediaItem: MediaItem, exception: TransformationException) {
        Log.e(javaClass.simpleName, "onTransformationError $inputMediaItem", exception)
        eventSink?.error("gpu_video-filters", exception.localizedMessage, exception)
        mainHandler.removeCallbacksAndMessages(null)
    }
}
