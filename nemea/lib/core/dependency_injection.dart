import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:nemea/features/home/data/local_data/home_local_data_source.dart';
import 'package:nemea/features/home/data/network/home_api_service.dart';
import 'package:nemea/features/home/data/network/weather_api_service.dart';
import 'package:nemea/features/home/data/remote_data/home_remote_data_source.dart';
import 'package:nemea/features/home/data/repositories/home_repository_impl.dart';
import 'package:nemea/features/home/domain/repositories/home_repository.dart';
import 'package:nemea/features/home/presentation/bloc/amea/amea_bloc.dart';
import 'package:nemea/features/home/presentation/bloc/fwi/fwi_bloc.dart';
import 'package:nemea/features/home/presentation/bloc/machine/machine_bloc.dart';
import 'package:nemea/features/home/presentation/bloc/manager/manager_bloc.dart';
import 'package:nemea/features/home/presentation/bloc/meteo/meteo_bloc.dart';
import 'package:nemea/features/home/presentation/bloc/volunteer/volunteer_bloc.dart';
import 'package:nemea/features/people_list/data/data_source/people_list_remote_data_source.dart';
import 'package:nemea/features/people_list/data/repository/people_list_repository_impl.dart';
import 'package:nemea/features/people_list/domain/repository/people_list_repository.dart';
import 'package:nemea/features/people_list/presentation/bloc/camera_message/camera_message_bloc.dart';
import 'package:nemea/features/people_list/presentation/bloc/user/user_bloc.dart';
import 'package:nemea/features/people_list/presentation/bloc/vardies/vardies_bloc.dart';
import 'package:nemea/features/warnings/data/local_data/warning_local_data.dart';
import 'package:nemea/features/warnings/data/remote_data/warning_remote_data.dart';
import 'package:nemea/features/warnings/data/repositories/warning_repository_impl.dart';
import 'package:nemea/features/warnings/domain/repositories/warning_repository.dart';
import 'package:nemea/features/warnings/presentation/bloc/warnings/warnings_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_config.dart';
import 'lang/language_cubit.dart';
import 'lang/language_local_data_source.dart';
import 'network/network_info.dart';
import 'theme/cubit/palette/palette_cubit.dart';

final sl = GetIt.instance;

Future<void> initGetIt() async {
  _initCore();
  _initData();
  _initRepositories();
  await _initExternal();
  _initChopper();
  _initBlocs();
}

void _initCore() {
  // final config = AppConfig.instance();

  ///////////////
  //  Palette  //
  ///////////////

  sl.registerSingleton(
    PaletteCubit(),
  );
}

void _initData() {
  ////////////////
  //  Warnings  //
  ////////////////

  sl.registerLazySingleton<WarningRemoteData>(
    () => WarningRemoteDataImpl(
      firestore: sl(),
    ),
  );

  sl.registerLazySingleton<WarningLocalData>(
    () => WarningLocalDataImpl(sl()),
  );

  ////////////
  //  Home  //
  ////////////

  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(
      sl<HomeApiService>(),
      sl<WeatherApiService>(),
    ),
  );

  sl.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(),
  );

  //////////////////
  //  PeopleList  //
  //////////////////

  sl.registerLazySingleton<PeopleListRemoteDataSource>(
    () => PeopleListRemoteDataSourceImpl(
      sl<FirebaseAuth>(),
    ),
  );
}

void _initRepositories() {
  ////////////////
  //  Warnings  //
  ////////////////

  sl.registerLazySingleton<WarningRepository>(
    () => WarningRepositoryImpl(
      warningRemoteData: sl<WarningRemoteData>(),
      warningLocalData: sl<WarningLocalData>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  sl.registerLazySingleton<PeopleListRepository>(
    () => PeopleListRepositoryImpl(
      sl<PeopleListRemoteDataSource>(),
    ),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      networkInfo: sl<NetworkInfo>(),
      remoteDataSource: sl<HomeRemoteDataSource>(),
      localDataSource: sl<HomeLocalDataSource>(),
    ),
  );
}

Future<void> _initExternal() async {
  /////////////////////////
  //  SharedPreferences  //
  /////////////////////////

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  ///////////////////
  //  NetworkInfo  //
  ///////////////////

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      connectivity: sl(),
    ),
  );

  sl.registerLazySingleton<Connectivity>(
    () => Connectivity(),
  );

  ////////////////
  //  Language  //
  ////////////////

  sl.registerLazySingleton(
    () => LanguageCubit(
      languageLocalDataSource: sl<LanguageLocalDataSource>(),
    ),
  );

  sl.registerLazySingleton<LanguageLocalDataSource>(
    () => LanguageLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  ////////////////
  //  Firebase  //
  ////////////////

  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}

void _initChopper() {
  ///////////////
  //  Chopper  //
  ///////////////

  sl.registerLazySingleton(() => HomeApiService.create());
  sl.registerLazySingleton(() => WeatherApiService.create());
}

void _initBlocs() {
  sl.registerLazySingleton<CameraMessageBloc>(
    () => CameraMessageBloc(
      repository: sl<HomeRepository>(),
    ),
  );
  sl.registerLazySingleton<VardiesBloc>(
    () => VardiesBloc(
      repository: sl<HomeRepository>(),
    ),
  );
  sl.registerLazySingleton<AmeaBloc>(
    () => AmeaBloc(
      repository: sl<HomeRepository>(),
    ),
  );
  sl.registerLazySingleton<MachineBloc>(
    () => MachineBloc(
      repository: sl<HomeRepository>(),
    ),
  );
  sl.registerLazySingleton<VolunteerBloc>(
    () => VolunteerBloc(
      repository: sl<HomeRepository>(),
    ),
  );

  sl.registerLazySingleton<ManagerBloc>(
    () => ManagerBloc(
      repository: sl<HomeRepository>(),
    ),
  );
  sl.registerLazySingleton<UserBloc>(
    () => UserBloc(
      repository: sl<PeopleListRepository>(),
    ),
  );

  sl.registerLazySingleton<FwiBloc>(
    () => FwiBloc(
      homeRepository: sl<HomeRepository>(),
    ),
  );

  sl.registerLazySingleton<WarningsBloc>(
    () => WarningsBloc(
      warningRepository: sl<WarningRepository>(),
    ),
  );

  sl.registerLazySingleton<MeteoBloc>(
    () => MeteoBloc(
      repository: sl<HomeRepository>(),
    ),
  );
}
