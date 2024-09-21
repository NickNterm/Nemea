import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../home/domain/entities/camera_message.dart';
import '../../../../home/domain/repositories/home_repository.dart';

part 'camera_message_event.dart';

part 'camera_message_state.dart';

class CameraMessageBloc extends Bloc<CameraMessageEvent, CameraMessageState> {
  final HomeRepository repository;

  CameraMessageBloc({required this.repository})
      : super(CameraMessageInitial()) {
    on<GetCameraMessages>(_onGetCameraMessages);
  }

  _onGetCameraMessages(
      GetCameraMessages event, Emitter<CameraMessageState> emit) async {
    emit(CameraMessageLoading());
    final result = await repository.getCameraMessages();
    result.fold(
      (failure) => emit(CameraMessageError()),
      (cameraMessages) => emit(CameraMessageLoaded(cameraMessages)),
    );
  }
}
