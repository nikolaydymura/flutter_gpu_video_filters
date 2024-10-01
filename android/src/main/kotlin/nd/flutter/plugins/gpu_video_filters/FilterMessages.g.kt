// Copyright 2022
// Autogenerated from Pigeon (v22.4.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon
@file:Suppress("UNCHECKED_CAST", "ArrayInDataClass")

package nd.flutter.plugins.gpu_video_filters

import android.util.Log
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MessageCodec
import io.flutter.plugin.common.StandardMessageCodec
import java.io.ByteArrayOutputStream
import java.nio.ByteBuffer

private fun wrapResult(result: Any?): List<Any?> {
  return listOf(result)
}

private fun wrapError(exception: Throwable): List<Any?> {
  return if (exception is FlutterError) {
    listOf(
      exception.code,
      exception.message,
      exception.details
    )
  } else {
    listOf(
      exception.javaClass.simpleName,
      exception.toString(),
      "Cause: " + exception.cause + ", Stacktrace: " + Log.getStackTraceString(exception)
    )
  }
}

/**
 * Error class for passing custom error details to Flutter via a thrown PlatformException.
 * @property code The error code.
 * @property message The error message.
 * @property details The error details. Must be a datatype supported by the api codec.
 */
class FlutterError (
  val code: String,
  override val message: String? = null,
  val details: Any? = null
) : Throwable()
private open class FilterMessagesPigeonCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return     super.readValueOfType(type, buffer)
  }
  override fun writeValue(stream: ByteArrayOutputStream, value: Any?)   {
    super.writeValue(stream, value)
  }
}

/** Generated interface from Pigeon that represents a handler of messages from Flutter. */
interface FilterApi {
  fun create(vertexShader: String, fragmentShader: String, defaults: Map<String, Double>, arrays: Map<String, DoubleArray>, texture: String?): Long
  fun exportVideoFile(filterId: Long, asset: Boolean, input: String, output: String, format: String, period: Long): Long
  fun setFloatParameter(filterId: Long, key: String, value: Double)
  fun setFloatArrayParameter(filterId: Long, key: String, value: DoubleArray)
  fun setBitmapParameter(filterId: Long, key: String, data: ByteArray)
  fun setBitmapSourceParameter(filterId: Long, key: String, asset: Boolean, path: String)
  fun dispose(filterId: Long)

  companion object {
    /** The codec used by FilterApi. */
    val codec: MessageCodec<Any?> by lazy {
      FilterMessagesPigeonCodec()
    }
    /** Sets up an instance of `FilterApi` to handle messages through the `binaryMessenger`. */
    @JvmOverloads
    fun setUp(binaryMessenger: BinaryMessenger, api: FilterApi?, messageChannelSuffix: String = "") {
      val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_gpu_video_filters.FilterApi.create$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val vertexShaderArg = args[0] as String
            val fragmentShaderArg = args[1] as String
            val defaultsArg = args[2] as Map<String, Double>
            val arraysArg = args[3] as Map<String, DoubleArray>
            val textureArg = args[4] as String?
            val wrapped: List<Any?> = try {
              listOf(api.create(vertexShaderArg, fragmentShaderArg, defaultsArg, arraysArg, textureArg))
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_gpu_video_filters.FilterApi.exportVideoFile$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val filterIdArg = args[0] as Long
            val assetArg = args[1] as Boolean
            val inputArg = args[2] as String
            val outputArg = args[3] as String
            val formatArg = args[4] as String
            val periodArg = args[5] as Long
            val wrapped: List<Any?> = try {
              listOf(api.exportVideoFile(filterIdArg, assetArg, inputArg, outputArg, formatArg, periodArg))
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_gpu_video_filters.FilterApi.setFloatParameter$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val filterIdArg = args[0] as Long
            val keyArg = args[1] as String
            val valueArg = args[2] as Double
            val wrapped: List<Any?> = try {
              api.setFloatParameter(filterIdArg, keyArg, valueArg)
              listOf(null)
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_gpu_video_filters.FilterApi.setFloatArrayParameter$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val filterIdArg = args[0] as Long
            val keyArg = args[1] as String
            val valueArg = args[2] as DoubleArray
            val wrapped: List<Any?> = try {
              api.setFloatArrayParameter(filterIdArg, keyArg, valueArg)
              listOf(null)
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_gpu_video_filters.FilterApi.setBitmapParameter$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val filterIdArg = args[0] as Long
            val keyArg = args[1] as String
            val dataArg = args[2] as ByteArray
            val wrapped: List<Any?> = try {
              api.setBitmapParameter(filterIdArg, keyArg, dataArg)
              listOf(null)
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_gpu_video_filters.FilterApi.setBitmapSourceParameter$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val filterIdArg = args[0] as Long
            val keyArg = args[1] as String
            val assetArg = args[2] as Boolean
            val pathArg = args[3] as String
            val wrapped: List<Any?> = try {
              api.setBitmapSourceParameter(filterIdArg, keyArg, assetArg, pathArg)
              listOf(null)
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_gpu_video_filters.FilterApi.dispose$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val filterIdArg = args[0] as Long
            val wrapped: List<Any?> = try {
              api.dispose(filterIdArg)
              listOf(null)
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
    }
  }
}
/** Generated interface from Pigeon that represents a handler of messages from Flutter. */
interface VideoPreviewApi {
  fun create(): Long
  fun connect(textureId: Long, filterId: Long, embedded: Boolean)
  fun disconnect(textureId: Long, embedded: Boolean)
  fun setSource(textureId: Long, path: String, asset: Boolean, embedded: Boolean)
  fun resume(textureId: Long, embedded: Boolean)
  fun pause(textureId: Long, embedded: Boolean)
  fun dispose(textureId: Long, embedded: Boolean)

  companion object {
    /** The codec used by VideoPreviewApi. */
    val codec: MessageCodec<Any?> by lazy {
      FilterMessagesPigeonCodec()
    }
    /** Sets up an instance of `VideoPreviewApi` to handle messages through the `binaryMessenger`. */
    @JvmOverloads
    fun setUp(binaryMessenger: BinaryMessenger, api: VideoPreviewApi?, messageChannelSuffix: String = "") {
      val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_gpu_video_filters.VideoPreviewApi.create$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            val wrapped: List<Any?> = try {
              listOf(api.create())
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_gpu_video_filters.VideoPreviewApi.connect$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val textureIdArg = args[0] as Long
            val filterIdArg = args[1] as Long
            val embeddedArg = args[2] as Boolean
            val wrapped: List<Any?> = try {
              api.connect(textureIdArg, filterIdArg, embeddedArg)
              listOf(null)
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_gpu_video_filters.VideoPreviewApi.disconnect$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val textureIdArg = args[0] as Long
            val embeddedArg = args[1] as Boolean
            val wrapped: List<Any?> = try {
              api.disconnect(textureIdArg, embeddedArg)
              listOf(null)
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_gpu_video_filters.VideoPreviewApi.setSource$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val textureIdArg = args[0] as Long
            val pathArg = args[1] as String
            val assetArg = args[2] as Boolean
            val embeddedArg = args[3] as Boolean
            val wrapped: List<Any?> = try {
              api.setSource(textureIdArg, pathArg, assetArg, embeddedArg)
              listOf(null)
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_gpu_video_filters.VideoPreviewApi.resume$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val textureIdArg = args[0] as Long
            val embeddedArg = args[1] as Boolean
            val wrapped: List<Any?> = try {
              api.resume(textureIdArg, embeddedArg)
              listOf(null)
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_gpu_video_filters.VideoPreviewApi.pause$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val textureIdArg = args[0] as Long
            val embeddedArg = args[1] as Boolean
            val wrapped: List<Any?> = try {
              api.pause(textureIdArg, embeddedArg)
              listOf(null)
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_gpu_video_filters.VideoPreviewApi.dispose$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val textureIdArg = args[0] as Long
            val embeddedArg = args[1] as Boolean
            val wrapped: List<Any?> = try {
              api.dispose(textureIdArg, embeddedArg)
              listOf(null)
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
    }
  }
}
