import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:custom_shared_preferences_ios/method_channel_shared_preferences_ios.dart';
import 'package:custom_shared_preferences_ios/shared_preferences_platform_interface_ios.dart';

// ignore_for_file: omit_local_variable_types, unnecessary_await_in_return
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group(MethodChannelSharedPreferencesStoreIOS, () {
    const channel = MethodChannel(
      'plugins.flutter.io/shared_preferences_ios',
    );

    const Map<String, Object> kTestValues = <String, Object>{
      'flutter.String': 'hello world',
      'flutter.Bool': true,
      'flutter.Int': 42,
      'flutter.Double': 3.14159,
      'flutter.StringList': <String>['foo', 'bar'],
    };

    late InMemorySharedPreferencesStoreIOS testData;

    final List<MethodCall> log = <MethodCall>[];
    late MethodChannelSharedPreferencesStoreIOS store;

    setUp(() async {
      testData = InMemorySharedPreferencesStoreIOS.empty();

      // ignore: avoid_types_on_closure_parameters
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        log.add(methodCall);
        if (methodCall.method == 'getAll') {
          return await testData.getAll();
        }
        if (methodCall.method == 'remove') {
          final String key = methodCall.arguments['key'];
          return await testData.remove(key);
        }
        if (methodCall.method == 'clear') {
          return await testData.clear();
        }
        // ignore: unnecessary_raw_strings
        final RegExp setterRegExp = RegExp(r'set(.*)');
        final Match? match = setterRegExp.matchAsPrefix(methodCall.method);
        if (match?.groupCount == 1) {
          final String valueType = match!.group(1)!;
          final String key = methodCall.arguments['key'];
          final Object value = methodCall.arguments['value'];
          return await testData.setValue(valueType, key, value);
        }
        fail('Unexpected method call: ${methodCall.method}');
      });
      store = MethodChannelSharedPreferencesStoreIOS();
      log.clear();
    });

    tearDown(() async {
      await testData.clear();
    });

    test('getAll', () async {
      testData = InMemorySharedPreferencesStoreIOS.withData(kTestValues);
      expect(await store.getAll(), kTestValues);
      expect(log.single.method, 'getAll');
    });

    test('remove', () async {
      testData = InMemorySharedPreferencesStoreIOS.withData(kTestValues);
      expect(await store.remove('flutter.String'), true);
      expect(await store.remove('flutter.Bool'), true);
      expect(await store.remove('flutter.Int'), true);
      expect(await store.remove('flutter.Double'), true);
      expect(await testData.getAll(), <String, dynamic>{
        'flutter.StringList': <String>['foo', 'bar'],
      });

      expect(log, hasLength(4));
      // ignore: prefer_final_in_for_each
      for (MethodCall call in log) {
        expect(call.method, 'remove');
      }
    });

    test('setValue', () async {
      expect(await testData.getAll(), isEmpty);
      // ignore: prefer_final_in_for_each
      for (String key in kTestValues.keys) {
        final dynamic value = kTestValues[key];
        expect(await store.setValue(key.split('.').last, key, value), true);
      }
      expect(await testData.getAll(), kTestValues);

      expect(log, hasLength(5));
      expect(log[0].method, 'setString');
      expect(log[1].method, 'setBool');
      expect(log[2].method, 'setInt');
      expect(log[3].method, 'setDouble');
      expect(log[4].method, 'setStringList');
    });

    test('clear', () async {
      testData = InMemorySharedPreferencesStoreIOS.withData(kTestValues);
      expect(await testData.getAll(), isNotEmpty);
      expect(await store.clear(), true);
      expect(await testData.getAll(), isEmpty);
      expect(log.single.method, 'clear');
    });
  });
}
