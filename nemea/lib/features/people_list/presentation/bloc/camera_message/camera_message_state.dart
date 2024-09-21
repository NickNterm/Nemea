part of 'camera_message_bloc.dart';

@immutable
sealed class CameraMessageState {}

final class CameraMessageInitial extends CameraMessageState {}

final class CameraMessageLoading extends CameraMessageState {}

final class CameraMessageLoaded extends CameraMessageState {
  final List<CameraMessage> cameraMessages;

  CameraMessageLoaded(this.cameraMessages);
}

final class CameraMessageError extends CameraMessageState {}
