import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:nemea/features/home/data/models/machine_model.dart';

class Machine extends Equatable {
  final String owner;
  final String agency;
  final String area;
  final String registrationNumber;
  final String manufacturer;
  final String function;
  final String operatorName;
  final String cellPhoneNumber;

  Machine({
    required this.owner,
    required this.agency,
    required this.area,
    required this.registrationNumber,
    required this.manufacturer,
    required this.function,
    required this.operatorName,
    required this.cellPhoneNumber,
  });

  factory Machine.fromModel(MachineModel model) {
    return Machine(
      owner: model.owner,
      agency: model.agency,
      area: model.area,
      registrationNumber: model.registrationNumber,
      manufacturer: model.manufacturer,
      function: model.function,
      operatorName: model.operatorName,
      cellPhoneNumber: model.cellPhoneNumber,
    );
  }

  static List<Machine> fromModelList(BuiltList<MachineModel> models) {
    return models.map((model) => Machine.fromModel(model)).toList();
  }

  @override
  List<Object?> get props => [
        owner,
        agency,
        area,
        registrationNumber,
        manufacturer,
        function,
        operatorName,
        cellPhoneNumber,
      ];
}
