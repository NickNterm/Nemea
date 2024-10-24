import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nemea/app_config.dart';
import 'package:nemea/core/widgets/custom_app_bar.dart';
import 'package:nemea/utils/extensions/context.dart';

class GeomapScreen extends StatefulWidget {
  const GeomapScreen({super.key});

  @override
  State<GeomapScreen> createState() => _GeomapScreenState();
}

class _GeomapScreenState extends State<GeomapScreen>
    with TickerProviderStateMixin {
  GeoJsonParser myGeoJson = GeoJsonParser();
  String? codeName;
  String? area;
  String? description;
  int? capacity;
  bool hasmarker = false;

  late AnimatedMapController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimatedMapController(vsync: this);
    getGeoJson();
  }

  Future<void> getGeoJson() async {
    var response = await http.get(
      Uri.parse(AppConfig.instance().apiEndPoint + '/api/get-places/'),
      headers: {
        'Nemea-Api-Key': AppConfig.instance().appApiKey,
      },
    );

    if (response.statusCode == 200) {
      myGeoJson = GeoJsonParser(
        markerCreationCallback: (latlng, geoJsonPoint) {
          return Marker(
            alignment: Alignment.topCenter,
            rotate: true,
            width: 50.0,
            height: 50.0,
            point: latlng,
            child: GestureDetector(
              onTap: () {
                controller.animateTo(
                    dest: latlng, zoom: controller.mapController.camera.zoom);
                codeName = geoJsonPoint['Codename'];
                capacity = geoJsonPoint['Capacity'];
                area = geoJsonPoint['Area'];
                description = geoJsonPoint['Description'];
                setState(() {});
              },
              child: Image.asset('assets/images/place.png'),
            ),
          );
        },
      );
      myGeoJson.parseGeoJson(
        jsonDecode(utf8.decode(response.bodyBytes))[0],
      );
    }
    setState(() {});
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Request permission
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        LatLng userLocation = LatLng(position.latitude, position.longitude);

        // Move to user location and add marker
        controller.animateTo(dest: userLocation, zoom: 14.3);
        if (!hasmarker)
          myGeoJson.markers.add(
            Marker(
              point: userLocation,
              alignment: Alignment.topCenter,
              child: const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 40,
              ),
            ),
          );
        hasmarker = true;
        setState(() {});
      }
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Χάρτης',
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: controller.mapController,
            options: MapOptions(
              interactionOptions: InteractionOptions(),
              initialCenter: LatLng(37.8209242, 22.6596406),
              initialZoom: 14.3,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
              ),
              MarkerLayer(markers: myGeoJson.markers),
            ],
          ),
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                controller.animatedZoomIn();
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.add),
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 10,
            child: GestureDetector(
              onTap: () {
                controller.animatedZoomOut();
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.remove),
              ),
            ),
          ),
          Positioned(
            top: 90,
            right: 10,
            child: GestureDetector(
              onTap: _getCurrentLocation, // Call the location function
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.my_location), // User location icon
              ),
            ),
          ),
          Positioned(
            right: 16,
            left: 16,
            bottom: 16,
            child: Visibility(
              visible: codeName != null,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Περιοχή: $area', style: context.textStyles.body1),
                    Text('Περιγραφή: $description',
                        style: context.textStyles.body1),
                    Text('Χωρητικότητα: $capacity',
                        style: context.textStyles.body1),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
