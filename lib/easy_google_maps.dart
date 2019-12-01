import 'dart:async';

import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const kGoogleMapsKey = 'YOUR_API_KEY_HERE';

class MapsView extends StatefulWidget {
  final String title;
  final String query;
  final num width, height;

  const MapsView({
    Key key,
    @required this.query,
    @required this.title,
    this.height,
    this.width,
  }) : super(key: key);
  @override
  _MapsViewState createState() => _MapsViewState();
}

class _MapsViewState extends State<MapsView> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      final _src =
          'https://www.google.com/maps/embed/v1/place?key=$kGoogleMapsKey&q=${widget.query.replaceAll(' ', '+')}';
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
        future:
            Geolocator().placemarkFromAddress("Gronausestraat 710, Enschede"),
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
              markerId: MarkerId(widget.query.toString()),
              position: _latLang,
              infoWindow: InfoWindow(
                title: widget?.title ?? '',
                snippet: widget.query,
              ),
            );
            return GoogleMap(
              myLocationEnabled: true,
              mapType: MapType.hybrid,
              initialCameraPosition: CameraPosition(
                target: _latLang,
                zoom: 14.4746,
              ),
              onMapCreated: (controller) {
                _controller.complete(controller);
              },
              markers: {_marker},
            );
          }
          return LoadingView(
            message: 'Loading Address..',
          );
        },
      ),
    );
  }
}
