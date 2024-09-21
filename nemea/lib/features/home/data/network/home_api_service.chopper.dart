// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$HomeApiService extends HomeApiService {
  _$HomeApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = HomeApiService;

  @override
  Future<Response<BuiltList<MeteoModel>>> getMeteos() {
    final Uri $url = Uri.parse('/api/get-meteo-latest-data/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<BuiltList<MeteoModel>, MeteoModel>($request);
  }

  @override
  Future<Response<BuiltList<AmeaModel>>> getAmeas() {
    final Uri $url = Uri.parse('/api/catalog/amea/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<BuiltList<AmeaModel>, AmeaModel>($request);
  }

  @override
  Future<Response<BuiltList<VolunteerModel>>> getVolunteers() {
    final Uri $url = Uri.parse('/api/catalog/volunteer/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<BuiltList<VolunteerModel>, VolunteerModel>($request);
  }

  @override
  Future<Response<BuiltList<ManagerModel>>> getManager() {
    final Uri $url = Uri.parse('/api/catalog/manager/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<BuiltList<ManagerModel>, ManagerModel>($request);
  }

  @override
  Future<Response<BuiltList<MachineModel>>> getMachine() {
    final Uri $url = Uri.parse('/api/catalog/machine/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<BuiltList<MachineModel>, MachineModel>($request);
  }

  @override
  Future<Response<BuiltList<CameraMessageModel>>> getCameraMessages() {
    final Uri $url = Uri.parse('/api/camera/messages/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<BuiltList<CameraMessageModel>, CameraMessageModel>($request);
  }

  @override
  Future<Response<BuiltList<VardiaModel>>> getVardia(String mail) {
    final Uri $url = Uri.parse('/api/catalog/vardia/');
    final Map<String, dynamic> $params = <String, dynamic>{'mail': mail};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<BuiltList<VardiaModel>, VardiaModel>($request);
  }

  @override
  Future<Response<dynamic>> postFcm(UpdateFcmTokenModel body) {
    final Uri $url = Uri.parse('/api/catalog/volunteer/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
