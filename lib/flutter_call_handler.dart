import 'dart:async';

import 'package:flutter/services.dart';

class FlutterCallHandler {
  static const MethodChannel _channel =
      MethodChannel('com.example.followclient/call_handler');

  static Future<void> makeCall(String phoneNumber) async {
    await _channel.invokeMethod('makeCall', {'phoneNumber': phoneNumber});
  }
}
