import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_call_handler/flutter_call_handler.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    _checkPermission();
    super.initState();
  }
  static Future<bool> _checkPermission() async {
    var status = await Permission.phone.status;
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      status = await Permission.phone.request();
      return status.isGranted;
    }
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: ElevatedButton(onPressed: () {
            FlutterCallHandler.makeCall('+918238195885');
          }, child: Text("Make call")),
        ),
      ),
    );
  }
}
