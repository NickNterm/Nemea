library volunteer_model;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'volunteer_model.g.dart';

abstract class VolunteerModel
    implements Built<VolunteerModel, VolunteerModelBuilder> {
  @BuiltValueField(wireName: 'name')
  String get name;

  @BuiltValueField(wireName: 'surename')
  String get surname;

  @BuiltValueField(wireName: 'location')
  String get location;

  @BuiltValueField(wireName: 'team')
  String get team;

  @BuiltValueField(wireName: 'specialization')
  String get specialization;

  @BuiltValueField(wireName: 'cell_phone_number')
  String get cellPhoneNumber;

  @BuiltValueField(wireName: 'mail')
  String get mail;

  VolunteerModel._();

  factory VolunteerModel([updates(VolunteerModelBuilder b)]) = _$VolunteerModel;

  static Serializer<VolunteerModel> get serializer =>
      _$volunteerModelSerializer;
}
