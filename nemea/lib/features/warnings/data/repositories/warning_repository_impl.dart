import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:nemea/core/errors/failures.dart';
import 'package:nemea/core/network/network_info.dart';
import 'package:nemea/features/warnings/data/local_data/warning_local_data.dart';
import 'package:nemea/features/warnings/data/models/warning_model.dart';
import 'package:nemea/features/warnings/data/remote_data/warning_remote_data.dart';
import 'package:nemea/features/warnings/domain/entities/warning.dart';
import 'package:nemea/features/warnings/domain/repositories/warning_repository.dart';

const int REFRESH_INTERVAL = 5;

class WarningRepositoryImpl implements WarningRepository {
  final WarningRemoteData warningRemoteData;
  final NetworkInfo networkInfo;
  final WarningLocalData warningLocalData;

  WarningRepositoryImpl({
    required this.warningRemoteData,
    required this.warningLocalData,
    required this.networkInfo,
  });

  @override
  // Having here 2 streams to work together on a smart way
  // Outer stream is about the device connection status
  // inner stream is either the remote stream or the local single call (can't be a stream cause data is not updating)
  // in this way I have a stream working 24/7 to get the data from the firebase
  // and save the data localy to the data base. when the device is offline
  // it reads the data from the local data base

  // second way that this could work is if the local data provided the stream
  // and remote data just update the local data when they get an event but it's
  // same thing
  Stream<Either<Failure, List<Warning>>> getWarnings() async* {
    StreamController<Either<Failure, List<Warning>>> warningStreamController =
        StreamController();
    StreamSubscription? remoteSubscription;
    networkInfo.connectionStream.listen(
      (event) async {
        if (event) {
          try {
            DateTime latestDateTime =
                await warningLocalData.getLatestDateTime();
            Stream<DateTime> remoteDateTime =
                warningRemoteData.getLatestDateTime();
            remoteSubscription = remoteDateTime.listen(
              (dateTime) async {
                if (latestDateTime.isBefore(dateTime)) {
                  List<WarningModel> warnings =
                      await warningRemoteData.getWarnings();
                  List<Warning> warningsEntities = [];
                  for (var warning in warnings) {
                    warningsEntities.add(Warning.fromModel(warning));
                  }
                  warningLocalData.setWarnings(warningsEntities);
                  warningLocalData.setLatestDateTime(dateTime);
                  warningStreamController.add(Right(warningsEntities));
                } else {
                  List<Warning> warnings = await warningLocalData.getWarnings();
                  warningStreamController.add(Right(warnings));
                }
              },
            );
          } catch (e) {
            remoteSubscription?.cancel();

            List<Warning> warnings = await warningLocalData.getWarnings();
            warningStreamController.add(Right(warnings));
          }
        } else {
          remoteSubscription?.cancel();
          try {
            List<Warning> warnings = await warningLocalData.getWarnings();
            warningStreamController.add(Right(warnings));
          } catch (e) {
            warningStreamController.add(Left(ServerFailure()));
          }
        }
      },
    );
    yield* warningStreamController.stream;
  }
}
