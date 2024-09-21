library manager_model;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'manager_model.g.dart';

abstract class ManagerModel
    implements Built<ManagerModel, ManagerModelBuilder> {
  @BuiltValueField(wireName: 'name')
  String get name;

  @BuiltValueField(wireName: 'surename')
  String get surname;

  @BuiltValueField(wireName: 'job_title')
  String get jobTitle;

  @BuiltValueField(wireName: 'job_attribute')
  String get jobAttribute;

  @BuiltValueField(wireName: 'specialization')
  String get specialization;

  @BuiltValueField(wireName: 'cell_phone_number')
  String get cellPhoneNumber;

  ManagerModel._();

  factory ManagerModel([updates(ManagerModelBuilder b)]) = _$ManagerModel;

  static Serializer<ManagerModel> get serializer => _$managerModelSerializer;
}
