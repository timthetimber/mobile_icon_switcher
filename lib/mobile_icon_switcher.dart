library mobile_icon_switcher;

import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class MobileIconSwitcher {
  static const MethodChannel _channel = MethodChannel('app_icon_switcher');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// This function changes the app icon and returns a boolean indicating whether the operation was
  /// successful or not.
  ///
  /// Args:
  ///   iconName (String): A string representing the name of the new app icon that you want to change to.
  ///   iconActivityAlias (String): `iconActivityAlias` is a string parameter that represents the activity
  /// alias name of the launcher icon that you want to change. An activity alias is an alternate entry
  /// point into an activity that allows you to provide different labels, icons, and intents for the same
  /// underlying activity. In this case, the `
  ///
  /// Returns:
  ///   A `Future<bool>` is being returned.
  static Future<bool> changeIcon(
      String iconName, String iconActivityAlias) async {
    final bool success =
        await _channel.invokeMethod('changeIcon', <String, dynamic>{
      'iconName': iconName,
      'iconActivityAlias': iconActivityAlias,
    });
    return success;
  }

  /// This function sets the default component for Android and returns a boolean indicating success.
  ///
  /// Args:
  ///   defaultComponent (String): The `defaultComponent` parameter is a string that represents the
  /// package name and class name of the default activity to launch when the app is opened. This method
  /// is used to set the default component for an Android app.
  /// `com.example.example.MainActivity
  ///
  /// Returns:
  ///   The function `setDefaultComponent` returns a `Future<bool>`. If the platform is Android, it
  /// invokes a method named `defaultComponent` with a `Map` parameter containing a `String` key
  /// `component` and the value of `defaultComponent`. The method returns a `bool` value indicating
  /// whether the operation was successful or not. If the platform is not Android, the function returns
  /// `true
  static Future<bool> setDefaultComponent(String defaultComponent) async {
    if (Platform.isAndroid) {
      final bool success =
          await _channel.invokeMethod('defaultComponent', <String, dynamic>{
        'component': defaultComponent,
      });
      return success;
    }
    return true;
  }

  /// The function `resetIcon` is a static method in Dart that invokes a platform-specific method called
  /// 'resetIcon'. This call will reset the App's Icon to the default value.
  ///
  /// For IOS:
  ///   There is an actual reset, so I do a real reset
  ///
  /// For Android:
  ///   I only set the defaultComponent to put the app in the state it
  ///   was before.
  ///
  /// Returns:
  ///   The method is returning a Future<bool> value, which states if the reset
  ///   was successful or not.
  static Future<bool> resetIcon() async {
    final bool success = await _channel.invokeMethod('resetIcon', null);
    return success;
  }
}
