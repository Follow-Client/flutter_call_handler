import 'dart:async';

import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class FlutterCallHandler {
  static const MethodChannel _channel =
      MethodChannel('com.example.followclient/call_handler');

  static Future<void> makeCall(String phoneNumber) async {
    try {
      final PermissionStatus permissionStatus =
      await Permission.phone.request();

      if (permissionStatus.isGranted) {
        try {
          await _channel.invokeMethod('makeCall', {'phoneNumber': phoneNumber});
        } on PlatformException catch (e) {
          print('Failed to make call: ${e.message}');
        }
      } else {
        throw 'Phone permission not granted';
      }
    } catch (e) {
      print('Failed to make call: ${e.toString()}');
    }

  }
}
