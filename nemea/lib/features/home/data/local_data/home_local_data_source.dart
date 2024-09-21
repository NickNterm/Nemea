import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:nemea/core/errors/exceptions.dart';
import 'package:nemea/features/home/domain/entities/meteo.dart';

const METEO_BOX = 'meteo';

abstract class HomeLocalDataSource {
  Future<List<Meteo>> getMeteo();
  Future<List<Meteo>> saveMeteo(List<Meteo> meteos);

  Stream<List<Meteo>> get $meteos;
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  late Box<Meteo> meteoBox;
  @override
  Future<List<Meteo>> getMeteo() async {
    meteoBox = await Hive.openBox(METEO_BOX);
    List<Meteo> meteos = [];

    if (meteoBox.keys.isEmpty) throw ServerException();

    meteoBox.keys.forEach((element) async {
      Meteo? meteo = await meteoBox.get(element);
      meteos.add(meteo!);
    });

    return meteos;
  }

  @override
  Future<List<Meteo>> saveMeteo(List<Meteo> meteos) async {
    meteoBox = await Hive.openBox(METEO_BOX);
    await meteoBox.clear();

    meteos.forEach((element) async {
      await meteoBox.add(element);
    });

    return meteos;
  }

  @override
  Stream<List<Meteo>> get $meteos async* {
    try {
      meteoBox = await Hive.openBox<Meteo>(METEO_BOX);

      yield await _getItems(meteoBox);

      StreamController<List<Meteo>> streamcontroller = StreamController();
      Future.delayed(Duration(milliseconds: 10), () {
        final meteos = meteoBox.values.toList();
        meteos.clear();
        meteos.addAll(meteos);
      });
      meteoBox.watch().listen(
        (event) {
          streamcontroller.add(meteoBox.values.toList());
        },
      );

      yield* streamcontroller.stream;
    } catch (e) {
      meteoBox.clear();
    }
  }

  Future<List<Meteo>> _getItems(Box box) async {
    List<Meteo> meteos = [];
    for (var key in box.keys) {
      meteos.add(await box.get(key));
    }
    return meteos;
  }
}
