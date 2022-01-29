import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tv/ui/widgets/platform.dart';

const kTvSize = Size(1920, 1080);

extension SubmitAction on RawKeyEvent {
  bool get hasSubmitIntent =>
      this is RawKeyDownEvent &&
      (logicalKey == LogicalKeyboardKey.select || logicalKey == LogicalKeyboardKey.enter);
}

extension ScreenSizeExtension on BuildContext {
  MediaQueryData get _mediaQueryData => MediaQuery.of(this);
  Size get screenSize => MyPlatform.isTv ? kTvSize : _mediaQueryData.size;
}
