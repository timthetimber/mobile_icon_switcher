library app_icon_switcher;

import 'dart:async';

import 'package:flutter/services.dart';

class AppIconSwitcher {
  static const MethodChannel _channel = MethodChannel('app_icon_switcher');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<bool> changeIcon(String iconName) async {
    final bool success =
        await _channel.invokeMethod('changeIcon', <String, dynamic>{
      'iconName': iconName,
    });
    return success;
  }
}
