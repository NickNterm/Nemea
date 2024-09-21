import 'package:equatable/equatable.dart';
import 'package:nemea/features/home/data/models/camera_message_model.dart';

class CameraMessage extends Equatable {
  final int id;
  final String message;
  final String severity;
  final String type;
  final bool dismissed;
  final double latitude;
  final double longitude;
  final int device_id;
  final String image_url;
  final DateTime timestamp;

  CameraMessage({
    required this.id,
    required this.message,
    required this.severity,
    required this.type,
    required this.dismissed,
    required this.latitude,
    required this.longitude,
    required this.device_id,
    required this.image_url,
    required this.timestamp,
  });

  factory CameraMessage.fromModel(CameraMessageModel model) {
    return CameraMessage(
      id: model.id,
      message: model.message,
      severity: model.severity,
      type: model.type,
      dismissed: model.dissmissed,
      latitude: model.latitude,
      longitude: model.longitude,
      device_id: model.device_id,
      image_url: model.image_url,
      timestamp: DateTime.parse(model.timestamp),
    );
  }

  @override
  List<Object?> get props => [
        id,
        message,
        severity,
        type,
        dismissed,
        latitude,
        longitude,
        device_id,
        image_url,
        timestamp,
      ];
}
