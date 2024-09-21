import 'package:built_collection/built_collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nemea/features/home/data/models/vardia_model.dart';

class Vardia extends Equatable {
  final String mail;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final DateTime date;
  final String type;

  Vardia({
    required this.mail,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.type,
  });

  factory Vardia.fromModel(VardiaModel model) {
    try {
      DateFormat format = new DateFormat("yyyy-MM-dd");
      DateTime dateTime = format.parse(model.date);
      return Vardia(
        mail: model.mail,
        date: dateTime,
        startTime: TimeOfDay(
          hour: int.parse(model.startTime.split(":")[0]),
          minute: int.parse(model.startTime.split(":")[1]),
        ),
        endTime: TimeOfDay(
          hour: int.parse(model.endTime.split(":")[0]),
          minute: int.parse(model.endTime.split(":")[1]),
        ),
        type: model.type,
      );
    } catch (e) {
      print("ERRORRRR: $e");
      throw Exception();
    }
  }

  static List<Vardia> fromModelList(BuiltList<VardiaModel> models) {
    return models.map((model) => Vardia.fromModel(model)).toList();
  }

  @override
  List<Object?> get props => [
        mail,
        date,
        startTime,
        endTime,
        type,
      ];
}
