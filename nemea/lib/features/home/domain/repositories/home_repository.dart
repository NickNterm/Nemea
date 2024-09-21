import 'package:nemea/features/home/domain/entities/amea.dart';
import 'package:nemea/features/home/domain/entities/machine.dart';
import 'package:nemea/features/home/domain/entities/manager.dart';
import 'package:nemea/features/home/domain/entities/meteo.dart';
import 'package:nemea/features/home/domain/entities/vardia.dart';
import 'package:nemea/utils/either_typedef.dart';

import '../entities/camera_message.dart';
import '../entities/volunteer.dart';

abstract class HomeRepository {
  FutureEither<List<Meteo>> getMeteo();

  FutureEither<int> getFWI();

  Stream<List<Meteo>> get $meteos;

  FutureEither<List<Volunteer>> getVolunteers();

  FutureEither<List<Manager>> getManagers();

  FutureEither<List<Amea>> getAmeas();

  FutureEither<List<Machine>> getMachines();

  FutureEither<List<Vardia>> getVardias();

  FutureEither<List<CameraMessage>> getCameraMessages();

  Future<void> postFcm();
}
