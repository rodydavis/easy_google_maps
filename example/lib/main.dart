import 'package:easy_google_maps_example/api_key.dart';
import 'package:flutter/material.dart';
import 'package:easy_google_maps/easy_google_maps.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: EasyGoogleMaps(
          apiKey: kGoogleMapsApiKey,
          address: '1 Infinite Loop',
          title: 'Apple Campus',
        ),
      ),
    );
  }
}
