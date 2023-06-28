import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_icon_switcher/mobile_icon_switcher.dart';

void main() {
  const testChannel = MethodChannel('app_icon_switcher');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(testChannel, (call) async {
      switch (call.method) {
        case 'getPlatformVersion':
          return '1.0.0';
        case 'changeIcon':
          return true;
        case 'defaultComponent':
          return true;
        default:
          return null;
      }
    });
  });

  tearDown(() {
    testChannel.setMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await MobileIconSwitcher.platformVersion, '1.0.0');
  });

  test('changeIcon', () async {
    expect(await MobileIconSwitcher.changeIcon('icon1', 'alias1'), true);
  });

  test('setDefaultComponent', () async {
    expect(
        await MobileIconSwitcher.setDefaultComponent(
            'com.example.example.MainActivity'),
        true);
  });
}
