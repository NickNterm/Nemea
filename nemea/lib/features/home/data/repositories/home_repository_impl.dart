import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:nemea/core/errors/failures.dart';
import 'package:nemea/core/network/network_info.dart';
import 'package:nemea/features/home/data/local_data/home_local_data_source.dart';
import 'package:nemea/features/home/data/models/update_fcm_token_model.dart';
import 'package:nemea/features/home/data/remote_data/home_remote_data_source.dart';
import 'package:nemea/features/home/domain/entities/amea.dart';
import 'package:nemea/features/home/domain/entities/camera_message.dart';
import 'package:nemea/features/home/domain/entities/machine.dart';
import 'package:nemea/features/home/domain/entities/manager.dart';
import 'package:nemea/features/home/domain/entities/meteo.dart';
import 'package:nemea/features/home/domain/entities/vardia.dart';
import 'package:nemea/features/home/domain/entities/volunteer.dart';
import 'package:nemea/features/home/domain/repositories/home_repository.dart';
import 'package:nemea/utils/either_typedef.dart';

import '../models/camera_message_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final NetworkInfo networkInfo;
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;

  HomeRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Stream<List<Meteo>> get $meteos => localDataSource.$meteos;

  @override
  FutureEither<List<Meteo>> getMeteo() async {
    _getMeteos();
    Timer.periodic(
      Duration(seconds: 50),
      (timer) async {
        await _getMeteos();
      },
    );
    return Left(ServerFailure());
  }

  Future<void> _getMeteos() async {
    if (await networkInfo.isConnected) {
      try {
        final meteosModels = await remoteDataSource.getMeteo();

        List<Meteo> meteos = Meteo.fromModelList(meteosModels);

        await localDataSource.saveMeteo(meteos);
      } catch (e) {
        _getMeteoFromLocal();
      }
    } else {
      _getMeteoFromLocal();
    }
  }

  FutureEither<List<Meteo>> _getMeteoFromLocal() async {
    try {
      final meteos = await localDataSource.getMeteo();
      return Right(meteos);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  FutureEither<int> getFWI() async {
    if (await networkInfo.isConnected) {
      try {
        final fwi = await remoteDataSource.getFWI();
        return Right(fwi);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  FutureEither<List<Amea>> getAmeas() async {
    try {
      final ameasModel = await remoteDataSource.getAmeas();
      List<Amea> ameas = Amea.fromModelList(ameasModel);
      return Right(ameas);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  FutureEither<List<Machine>> getMachines() async {
    try {
      final machinesModel = await remoteDataSource.getMachines();
      List<Machine> machines = Machine.fromModelList(machinesModel);
      return Right(machines);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  FutureEither<List<Manager>> getManagers() async {
    try {
      final managersModel = await remoteDataSource.getManagers();
      List<Manager> managers = Manager.fromModelList(managersModel);
      return Right(managers);
    } catch (e) {
      print('errror $e');
      return Left(ServerFailure());
    }
  }

  @override
  FutureEither<List<Vardia>> getVardias() async {
    try {
      String? email = FirebaseAuth.instance.currentUser!.email;
      if (email == null) return Left(ServerFailure());
      final vardiasModel = await remoteDataSource.getVardias(email);
      List<Vardia> vardias = Vardia.fromModelList(vardiasModel);
      return Right(vardias);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  FutureEither<List<Volunteer>> getVolunteers() async {
    try {
      final volunteersModel = await remoteDataSource.getVolunteers();
      List<Volunteer> volunteers = Volunteer.fromModelList(volunteersModel);
      return Right(volunteers);
    } catch (e) {
      print("error $e");
      return Left(ServerFailure());
    }
  }

  @override
  FutureEither<List<CameraMessage>> getCameraMessages() async {
    try {
      final BuiltList<CameraMessageModel> models =
          await remoteDataSource.getCameraMessages();
      List<CameraMessage> messages =
          models.map((e) => CameraMessage.fromModel(e)).toList();
      return Right(messages);
    } catch (e) {
      print("error $e");
      return Left(ServerFailure());
    }
  }

  @override
  Future<void> postFcm() async {
    var token = await FirebaseMessaging.instance.getToken();
    var email = await FirebaseAuth.instance.currentUser!.email;

    UpdateFcmTokenModel body = UpdateFcmTokenModel(
      (b) => b
        ..mail = email
        ..fcm = token,
    );
    if (token != null) {
      await remoteDataSource.postFcm(body);
    }
  }
}
