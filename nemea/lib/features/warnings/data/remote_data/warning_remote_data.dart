import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nemea/core/errors/exceptions.dart';
import 'package:nemea/features/warnings/data/models/warning_model.dart';

const String WARNINGS_COLLECTION = 'warnings';
const String LATEST_DATE_TIME = 'latestDateTime';

abstract class WarningRemoteData {
  Future<List<WarningModel>> getWarnings();

  Stream<DateTime> getLatestDateTime();
}

class WarningRemoteDataImpl implements WarningRemoteData {
  final FirebaseFirestore firestore;

  WarningRemoteDataImpl({
    required this.firestore,
  });

  @override
  Future<List<WarningModel>> getWarnings() async {
    var value = await firestore.collection(WARNINGS_COLLECTION).get();
    if (value.docs.isEmpty) {
      throw ServerException();
    }
    List<WarningModel> warnings = [];
    for (var doc in value.docs) {
      warnings.add(WarningModel.fromJson(doc.data()));
    }
    warnings.sort((a, b) => b.datetime.compareTo(a.datetime));
    return warnings;
  }

  @override
  Stream<DateTime> getLatestDateTime() async* {
    StreamController<DateTime> streamController = StreamController();
    firestore
        .collection(LATEST_DATE_TIME)
        .doc("warningsDateTime")
        .snapshots()
        .listen(
      (event) {
        streamController.add(
          DateTime.parse(
            event.data()!["datetime"],
          ),
        );
      },
    );
    yield* streamController.stream;
  }
}
