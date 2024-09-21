import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:nemea/features/home/data/models/volunteer_model.dart';

class Volunteer extends Equatable {
  final String name;
  final String surname;
  final String location;
  final String team;
  final String specialization;
  final String phone;
  final String mail;

  Volunteer({
    required this.name,
    required this.surname,
    required this.location,
    required this.team,
    required this.specialization,
    required this.phone,
    required this.mail,
  });

  factory Volunteer.fromModel(VolunteerModel model) {
    return Volunteer(
      name: model.name,
      surname: model.surname,
      location: model.location,
      team: model.team,
      specialization: model.specialization,
      phone: model.cellPhoneNumber,
      mail: model.mail,
    );
  }

  static List<Volunteer> fromModelList(BuiltList<VolunteerModel> models) {
    return models.map((model) => Volunteer.fromModel(model)).toList();
  }

  @override
  List<Object?> get props => [
        name,
        surname,
        location,
        team,
        specialization,
        phone,
        mail,
      ];
}
