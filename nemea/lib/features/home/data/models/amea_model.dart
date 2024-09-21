library amea_model;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'amea_model.g.dart';

abstract class AmeaModel implements Built<AmeaModel, AmeaModelBuilder> {
  @BuiltValueField(wireName: 'name')
  String get name;

  @BuiltValueField(wireName: 'surename')
  String get surname;

  @BuiltValueField(wireName: 'residence')
  String get residence;

  @BuiltValueField(wireName: 'residence_phone_number')
  String get residencePhoneNumber;

  @BuiltValueField(wireName: 'cell_phone_number')
  String get cellPhoneNumber;

  AmeaModel._();

  factory AmeaModel([updates(AmeaModelBuilder b)]) = _$AmeaModel;

  static Serializer<AmeaModel> get serializer => _$ameaModelSerializer;
}
