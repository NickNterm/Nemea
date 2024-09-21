import 'package:built_collection/built_collection.dart';
import 'package:chopper/chopper.dart';
import 'package:nemea/app_config.dart';
import 'package:nemea/core/network/build_value_converter.dart';
import 'package:nemea/features/home/data/models/amea_model.dart';
import 'package:nemea/features/home/data/models/camera_message_model.dart';
import 'package:nemea/features/home/data/models/machine_model.dart';
import 'package:nemea/features/home/data/models/manager_model.dart';
import 'package:nemea/features/home/data/models/meteo_model.dart';
import 'package:nemea/features/home/data/models/update_fcm_token_model.dart';
import 'package:nemea/features/home/data/models/vardia_model.dart';
import 'package:nemea/features/home/data/models/volunteer_model.dart';
import 'package:nemea/features/home/data/network/home_api_interceptor.dart';
import 'package:nemea/utils/serializers.dart';

part 'home_api_service.chopper.dart';

@ChopperApi()
abstract class HomeApiService extends ChopperService {
  @Get(path: '/api/get-meteo-latest-data/')
  Future<Response<BuiltList<MeteoModel>>> getMeteos();

  @Get(path: '/api/catalog/amea/')
  Future<Response<BuiltList<AmeaModel>>> getAmeas();

  @Get(path: '/api/catalog/volunteer/')
  Future<Response<BuiltList<VolunteerModel>>> getVolunteers();

  @Get(path: '/api/catalog/manager/')
  Future<Response<BuiltList<ManagerModel>>> getManager();

  @Get(path: '/api/catalog/machine/')
  Future<Response<BuiltList<MachineModel>>> getMachine();

  @Get(path: '/api/camera/messages/')
  Future<Response<BuiltList<CameraMessageModel>>> getCameraMessages();

  @Get(path: '/api/catalog/vardia/')
  Future<Response<BuiltList<VardiaModel>>> getVardia(
    @Query('mail') String mail,
  );

  @Post(path: '/api/catalog/volunteer/')
  Future<Response> postFcm(
    @Body() UpdateFcmTokenModel body,
  );

  static HomeApiService create() {
    final client = ChopperClient(
      baseUrl: Uri.tryParse(
        AppConfig.instance().apiEndPoint,
      ),
      services: [
        _$HomeApiService(),
      ],
      converter: BuiltValueConverter(serializers),
      errorConverter: BuiltValueConverter(serializers),
      interceptors: [
        HttpLoggingInterceptor(),
        HomeApiInterceptor(),
      ],
    );
    return _$HomeApiService(client);
  }
}
