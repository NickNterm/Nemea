import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:nemea/app_config.dart';
import 'package:nemea/core/widgets/custom_app_bar.dart';
import 'package:nemea/utils/extensions/context.dart';

class GeomapManyScreen extends StatefulWidget {
  const GeomapManyScreen({super.key});

  @override
  State<GeomapManyScreen> createState() => _GeomapManyScreenState();
}

class _GeomapManyScreenState extends State<GeomapManyScreen>
    with TickerProviderStateMixin {
  GeoJsonParser myGeoJson = GeoJsonParser();
  List<dynamic> markerJson = [];
  String? codeName;
  String? area;
  String? description;
  int? capacity;

  late AnimatedMapController controller;
  Map<String, bool> markerFilters = {
    'tank': true,
    'hydrant': true,
    'flood': true,
  };

  @override
  void initState() {
    super.initState();
    controller = AnimatedMapController(
      vsync: this,
    );
    getGeoJson();
  }

  getGeoJson() async {
    var response = await http.get(
      Uri.parse(AppConfig.instance().apiEndPoint + '/api/get-all-markers/'),
      headers: {
        'Nemea-Api-Key': AppConfig.instance().appApiKey,
      },
    );
    if (response.statusCode == 200) {
      myGeoJson = GeoJsonParser(
        markerCreationCallback: (latlng, geoJsonPoint) {
          return _getMarker(latlng, geoJsonPoint);
        },
      );

      var jsons = jsonDecode(utf8.decode(response.bodyBytes));
      markerJson.addAll(jsons);

      for (var json in jsons) {
        print("HEELL $json");
        myGeoJson.parseGeoJson(json);
      }
    }
    setState(() {});
  }

  Marker _getMarker(LatLng latlng, Map<String, dynamic> geoJsonPoint) {
    String type = geoJsonPoint['Type'].toString().toLowerCase();
    for (String typeKey in markerFilters.keys) {
      if (type == typeKey && markerFilters[typeKey]!) {
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
            child: Image.asset('assets/images/$type.png'),
          ),
        );
      }
    }
    return Marker(
      point: LatLng(0, 0),
      child: Container(),
    );
  }

  void toggleMarkerFilter(String type) {
    setState(() {
      markerFilters[type] = !markerFilters[type]!;
    });
  }

  List<Marker> getFilteredMarkers() {
    myGeoJson = GeoJsonParser(
      markerCreationCallback: (latlng, geoJsonPoint) {
        return _getMarker(latlng, geoJsonPoint);
      },
    );

    for (var json in markerJson) {
      myGeoJson.parseGeoJson(json);
    }

    return myGeoJson.markers;
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
              MarkerLayer(
                markers: getFilteredMarkers(),
              ),
            ],
          ),
          Positioned(
            right: 16,
            left: 16,
            bottom: 36,
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
                    Visibility(
                      visible: description != null,
                      child: Text(
                        'Περιγραφή: $description',
                        style: context.textStyles.body1,
                      ),
                    ),
                    Visibility(
                      visible: capacity != null,
                      child: Text(
                        'Χωρητικότητα: $capacity',
                        style: context.textStyles.body1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Wrap(
              spacing: 10,
              children: [
                ElevatedButton(
                  onPressed: () => toggleMarkerFilter("tank"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: markerFilters["tank"] ?? true
                        ? context.palette.primaryColor
                        : Colors.grey,
                  ),
                  child: Text(
                    "Δεξαμενές",
                    style: context.textStyles.body2,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => toggleMarkerFilter("hydrant"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: markerFilters["hydrant"] ?? true
                        ? context.palette.primaryColor
                        : Colors.grey,
                  ),
                  child: Text(
                    "Κρούνοι",
                    style: context.textStyles.body2,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => toggleMarkerFilter("flood"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: markerFilters["flood"] ?? true
                        ? context.palette.primaryColor
                        : Colors.grey,
                  ),
                  child: Text(
                    "Σημεία πλημμυρα",
                    style: context.textStyles.body2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
