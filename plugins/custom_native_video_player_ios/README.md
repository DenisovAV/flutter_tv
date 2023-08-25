# native_video_player

[![Pub](https://img.shields.io/pub/v/native_video_player)](https://pub.dev/packages/native_video_player)

A Flutter widget to play videos on iOS and Android using a native implementation.

|             | Android | iOS  |
|:------------|:--------|:-----|
| **Support** | 16+     | 9.0+ |

<img src="https://raw.githubusercontent.com/albemala/native_video_player/main/screenshots/1.gif" width="320"/>
<img src="https://raw.githubusercontent.com/albemala/native_video_player/main/screenshots/2.gif" width="320"/>
<img src="https://raw.githubusercontent.com/albemala/native_video_player/main/screenshots/3.gif" width="320"/>

### Implementation

- On iOS, the video is displayed using a combination
  of [AVPlayer](https://developer.apple.com/documentation/avfoundation/avplayer)
  and [AVPlayerLayer](https://developer.apple.com/documentation/avfoundation/avplayerlayer).
- On Android, the video is displayed using a combination
  of [MediaPlayer](https://developer.android.com/guide/topics/media/mediaplayer)
  and [VideoView](https://developer.android.com/reference/android/widget/VideoView).

## Usage

### Loading a video

```dart
@override
Widget build(BuildContext context) {
  return NativeVideoPlayerView(
    onViewReady: (controller) async {
      final videoSource = await VideoSource.init(
        path: 'path/to/file',
        type: VideoSourceType,
      );
      await controller.loadVideoSource(videoSource);
    },
  );
}
```

### Listen to events

```dart
controller.onPlaybackReady.addListener(() {
  // Emitted when the video loaded successfully and it's ready to play.
  // At this point, videoInfo is available.
  final videoInfo = controller.videoInfo;
  final videoWidth = videoInfo.width;
  final videoHeight = videoInfo.height;
  final videoDuration = videoInfo.duration;
});
controller.onPlaybackStatusChanged.addListener(() {
  final playbackStatus = controller.playbackInfo.status;
  // playbackStatus can be playing, paused, or stopped. 
});
controller.onPlaybackPositionChanged.addListener(() {
  final playbackPosition = controller.playbackInfo.position;
});
controller.onPlaybackEnded.addListener(() {
  // Emitted when the video has finished playing.
});
```

### Autoplay

```dart
controller.onPlaybackReady.addListener(() {
  controller.play();
});
```

### Playback loop

```dart
controller.onPlaybackEnded.addListener(() {
  controller.play();
});
```

### Advanced usage

See the [example app](https://github.com/albemala/native_video_player/tree/main/example) for a complete usage example.

## Support this project

<a href="https://www.buymeacoffee.com/albemala" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>

## Other projects

🧰 **[exabox](https://exabox.app/)** — Essential tools for developers: All the tools you need in one single app.

😃 **[Ejimo](https://github.com/albemala/emoji-picker)** — Emoji and symbol picker

🗺️ **[WMap](https://wmap.albemala.me/)** — Create beautiful, minimal, custom map wallpapers and backgrounds for your phone or tablet.

🎨 **[iro‿iro](https://iro-iro.albemala.me/)** — Rearrange the colors to form beautiful patterns in this relaxing color puzzle game.

## Credits

Created by [@albemala](https://github.com/albemala) ([Twitter](https://twitter.com/albemala))
