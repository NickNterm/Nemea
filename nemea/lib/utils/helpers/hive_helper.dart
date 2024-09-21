import 'dart:developer';
import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:nemea/features/home/domain/entities/meteo.dart';
import 'package:nemea/features/warnings/domain/entities/warning.dart';
import 'package:path_provider/path_provider.dart';

class HiveHelper {
  static Future<void> initHive() async {
    await Hive.initFlutter('Hive');
    _setupWarnings();
  }

  static Future<void> clearAll() async {
    try {
      await Hive.close();

      // Get the application's document directory
      var appDir = await getApplicationDocumentsDirectory();

      // Get the chosen sub-directory for Hive files
      var hiveDb = Directory('${appDir.path}/hive');

      if (hiveDb.existsSync()) {
        // Delete the Hive directory and all its files
        await hiveDb.delete(recursive: true);
      }
    } catch (e) {
      log('hive clearing error: $e');
    }
  }

  static void _setupWarnings() {
    Hive.registerAdapter(WarningAdapter());
    Hive.registerAdapter(MeteoAdapter());
  }
}

extension BoxExtensions on LazyBox {
  Stream<BoxEvent> watchWithInitial() {
    Future.delayed(Duration(milliseconds: 10), () async {
      List<Meteo> meteos = [];
      for (var key in keys) {
        meteos.add(await get(key));
      }
      clear();
      addAll(meteos);
    });
    return watch();
  }
}