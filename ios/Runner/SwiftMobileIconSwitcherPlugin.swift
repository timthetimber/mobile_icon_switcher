// Importing the required libraries.
import Flutter
import UIKit

// Declaring a public class for the plugin that inherits from NSObject and implements the FlutterPlugin protocol.
public class SwiftMobileIconSwitcherPlugin: NSObject, FlutterPlugin {

  // The register method is called by the Flutter framework when the plugin is registered. 
  // It sets up a method channel for communication between the Dart and native code.
  public static func register(with registrar: FlutterPluginRegistrar) {
    
    // Creating a FlutterMethodChannel. The first argument is the name of the channel, 
    // and the second argument is the binary messenger that enables communication over the channel.
    let channel = FlutterMethodChannel(name: "app_icon_switcher", binaryMessenger: registrar.messenger())
    
    // Creating an instance of the plugin class.
    let instance = SwiftMobileIconSwitcherPlugin()
    
    // Setting the instance of the plugin class as the delegate for method calls coming over the channel.
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  // The handle method is called when a method call is received from the Dart side.
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
  
    // Checking if the method call is for the 'changeIcon' method.
    if call.method == "changeIcon" {

      // Try to cast arguments to a dictionary
      guard let args = call.arguments as? [String: Any] else {
          result(FlutterError(code: "INVALID_ARGUMENTS", message: "Arguments are not a dictionary", details: nil))
          return
      }

      // Guard clause checking if iconName was provided and if it is a string
      guard let iconName = args["iconName"] as? String else {
          result(FlutterError(code: "INVALID_ARGUMENTS", message: "Wrong iconName format", details: nil))
          return
      }

      // Checking if the device supports alternate app icons.
      if UIApplication.shared.supportsAlternateIcons {
      
        // Attempting to change the app icon.
        UIApplication.shared.setAlternateIconName(iconName) { error in
        
          // If there is an error, we send it back to the Dart side.
          if let error = error {
            result(FlutterError(code: "UNAVAILABLE", message: error.localizedDescription, details: nil))
          } 
          // If there is no error, we send true back to the Dart side to indicate success.
          else {
            result(true)
          }
        }
      } 
      // If the device does not support alternate app icons, we send an error back to the Dart side.
      else {
        result(FlutterError(code: "UNAVAILABLE", message: "Alternate icons not supported.", details: nil))
      }
    }
    else if call.method == "resetIcon" {
            // Checking if the device supports alternate app icons.
      if UIApplication.shared.supportsAlternateIcons {
      
        // Attempting to change the app icon.
        UIApplication.shared.setAlternateIconName(nil) { error in
        
          // If there is an error, we send it back to the Dart side.
          if let error = error {
            result(FlutterError(code: "UNAVAILABLE", message: error.localizedDescription, details: nil))
          } 
          // If there is no error, we send true back to the Dart side to indicate success.
          else {
            result(true)
          }
        }
      } 
      // If the device does not support alternate app icons, we send an error back to the Dart side.
      else {
        result(FlutterError(code: "UNAVAILABLE", message: "Alternate icons not supported.", details: nil))
      }
    }
  }
}
