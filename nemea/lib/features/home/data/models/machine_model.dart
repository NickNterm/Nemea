library machine_model;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'machine_model.g.dart';

abstract class MachineModel
    implements Built<MachineModel, MachineModelBuilder> {
  @BuiltValueField(wireName: 'owner')
  String get owner;

  @BuiltValueField(wireName: 'agency')
  String get agency;

  @BuiltValueField(wireName: 'area')
  String get area;

  @BuiltValueField(wireName: 'registration_number')
  String get registrationNumber;

  @BuiltValueField(wireName: 'manufacturer')
  String get manufacturer;

  @BuiltValueField(wireName: 'function')
  String get function;

  @BuiltValueField(wireName: 'operator_name')
  String get operatorName;

  @BuiltValueField(wireName: 'cell_phone_number')
  String get cellPhoneNumber;

  MachineModel._();

  factory MachineModel([updates(MachineModelBuilder b)]) = _$MachineModel;

  static Serializer<MachineModel> get serializer => _$machineModelSerializer;
}
