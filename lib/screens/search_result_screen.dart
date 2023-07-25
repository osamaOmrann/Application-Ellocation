import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchResultScreen extends StatefulWidget {
  String id;
  Completer<GoogleMapController> _controller;
  Set<Marker> markers;
  double lat, lng;

  SearchResultScreen(
      this.id, this._controller, this.markers, this.lat, this.lng);

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  void initState() {
    super.initState();
    print(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(widget.lat, widget.lng),
      zoom: 14.4746,
    );
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.location)),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          widget._controller.complete(controller);
        },
        markers: widget.markers,
      ),
      /*floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),*/
    );
  }

  Future<void> _goToTheLake() async {}
}
