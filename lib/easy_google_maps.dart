import 'dart:async';

import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EasyGoogleMaps extends StatefulWidget {
  final String title;
  final String address;
  final num width, height;
  final String apiKey;

  const EasyGoogleMaps({
    Key key,
    @required this.address,
    @required this.title,
    @required this.apiKey,
    this.height,
    this.width,
  }) : super(key: key);
  @override
  _EasyGoogleMapsState createState() => _EasyGoogleMapsState();
}

class _EasyGoogleMapsState extends State<EasyGoogleMaps> {
  Completer<GoogleMapController> _controller = Completer();
  final geo = Geolocator();

  @override
  void didUpdateWidget(EasyGoogleMaps oldWidget) {
    if (oldWidget.address != widget.address) {
      if (kIsWeb) {
        if (mounted) setState(() {});
      } else {
        _goToLoc(widget.address);
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  Future _goToLoc(String address) async {
    final GoogleMapController controller = await _controller.future;
    final _places = await geo.placemarkFromAddress(address);
    if (_places != null && _places.isNotEmpty) {
      final _place = _places?.first;
      final _latLang = LatLng(
        _place.position.latitude,
        _place.position.longitude,
      );
      controller.animateCamera(
        CameraUpdate.newCameraPosition(_getPos(_latLang)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      final _src =
          'https://www.google.com/maps/embed/v1/place?key=${widget.apiKey}&q=${widget.address.replaceAll(' ', '+')}';
      return EasyWebView(
        src: _src,
        webAllowFullScreen: true,
        width: widget?.width,
        height: widget?.height,
      );
    }

    return SizedBox(
      width: widget?.width,
      height: widget?.height,
      child: FutureBuilder<List<Placemark>>(
        future: geo.placemarkFromAddress(widget.address),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            final _place = snapshot?.data?.first;
            if (_place == null) {
              return Center(
                child: Text('Address not found!'),
              );
            }
            final _latLang = LatLng(
              _place.position.latitude,
              _place.position.longitude,
            );
            final _marker = Marker(
              markerId: MarkerId(widget.address.toString()),
              position: _latLang,
              infoWindow: InfoWindow(
                title: widget?.title ?? '',
                snippet: widget.address,
              ),
            );
            return GoogleMap(
              myLocationEnabled: true,
              mapType: MapType.hybrid,
              initialCameraPosition: _getPos(_latLang),
              onMapCreated: (controller) {
                _controller.complete(controller);
              },
              markers: {_marker},
            );
          }
          return Center(
            child: Text('Loading Address..'),
          );
        },
      ),
    );
  }

  CameraPosition _getPos(LatLng _latLang) {
    return CameraPosition(
      target: _latLang,
      zoom: 14.4746,
    );
  }
}
