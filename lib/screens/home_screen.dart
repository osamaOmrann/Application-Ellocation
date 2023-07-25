import 'dart:async';

import 'package:application_ellocation/apis/apis.dart';
import 'package:application_ellocation/screens/home_side_menu.dart';
import 'package:application_ellocation/screens/search_result_screen.dart';
import 'package:application_ellocation/screens/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var formKey = GlobalKey<FormState>();
  final TextEditingController idController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print('\nUser: ${APIs.auth.currentUser}');
    getPermission();
    markers = {
      Marker(
          markerId: MarkerId('user_location'),
          position: LatLng(_locationData?.latitude ?? defLat,
              _locationData?.longitude ?? defLng))
    };
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  var defLat = 37.43296265331129;
  var defLng = -122.085749655962;
  late Set<Marker> markers;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height,
        width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/home_wallpaper.PNG'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: Drawer(
          child: HomeSideMenu(),
        ),
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Container(
                    padding: EdgeInsets.all(width * .01),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(width * 200)),
                    child: Icon(
                      Icons.menu,
                      color: Color(0xff81a969),
                      size: width * .07,
                    )),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Container(
                  padding: EdgeInsets.all(width * .015),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(width * .039)),
                  child: Image.asset('assets/images/icon.png')),
            ),
            SizedBox(
              width: width * .05,
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
            ),
            InkWell(
              onTap: () {
                showDialog<void>(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return Form(
                      key: formKey,
                      child: AlertDialog(
                        title: Text(AppLocalizations.of(context)!.enter_id),
                        content: TextFormField(
                          controller: idController,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return AppLocalizations.of(context)!.id_required;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.id),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text(AppLocalizations.of(context)!.go),
                            onPressed: () async {
                              if (formKey.currentState?.validate() == false) {
                                return;
                              }
                              var retrievedUser =
                                  await APIs.getFutureOfUserById(
                                      idController.text.toString());
                              Navigator.of(dialogContext).pop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => SearchResultScreen(
                                          idController.text.toString(),
                                          _controller,
                                          {
                                            Marker(
                                                markerId:
                                                    MarkerId('user_location'),
                                                position: LatLng(
                                                    retrievedUser!.lat,
                                                    retrievedUser.long))
                                          },
                                          retrievedUser.lat,
                                          retrievedUser.long)));
                            },
                          ),
                          TextButton(
                            child: Text(AppLocalizations.of(context)!.cancel),
                            onPressed: () {
                              Navigator.of(dialogContext)
                                  .pop(); // Dismiss alert dialog
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: height * .11,
                width: height * .11,
                decoration: BoxDecoration(
                    color: Color(0xff81a969),
                    borderRadius: BorderRadius.circular(width * .05)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.search,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: height * .015,
                    ),
                    Text(
                      AppLocalizations.of(context)!.find_a_device,
                      style:
                          TextStyle(color: Colors.white, fontSize: width * .03),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * .05,
            ),
            InkWell(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Settings())),
              child: Container(
                height: height * .11,
                width: height * .11,
                decoration: BoxDecoration(
                    color: Color(0xff81a969),
                    borderRadius: BorderRadius.circular(width * .05)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.settings_solid,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: height * .015,
                    ),
                    Text(
                      AppLocalizations.of(context)!.settings,
                      style:
                          TextStyle(color: Colors.white, fontSize: width * .03),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  LocationData? _locationData;
  Location location = new Location();

  void getPermission() async {
    var isLocationServiceEnabled = await isServiceEnabled();
    if (!isLocationServiceEnabled) return;
    var isPermissionEnabled = await isPermissionGranted();
    if (!isPermissionEnabled) return;
    _locationData = await location.getLocation();
    location.onLocationChanged.listen((LocationData currentLocation) {
      _locationData = currentLocation;
      APIs.updateLocation(_locationData?.latitude ?? defLat,
          _locationData?.longitude ?? defLng);
      var marker = Marker(
          markerId: MarkerId('user_location'),
          position: LatLng(_locationData?.latitude ?? defLat,
              _locationData?.longitude ?? defLng));
      markers.add(marker);
      setState(() {});
      animatedCamera(_locationData?.latitude ?? defLat,
          _locationData?.longitude ?? defLng);
      print(_locationData?.latitude);
      print(_locationData?.longitude);
    });
  }

  //Get Location Opened
  Future<bool> isServiceEnabled() async {
    bool _serviceEnabled;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    }
    return _serviceEnabled;
  }

  //Get Permission To Use Location
  Future<bool> isPermissionGranted() async {
    PermissionStatus _permissionGranted;
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    }
    return _permissionGranted == PermissionStatus.granted;
  }

  void animatedCamera(double lat, double lng) async {
    var cameraPosition = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 19,
    );
    final GoogleMapController controller = await _controller.future;
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

/*Future<void> executeAfterDelay() async {
    // Wait for 2 seconds
    await Future.delayed(Duration(seconds: 2));

    // Execute your function here
    print('Function executed after 2 seconds');
  }*/
}
