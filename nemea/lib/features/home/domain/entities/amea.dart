import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:nemea/features/home/data/models/amea_model.dart';

class Amea extends Equatable {
  final String name;

  final String surname;

  final String residence;

  final String residencePhoneNumber;

  final String cellPhoneNumber;

  Amea({
    required this.name,
    required this.surname,
    required this.residence,
    required this.residencePhoneNumber,
    required this.cellPhoneNumber,
  });

  factory Amea.fromModel(AmeaModel model) {
    return Amea(
      name: model.name,
      surname: model.surname,
      residence: model.residence,
      residencePhoneNumber: model.residencePhoneNumber,
      cellPhoneNumber: model.cellPhoneNumber,
    );
  }

  static List<Amea> fromModelList(BuiltList<AmeaModel> models) {
    return models.map((model) => Amea.fromModel(model)).toList();
  }

  @override
  List<Object?> get props => [
        name,
        surname,
        residence,
        residencePhoneNumber,
        cellPhoneNumber,
      ];
}
