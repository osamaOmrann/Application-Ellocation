import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchResultScreen extends StatefulWidget {
  String id;
  Completer<GoogleMapController> _controller;
  CameraPosition _kGooglePlex;
  CameraPosition _kLake;
  Set<Marker> markers;

  SearchResultScreen(
      this.id, this._controller, this._kGooglePlex, this._kLake, this.markers);

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
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.location)),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: widget._kGooglePlex,
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
