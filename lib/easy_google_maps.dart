import 'dart:async';

import 'package:flutter/services.dart';

class EasyGoogleMaps {
  static const MethodChannel _channel =
      const MethodChannel('easy_google_maps');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
