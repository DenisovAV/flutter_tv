import 'dart:async';
import 'package:flutter/services.dart';

Future<bool> simulateKeyEvent(PhysicalKeyboardKey key, {required bool isDown}) async {
  final keyMessage = <String, dynamic>{
    'type': isDown ? 'keydown' : 'keyup',
    'keymap': 'ios',
    'keyCode': kIosToPhysicalKey.keys
        .firstWhere((iosKey) => kIosToPhysicalKey[iosKey]!.usbHidUsage == key.usbHidUsage),
  };
  final result = Completer<bool>();
  ServicesBinding.instance.channelBuffers
      .push(SystemChannels.keyEvent.name, SystemChannels.keyEvent.codec.encodeMessage(keyMessage),
          (data) {
    if (data == null) {
      result.complete(false);
      return;
    }
    final decoded = SystemChannels.keyEvent.codec.decodeMessage(data) as Map<String, dynamic>;
    result.complete(decoded['handled'] as bool);
  });
  return result.future;
}
