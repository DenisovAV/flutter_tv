package me.albemala.native_video_player.platform_interface

import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

interface NativeVideoPlayerApiDelegate {
    fun loadVideoSource(videoSource: VideoSource)
    fun getVideoInfo(): VideoInfo
    fun getPlaybackPosition(): Int
    fun play()
    fun pause()
    fun stop()
    fun isPlaying(): Boolean
    fun seekTo(position: Int)
    fun setPlaybackSpeed(speed: Double)
    fun setVolume(volume: Double)
}

const val invalidArgumentsErrorCode = "invalid_argument"
const val invalidArgumentsErrorMessage = "Invalid arguments"

class NativeVideoPlayerApi(
    messenger: BinaryMessenger,
    viewId: Int
) : MethodChannel.MethodCallHandler {

    var delegate: NativeVideoPlayerApiDelegate? = null

    private val channel: MethodChannel

    init {
        val name = "me.albemala.native_video_player.api.${viewId}"
        channel = MethodChannel(messenger, name)
        channel.setMethodCallHandler(this)
    }

    fun dispose() {
        channel.setMethodCallHandler(null)
    }

    fun onPlaybackReady() {
        channel.invokeMethod("onPlaybackReady", null)
    }

    fun onPlaybackEnded() {
        channel.invokeMethod("onPlaybackEnded", null)
    }

    fun onError(error: Error) {
        channel.invokeMethod("onError", error.message)
    }

    override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {
        when (methodCall.method) {
            "loadVideoSource" -> {
                val videoSourceAsMap = methodCall.arguments as? Map<*, *>
                    ?: return result.error(invalidArgumentsErrorCode, invalidArgumentsErrorMessage, null)
                val videoSource = VideoSource.from(videoSourceAsMap)
                    ?: return result.error(invalidArgumentsErrorCode, invalidArgumentsErrorMessage, null)
                delegate?.loadVideoSource(videoSource)
                result.success(null)
            }
            "getVideoInfo" -> {
                result.success(delegate?.getVideoInfo()?.toMap())
            }
            "getPlaybackPosition" -> {
                result.success(delegate?.getPlaybackPosition())
            }
            "play" -> {
                delegate?.play()
                result.success(null)
            }
            "pause" -> {
                delegate?.pause()
                result.success(null)
            }
            "stop" -> {
                delegate?.stop()
                result.success(null)
            }
            "isPlaying" -> {
                val playing = delegate?.isPlaying()
                result.success(playing)
            }
            "seekTo" -> {
                val position = methodCall.arguments as? Int
                    ?: return result.error(invalidArgumentsErrorCode, invalidArgumentsErrorMessage, null)
                delegate?.seekTo(position)
                result.success(null)
            }
            "setPlaybackSpeed" -> {
                val speed = methodCall.arguments as? Double
                    ?: return result.error(invalidArgumentsErrorCode, invalidArgumentsErrorMessage, null)
                delegate?.setPlaybackSpeed(speed)
                result.success(null)
            }
            "setVolume" -> {
                val volume = methodCall.arguments as? Double
                    ?: return result.error(invalidArgumentsErrorCode, invalidArgumentsErrorMessage, null)
                delegate?.setVolume(volume)
                result.success(null)
            }
            else -> {
                result.notImplemented()
            }
        }
    }
}
