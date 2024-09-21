library update_fcm_token_model;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_fcm_token_model.g.dart';

abstract class UpdateFcmTokenModel
    implements Built<UpdateFcmTokenModel, UpdateFcmTokenModelBuilder> {
  @BuiltValueField(wireName: 'fcm')
  String get fcm;

  @BuiltValueField(wireName: 'mail')
  String get mail;

  UpdateFcmTokenModel._();

  factory UpdateFcmTokenModel([updates(UpdateFcmTokenModelBuilder b)]) =
      _$UpdateFcmTokenModel;

  static Serializer<UpdateFcmTokenModel> get serializer =>
      _$updateFcmTokenModelSerializer;
}
