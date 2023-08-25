import 'package:custom_native_video_player_ios/src/video_info.dart';
import 'package:custom_native_video_player_ios/src/video_source.dart';
import 'package:flutter/services.dart';

class NativeVideoPlayerApi {
  final int viewId;
  final void Function() onPlaybackReady;
  final void Function() onPlaybackEnded;
  final void Function(String?) onError;
  late final MethodChannel _channel;

  NativeVideoPlayerApi({
    required this.viewId,
    required this.onPlaybackReady,
    required this.onPlaybackEnded,
    required this.onError,
  }) {
    final name = 'me.albemala.native_video_player.api.$viewId';
    _channel = MethodChannel(name);
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  void dispose() {
    _channel.setMethodCallHandler(null);
  }

  Future<dynamic> _handleMethodCall(MethodCall call) {
    switch (call.method) {
      case 'onPlaybackReady':
        onPlaybackReady();
      case 'onPlaybackEnded':
        onPlaybackEnded();
      case 'onError':
        // final errorCode = call.arguments['errorCode'] as int;
        // final errorMessage = call.arguments['errorMessage'] as String;
        final message = call.arguments as String;
        onError(message);
    }
    throw UnsupportedError('Unrecognized method ${call.method}');
  }

  Future<void> loadVideoSource(VideoSource videoSource) async {
    await _channel.invokeMethod<void>(
      'loadVideoSource',
      videoSource.toJson(),
    );
  }

  Future<VideoInfo?> getVideoInfo() async {
    final response = await _channel.invokeMethod<Map<Object?, Object?>>(
      'getVideoInfo',
    );
    if (response == null) return null;
    return VideoInfo.fromJson(Map<String, dynamic>.from(response));
  }

  Future<void> play() async {
    await _channel.invokeMethod<void>(
      'play',
    );
  }

  Future<void> pause() async {
    await _channel.invokeMethod<void>(
      'pause',
    );
  }

  Future<void> stop() async {
    await _channel.invokeMethod<void>(
      'stop',
    );
  }

  Future<bool?> isPlaying() async {
    return _channel.invokeMethod<bool?>(
      'isPlaying',
    );
  }

  Future<void> seekTo(int position) async {
    await _channel.invokeMethod<void>(
      'seekTo',
      position,
    );
  }

  Future<int?> getPlaybackPosition() async {
    return _channel.invokeMethod<int?>(
      'getPlaybackPosition',
    );
  }

  Future<void> setVolume(double volume) async {
    await _channel.invokeMethod<bool>(
      'setVolume',
      volume,
    );
  }

  Future<void> setPlaybackSpeed(double speed) async {
    await _channel.invokeMethod<bool>(
      'setPlaybackSpeed',
      speed,
    );
  }
}
