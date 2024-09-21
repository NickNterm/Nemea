import 'package:built_collection/built_collection.dart';
import 'package:nemea/features/home/data/models/amea_model.dart';
import 'package:nemea/features/home/data/models/camera_message_model.dart';
import 'package:nemea/features/home/data/models/machine_model.dart';
import 'package:nemea/features/home/data/models/manager_model.dart';
import 'package:nemea/features/home/data/models/meteo_model.dart';
import 'package:nemea/features/home/data/models/update_fcm_token_model.dart';
import 'package:nemea/features/home/data/models/vardia_model.dart';
import 'package:nemea/features/home/data/models/volunteer_model.dart';
import 'package:nemea/features/home/data/network/home_api_service.dart';
import 'package:nemea/features/home/data/network/weather_api_service.dart';

abstract class HomeRemoteDataSource {
  Future<BuiltList<MeteoModel>> getMeteo();

  Future<int> getFWI();

  Future<BuiltList<AmeaModel>> getAmeas();

  Future<BuiltList<VolunteerModel>> getVolunteers();

  Future<BuiltList<MachineModel>> getMachines();

  Future<BuiltList<ManagerModel>> getManagers();

  Future<BuiltList<VardiaModel>> getVardias(String mail);

  Future<BuiltList<CameraMessageModel>> getCameraMessages();

  Future<void> postFcm(UpdateFcmTokenModel body);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final HomeApiService homeApiService;
  final WeatherApiService weatherApiService;

  HomeRemoteDataSourceImpl(
    this.homeApiService,
    this.weatherApiService,
  );

  @override
  Future<BuiltList<MeteoModel>> getMeteo() async {
    return (await homeApiService.getMeteos()).body!;
  }

  @override
  Future<int> getFWI() async {
    var body = await weatherApiService.getFWI(24, -103);
    return body.body!;
  }

  @override
  Future<void> postFcm(UpdateFcmTokenModel body) {
    return homeApiService.postFcm(body);
  }

  @override
  Future<BuiltList<AmeaModel>> getAmeas() async {
    return (await homeApiService.getAmeas()).body!;
  }

  @override
  Future<BuiltList<MachineModel>> getMachines() async {
    return (await homeApiService.getMachine()).body!;
  }

  @override
  Future<BuiltList<ManagerModel>> getManagers() async {
    return (await homeApiService.getManager()).body!;
  }

  @override
  Future<BuiltList<VolunteerModel>> getVolunteers() async {
    return (await homeApiService.getVolunteers()).body!;
  }

  @override
  Future<BuiltList<VardiaModel>> getVardias(String mail) async {
    return (await homeApiService.getVardia(mail)).body!;
  }

  @override
  Future<BuiltList<CameraMessageModel>> getCameraMessages() async {
    return (await homeApiService.getCameraMessages()).body!;
  }
}
