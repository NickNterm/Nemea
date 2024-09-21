library camera_message_model;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'camera_message_model.g.dart';

abstract class CameraMessageModel
    implements Built<CameraMessageModel, CameraMessageModelBuilder> {
  int get id;

  String get message;

  String get severity;

  String get type;

  bool get dissmissed;

  double get latitude;

  double get longitude;

  int get device_id;

  String get image_url;

  String get timestamp;

  CameraMessageModel._();

  factory CameraMessageModel([updates(CameraMessageModelBuilder b)]) =
      _$CameraMessageModel;

  static Serializer<CameraMessageModel> get serializer =>
      _$cameraMessageModelSerializer;
}
//{
//    "id": 9141,
//    "message": "FIRE",
//    "severity": "Very High",
//    "type": "FIRE_DETECTION",
//    "dissmissed": false,
//    "latitude": 37.80975141,
//    "longitude": 22.65828454,
//    "device_id": 2,
//    "image_url": "https://airwingsplus-nemea.wings-ict-solutions.eu/static/images/2024_07_24_08_13_52_2_Frame.jpg",
//    "timestamp": "2024-07-24T05:13:52+03:00"
//  },
