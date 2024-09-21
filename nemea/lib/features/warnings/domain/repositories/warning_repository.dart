import 'package:dartz/dartz.dart';
import 'package:nemea/core/errors/failures.dart';
import 'package:nemea/features/warnings/domain/entities/warning.dart';

abstract class WarningRepository {
  Stream<Either<Failure, List<Warning>>> getWarnings();
}
