import 'dart:io';

import 'package:cigarKey/model/directionsModel.dart';
import 'package:cigarKey/utils/directions.dart';
import 'package:cigarKey/utils/fontSize.dart';
import 'package:cigarKey/widgets/GeneralHeader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_directions_api/google_directions_api.dart';
import 'package:map_launcher/map_launcher.dart' as map;

class MapPage extends StatefulWidget {
  MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

final _directionsService = DirectionsService();

final directionRequest = DirectionsRequest(
  origin: 'New York',
  destination: 'San Fransisco',
  travelMode: TravelMode.driving,
);

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;

  Marker? _destination;
  bool charged = false;

  Marker? _origin;

  Directions? _info;

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    // mapController.setMapStyle(
    //     '[{"featureType": "all","stylers": [{ "color": "#424242" }]},{"featureType": "road.arterial","elementType": "geometry","stylers": [{ "color": "#505050" }]},{"featureType": "landscape","elementType": "labels","stylers": [{ "visibility": "on" }]}]');
  }

  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.of(context).size.width;
    final heightSize = MediaQuery.of(context).size.height;
    final args = ModalRoute.of(context)?.settings.arguments as Map;

    final LatLng _center =
        LatLng(double.parse(args['Plat']), double.parse(args['Plng']));

    _addMarker(LatLng(args['Lat'], args['Lng']), args['Plat'], args['Plng'],
        args['Name'], args['Address']);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          GeneralHeader(heightSize * .2, 'Map'),
          Stack(
            children: [
              Container(
                height: heightSize * .65,
                width: widthSize,
                child: GoogleMap(
                  myLocationButtonEnabled: true,
                  // zoomControlsEnabled: true,
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 11.0,
                  ),
                  markers: {
                    if (charged) _origin!,
                    if (charged) _destination!,
                  },
                  polylines: {
                    if (_info != null)
                      Polyline(
                        polylineId: const PolylineId('overview_polyline'),
                        color: Color.fromRGBO(156, 27, 23, 1),
                        width: 5,
                        points: _info!.polylinePoints
                            .map((e) => LatLng(e.latitude, e.longitude))
                            .toList(),
                      )
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: heightSize * .02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromRGBO(0, 0, 0, 0.4)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () => {
                        mapController.animateCamera(
                          _info != null
                              ? CameraUpdate.newLatLngBounds(
                                  _info!.bounds, 100.0)
                              : CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                    target: _center,
                                    zoom: 11.0,
                                  ),
                                ),
                        ),
                      },
                      child: Text(
                        'See All Route',
                        textScaleFactor: Fonts().textSmall(context),
                        style: TextStyle(
                            fontFamily: 'Text', fontWeight: FontWeight.bold),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromRGBO(0, 0, 0, 0.4)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () => {
                        openGoogle(args['Lat'], args['Lng'], args['Name'],
                            args['Address'])
                      },
                      child: Text(
                        'Go to Directions',
                        textScaleFactor: Fonts().textSmall(context),
                        style: TextStyle(
                            fontFamily: 'Text', fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: heightSize * .05, horizontal: widthSize * .05),
            child: Container(
              width: widthSize * .9,
              height: heightSize * .12,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(79, 47, 14, 0.98),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: heightSize * .1,
                    width: widthSize * .25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: args["Image"] == ""
                        ? Image.asset('assets/logoCigarkey.png')
                        : Image.network(args["Image"]),
                  ),
                  Container(
                    width: widthSize * .6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          args["Name"],
                          textScaleFactor: Fonts().text(context),
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Title'),
                        ),
                        Text(
                          args["Address"],
                          textScaleFactor: Fonts().textSmall(context),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Color.fromRGBO(197, 169, 1, 1),
                              fontFamily: 'Text'),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _addMarker(LatLng pos, mylat, mylng, String name, String address) async {
    if (this.mounted) {
      setState(() {
        _origin = Marker(
            markerId: const MarkerId('origin'),
            infoWindow: const InfoWindow(title: 'You'),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            position: LatLng(double.parse(mylat.toString()),
                double.parse(mylng.toString())));

        _destination = Marker(
            markerId: const MarkerId('destination'),
            infoWindow: InfoWindow(title: name, snippet: address),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            position: pos);
      });
    }

    final directions = await DirectionsRepository()
        .getDirections(origin: _origin!.position, destination: pos);

    if (this.mounted) {
      setState(() => {_info = directions});
      charged = true;
    }
  }

  Future<void> openGoogle(
      double lat, double lng, String title, String desc) async {
    //MapsLauncher.launchCoordinates(lat, lng);
    // if (Platform.isIOS) {
    //   await map.MapLauncher.launchMap(
    //     mapType: map.MapType.apple,
    //     coords: map.Coords(lat, lng),
    //     title: "Shanghai Tower",
    //     description: "Asia's tallest building",
    //   );
    // } else {
    //   await map.MapLauncher.launchMap(
    //     mapType: map.MapType.google,
    //     coords: map.Coords(lat, lng),
    //     title: "Shanghai Tower",
    //     description: "Asia's tallest building",
    //   );
    // }
    final availableMaps = await map.MapLauncher.installedMaps;
    final coords = map.Coords(lat, lng);
    // print(
    //     availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

    // await availableMaps.first.showMarker(
    //   coords: map.Coords(lat, lng),
    //   title: "Shanghai Tower",
    //   description: "Asia's tallest building",
    // );
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  for (var map in availableMaps)
                    ListTile(
                      onTap: () => map.showMarker(
                        coords: coords,
                        title: title,
                        description: desc,
                      ),
                      title: Text(map.mapName),
                      leading: Image(
                        image: Svg(map.icon),
                        height: 30.0,
                        width: 30.0,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
