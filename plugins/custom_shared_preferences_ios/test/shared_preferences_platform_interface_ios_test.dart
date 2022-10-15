import 'package:flutter_test/flutter_test.dart';
import 'package:custom_shared_preferences_ios/shared_preferences_platform_interface_ios.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group(SharedPreferencesStorePlatformIOS, () {
    test('disallows implementing interface', () {
      expect(
        () {
          SharedPreferencesStorePlatformIOS.instance = IllegalImplementation();
        },
        throwsAssertionError,
      );
    });
  });
}

class IllegalImplementation implements SharedPreferencesStorePlatformIOS {
  // Intentionally declare self as not a mock to trigger the
  // compliance check.
  @override
  bool get isMock => false;

  @override
  Future<bool> clear() {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, Object>> getAll() {
    throw UnimplementedError();
  }

  @override
  Future<bool> remove(String key) {
    throw UnimplementedError();
  }

  @override
  Future<bool> setValue(String valueType, String key, Object value) {
    throw UnimplementedError();
  }

  @override
  Future<String?> getAppGroup() {
    throw UnimplementedError();
  }
}
