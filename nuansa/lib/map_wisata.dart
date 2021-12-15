import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:here_sdk/mapview.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/routing.dart';
import 'package:nuansa/location/location_service.dart';
import 'package:nuansa/location/user_location.dart';

import 'models/wisata_model.dart';

class MapWisata extends StatefulWidget {
  const MapWisata({Key? key}) : super(key: key);

  @override
  _MapWisataState createState() => _MapWisataState();
}

class _MapWisataState extends State<MapWisata> {
  WisataModel _wisata = WisataModel("", "error.png", "error", "error", "error", "error", "error", 0, "error", 0, 0);
  HereMapController? _controller;
  MapPolyline? _mapPolyline;
  LocationService locationService = LocationService();
  double userLatitude = 0;
  double userLongitude = 0;

  @override
  void initState() {
    super.initState();
    // locationService.locationStream.listen((userLocation) {
    //   setState(() {
    //     userLatitude = userLocation.latitude;
    //     userLongitude = userLocation.longitude;
    //   });
    // });
  }

  @override
  void dispose() {
    locationService.dispose();
    _controller?.finalize();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    if (args.containsKey('wisata')) {
      _wisata = args['wisata'];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_wisata.nama),
        automaticallyImplyLeading: true,
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        )
      ),
      // body: HereMap(onMapCreated: _onMapCreated),
      body: StreamBuilder<UserLocation>(
        stream: locationService.locationStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data?.latitude != 0.0 && snapshot.data?.longitude != 0) {
              userLatitude = snapshot.data!.latitude;
              userLongitude = snapshot.data!.longitude;
              return HereMap(onMapCreated: _onMapCreated);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
      ),
    );
  }

  Future<void> drawMarker(HereMapController hereMapController, int drawOrder, GeoCoordinates geoCoordinates, String imageMarker, {double anchorHorizontal = 0.5, double anchorVertical = 0.5}) async {
    ByteData fileData = await rootBundle.load(imageMarker);
    Uint8List pixelData = fileData.buffer.asUint8List();
    MapImage mapImage = MapImage.withPixelDataAndImageFormat(pixelData, ImageFormat.png);

    Anchor2D anchor2d = Anchor2D.withHorizontalAndVertical(anchorHorizontal, anchorVertical);

    MapMarker mapMarker = MapMarker.withAnchor(geoCoordinates, mapImage, anchor2d);
    mapMarker.drawOrder = drawOrder;

    hereMapController.mapScene.addMapMarker(mapMarker);
  }

  Future<void> drawRoute(GeoCoordinates start, GeoCoordinates end, HereMapController hereMapController) async {
    RoutingEngine routingEngine = RoutingEngine();

    Waypoint startWayPoint = Waypoint.withDefaults(start);
    Waypoint endWayPoint = Waypoint.withDefaults(end);
    List<Waypoint> wayPoints = [startWayPoint, endWayPoint];

    routingEngine.calculateCarRoute(
      wayPoints, CarOptions.withDefaults(), (routingError, routes) {
        if (routingError == null) {
          var route = routes?.first;
          GeoPolyline routeGeoPolyline = GeoPolyline(route!.polyline);

          double depth = 20;
          _mapPolyline = MapPolyline(routeGeoPolyline, depth, Colors.blue);

          hereMapController.mapScene.addMapPolyline(_mapPolyline!);
        }
      }
    );
  }

  void _onMapCreated(HereMapController hereMapController) {
    _controller = hereMapController;
    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay, (MapError? error) {
      if (error != null) {
        print('Map scene not loaded. MapError: ${error.toString()}');
        return;
      }

      drawMarker(hereMapController, 0, GeoCoordinates(userLatitude, userLongitude), 'assets/images/markStart.png');
      drawMarker(hereMapController, 0, GeoCoordinates(_wisata.latitude, _wisata.longitude), 'assets/images/markEnd.png');
      drawMarker(hereMapController, 1, GeoCoordinates(_wisata.latitude, _wisata.longitude), 'assets/images/placeholder.png', anchorVertical: 1);
      drawRoute(GeoCoordinates(userLatitude, userLongitude), GeoCoordinates(_wisata.latitude, _wisata.longitude), hereMapController);

      const double distanceToEarthInMeters = 8000;
      hereMapController.camera.lookAtPointWithDistance(GeoCoordinates(userLatitude, userLongitude), distanceToEarthInMeters);
    });
  }
}