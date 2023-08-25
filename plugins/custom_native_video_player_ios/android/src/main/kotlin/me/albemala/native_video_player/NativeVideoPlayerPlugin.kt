package me.albemala.native_video_player

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin

class NativeVideoPlayerPlugin : FlutterPlugin {

    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        val factory = NativeVideoPlayerViewFactory(binding.binaryMessenger)
        binding.platformViewRegistry.registerViewFactory(NativeVideoPlayerViewFactory.id, factory)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    }
}
