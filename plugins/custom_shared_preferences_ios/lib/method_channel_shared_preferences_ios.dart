import 'dart:async';

import 'package:flutter/services.dart';

import 'shared_preferences_platform_interface_ios.dart';

const MethodChannel _kChannel = MethodChannel('plugins.flutter.io/shared_preferences_ios');

/// Wraps NSUserDefaults (on iOS)  providing a persistent store for simple data.
///
/// Data is persisted to disk asynchronously.
class MethodChannelSharedPreferencesStoreIOS extends SharedPreferencesStorePlatformIOS {
  final String? _suiteName;

  /// Instantiates a new `MethodChannelSharedPreferencesStore`.
  /// [suiteName] is only for iOS and allows to change underlying `NSUserDefaults`'`suiteName`.
  /// By default `null` which means the standard `NSUserDefaults` (read : no need to change anything for most users).
  MethodChannelSharedPreferencesStoreIOS({String? suiteName}) : _suiteName = suiteName;

  @override
  Future<bool> remove(String key) async {
    return (await _kChannel.invokeMethod<bool>(
      'remove',
      <String, dynamic>{'key': key, 'suiteName': _suiteName},
    ))!;
  }

  @override
  Future<bool> setValue(String valueType, String key, Object value) async {
    return (await _kChannel.invokeMethod<bool>(
      'set$valueType',
      <String, dynamic>{'key': key, 'value': value, 'suiteName': _suiteName},
    ))!;
  }

  @override
  Future<bool> clear() async {
    return (await _kChannel
        .invokeMethod<bool>('clear', <String, dynamic>{'suiteName': _suiteName}))!;
  }

  @override
  Future<Map<String, Object>> getAll() async {
    final preferences = await _kChannel
        .invokeMapMethod<String, Object>('getAll', <String, dynamic>{'suiteName': _suiteName});
    if (preferences == null) return <String, Object>{};

    return preferences;
  }

  @override
  Future<String?> getAppGroup() async {
    return _kChannel.invokeMethod<String?>('getAppGroup');
  }
}
