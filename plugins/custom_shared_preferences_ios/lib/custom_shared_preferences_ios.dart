// ignore_for_file: avoid_types_on_closure_parameters

import 'dart:async';

import 'shared_preferences_platform_interface_ios.dart';

/// Wraps NSUserDefaults (on iOS) providing a persistent store for simple data.
///
/// Data is persisted to disk asynchronously.
class CustomSharedPreferencesIOS {
  CustomSharedPreferencesIOS._(this._preferenceCache);

  static const String _prefix = 'flutter.';
  static Completer<CustomSharedPreferencesIOS>? _completer;

  static SharedPreferencesStorePlatformIOS get _store => SharedPreferencesStorePlatformIOS.instance;

  /// Loads and parses the [SharedPreferences] for this app from disk.
  ///
  /// Because this is reading from disk, it shouldn't be awaited in
  /// performance-sensitive blocks.
  static Future<CustomSharedPreferencesIOS> getInstance() async {
    if (_completer == null) {
      final completer = Completer<CustomSharedPreferencesIOS>();
      try {
        final preferencesMap = await _getCustomSharedPreferencesIOSMap();
        completer.complete(CustomSharedPreferencesIOS._(preferencesMap));
      } on Exception catch (e) {
        // If there's an error, explicitly return the future with an error.
        // then set the completer to null so we can retry.
        completer.completeError(e);
        final sharedPrefsFuture = completer.future;
        _completer = null;

        return sharedPrefsFuture;
      }
      _completer = completer;
    }

    return _completer!.future;
  }

  /// The cache that holds all preferences.
  ///
  /// It is instantiated to the current state of the SharedPreferences or
  /// NSUserDefaults object and then kept in sync via setter methods in this
  /// class.
  ///
  /// It is NOT guaranteed that this cache and the device prefs will remain
  /// in sync since the setter method might fail for any reason.
  final Map<String, Object> _preferenceCache;

  /// Returns all keys in the persistent storage.
  Set<String> getKeys() => Set<String>.from(_preferenceCache.keys);

  /// Reads a value of any type from persistent storage.
  Object? get(String key) => _preferenceCache[key];

  /// Reads a value from persistent storage, throwing an exception if it's not a
  /// bool.
  bool? getBool(String key) => _preferenceCache[key] as bool?;

  /// Reads a value from persistent storage, throwing an exception if it's not
  /// an int.
  int? getInt(String key) => _preferenceCache[key] as int?;

  /// Reads a value from persistent storage, throwing an exception if it's not a
  /// double.
  double? getDouble(String key) => _preferenceCache[key] as double?;

  /// Reads a value from persistent storage, throwing an exception if it's not a
  /// String.
  String? getString(String key) => _preferenceCache[key] as String?;

  /// Returns true if persistent storage the contains the given [key].
  bool containsKey(String key) => _preferenceCache.containsKey(key);

  /// Reads a set of string values from persistent storage, throwing an
  /// exception if it's not a string set.
  List<String>? getStringList(String key) {
    var list = _preferenceCache[key] as List<dynamic>?;
    if (list != null && list is! List<String>) {
      list = list.cast<String>().toList();
      _preferenceCache[key] = list;
    }
    // Make a copy of the list so that later mutations won't propagate
    return list?.toList() as List<String>?;
  }

  /// Saves a boolean [value] to persistent storage in the background.
  // ignore: avoid_positional_boolean_parameters
  Future<bool> setBool(String key, bool value) => _setValue('Bool', key, value);

  /// Saves an integer [value] to persistent storage in the background.
  Future<bool> setInt(String key, int value) => _setValue('Int', key, value);

  /// Saves a double [value] to persistent storage in the background.
  ///
  /// Android doesn't support storing doubles, so it will be stored as a float.
  Future<bool> setDouble(String key, double value) => _setValue('Double', key, value);

  /// Saves a string [value] to persistent storage in the background.
  Future<bool> setString(String key, String value) => _setValue('String', key, value);

  /// Saves a list of strings [value] to persistent storage in the background.
  Future<bool> setStringList(String key, List<String> value) => _setValue('StringList', key, value);

  /// Removes an entry from persistent storage.
  Future<bool> remove(String key) {
    final prefixedKey = '$_prefix$key';
    _preferenceCache.remove(key);

    return _store.remove(prefixedKey);
  }

  Future<bool> _setValue(String valueType, String key, Object value) {
    ArgumentError.checkNotNull(value, 'value');
    final prefixedKey = '$_prefix$key';
    if (value is List<String>) {
      // Make a copy of the list so that later mutations won't propagate
      _preferenceCache[key] = value.toList();
    } else {
      _preferenceCache[key] = value;
    }

    return _store.setValue(valueType, prefixedKey, value);
  }

  /// Always returns true.
  /// On iOS, synchronize is marked deprecated. On Android, we commit every set.
  // ignore: provide_deprecation_message
  @deprecated
  Future<bool> commit() async => true;

  /// Completes with true once the user preferences for the app has been cleared.
  Future<bool> clear() {
    _preferenceCache.clear();

    return _store.clear();
  }

  /// Fetches the latest values from the host platform.
  ///
  /// Use this method to observe modifications that were made in native code
  /// (without using the plugin) while the app is running.
  Future<void> reload() async {
    final preferences = await CustomSharedPreferencesIOS._getCustomSharedPreferencesIOSMap();
    _preferenceCache.clear();
    _preferenceCache.addAll(preferences);
  }

  Future<String?> getAppGroup() async {
    return _store.getAppGroup();
  }

  static Future<Map<String, Object>> _getCustomSharedPreferencesIOSMap() async {
    final fromSystem = await _store.getAll();

    // Strip the flutter. prefix from the returned preferences.
    final preferencesMap = <String, Object>{};
    // ignore: prefer_final_in_for_each
    for (var key in fromSystem.keys) {
      assert(key.startsWith(_prefix));
      preferencesMap[key.substring(_prefix.length)] = fromSystem[key]!;
    }

    return preferencesMap;
  }
}
