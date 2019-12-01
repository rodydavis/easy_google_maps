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
          apiKey: 'YOUR_API_KEY_HERE',
          address: '1 Infinite Loop',
          title: 'Apple Campus',
        ),
      ),
    );
  }
}
