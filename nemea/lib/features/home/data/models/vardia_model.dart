library vardia_model;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'vardia_model.g.dart';

abstract class VardiaModel implements Built<VardiaModel, VardiaModelBuilder> {
  @BuiltValueField(wireName: 'mail')
  String get mail;

  @BuiltValueField(wireName: 'date')
  String get date;

  @BuiltValueField(wireName: 'start_time')
  String get startTime;

  @BuiltValueField(wireName: 'end_time')
  String get endTime;

  @BuiltValueField(wireName: 'type')
  String get type;

  VardiaModel._();

  factory VardiaModel([updates(VardiaModelBuilder b)]) = _$VardiaModel;

  static Serializer<VardiaModel> get serializer => _$vardiaModelSerializer;
}
