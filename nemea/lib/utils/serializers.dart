import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:nemea/features/home/data/models/amea_model.dart';
import 'package:nemea/features/home/data/models/camera_message_model.dart';
import 'package:nemea/features/home/data/models/machine_model.dart';
import 'package:nemea/features/home/data/models/manager_model.dart';
import 'package:nemea/features/home/data/models/meteo_model.dart';
import 'package:nemea/features/home/data/models/update_fcm_token_model.dart';
import 'package:nemea/features/home/data/models/vardia_model.dart';
import 'package:nemea/features/home/data/models/volunteer_model.dart';

part 'serializers.g.dart';

@SerializersFor([
  MeteoModel,
  AmeaModel,
  VolunteerModel,
  MachineModel,
  VardiaModel,
  ManagerModel,
  UpdateFcmTokenModel,
  CameraMessageModel,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addPlugin(StandardJsonPlugin())
      ..add(Iso8601DateTimeSerializer()))
    .build();
