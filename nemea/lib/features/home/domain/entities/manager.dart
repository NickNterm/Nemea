import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:nemea/features/home/data/models/manager_model.dart';

class Manager extends Equatable {
  final String name;

  final String surname;

  final String jobTitle;

  final String jobAttribute;

  final String specialization;

  final String cellPhoneNumber;

  Manager({
    required this.name,
    required this.surname,
    required this.jobTitle,
    required this.jobAttribute,
    required this.specialization,
    required this.cellPhoneNumber,
  });

  factory Manager.fromModel(ManagerModel model) {
    return Manager(
      name: model.name,
      surname: model.surname,
      jobTitle: model.jobTitle,
      jobAttribute: model.jobAttribute,
      specialization: model.specialization,
      cellPhoneNumber: model.cellPhoneNumber,
    );
  }

  static List<Manager> fromModelList(BuiltList<ManagerModel> models) {
    return models.map((model) => Manager.fromModel(model)).toList();
  }

  @override
  List<Object?> get props => [
        name,
        surname,
        jobTitle,
        jobAttribute,
        specialization,
        cellPhoneNumber,
      ];
}
