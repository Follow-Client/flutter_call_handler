package com.example.flutter_call_handler;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/** FlutterCallHandlerPlugin */
public class FlutterCallHandlerPlugin implements FlutterPlugin, MethodChannel.MethodCallHandler {
  private static final String CHANNEL = "com.example.followclient/call_handler";
  private MethodChannel channel;
  private Context context;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
    context = binding.getApplicationContext();
    channel = new MethodChannel(binding.getBinaryMessenger(), CHANNEL);
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
    if ("makeCall".equals(call.method)) {
      String phoneNumber = call.argument("phoneNumber");
      if (phoneNumber != null) {
        makePhoneCall(phoneNumber);
        result.success(null);
      } else {
        result.error("INVALID_ARGUMENT", "Phone number is required", null);
      }
    } else {
      result.notImplemented();
    }
  }

  private void makePhoneCall(String phoneNumber) {
    Intent intent = new Intent(Intent.ACTION_CALL);
    intent.setData(Uri.parse("tel:" + phoneNumber));
    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
    if (intent.resolveActivity(context.getPackageManager()) != null) {
      context.startActivity(intent);
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
