import 'package:flutter/services.dart';

class PlatformChannel {
  static const MethodChannel _channel = MethodChannel('plugins.zego.im/zego_texture_renderer_controller_event_handler');

  static void initialize() {
    _channel.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case 'methodName':
        // Ensure this runs on the main thread
          return await _handleMethodName(call.arguments);
        default:
          throw MissingPluginException();
      }
    });
  }

  static Future<void> _handleMethodName(dynamic arguments) async {
    // Handle the method call and ensure it runs on the main thread
    await Future.delayed(Duration.zero); // Ensure it runs in the next frame
    // Your code to handle the arguments
  }
}
