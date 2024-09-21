import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nemea/features/warnings/data/models/warning_model.dart';

part 'warning.g.dart';

@HiveType(typeId: 1)
class Warning extends Equatable {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String? description;

  @HiveField(2)
  final DateTime datetime;

  Warning({
    required this.title,
    required this.description,
    required this.datetime,
  });

  factory Warning.empty() {
    return Warning(
      title: '',
      description: '',
      datetime: DateTime.now(),
    );
  }

  factory Warning.fake() {
    return Warning(
      title: Random().nextBool() ? 'Warning' : 'Alert',
      description: List.filled(Random().nextInt(100), 'a').join(' '),
      datetime: DateTime.now(),
    );
  }
  factory Warning.fromModel(WarningModel model) {
    return Warning(
      title: model.title,
      description: model.description,
      datetime: DateTime.parse(model.datetime),
    );
  }

  @override
  List<Object?> get props => [title, description, datetime];
}
