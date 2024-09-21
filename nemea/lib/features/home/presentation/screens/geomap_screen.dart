import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:nemea/core/config/config_dev.dart';
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
  String? codeName = null;
  String? area = null;
  String? description = null;
  int? capacity = null;

  late AnimatedMapController controller;

  @override
  // worst code worldwide
  void initState() {
    super.initState();
    controller = AnimatedMapController(
      vsync: this,
    );
    getGeoJson();
  }

  getGeoJson() async {
    var response = await http.get(
      Uri.parse(ConfigDev.API_URL + '/api/get-places/'),
      headers: {
        'Nemea-Api-Key': ConfigDev.APP_API_KEY,
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
                // Use the recommended flutter_map_cancellable_tile_provider package to
                // support the cancellation of loading tiles.
                //tileProvider: CancellableNetworkTileProvider(),
              ),
              MarkerLayer(markers: myGeoJson.markers),
            ],
          ),
          Positioned(
            right: 16,
            left: 16,
            bottom: 16,
            child: Visibility(
              visible: codeName != null,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Περιοχή: $area',
                      style: context.textStyles.body1,
                    ),
                    Text(
                      'Περιγραφή: $description',
                      style: context.textStyles.body1,
                    ),
                    Text(
                      'Χωρητικότητα: $capacity',
                      style: context.textStyles.body1,
                    ),
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
