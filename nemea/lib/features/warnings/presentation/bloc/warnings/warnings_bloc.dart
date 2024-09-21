import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:meta/meta.dart';
import 'package:nemea/features/warnings/domain/entities/warning.dart';
import 'package:nemea/features/warnings/domain/repositories/warning_repository.dart';
import 'package:nemea/utils/locale_keys.g.dart';
part 'warnings_event.dart';
part 'warnings_state.dart';

class WarningsBloc extends Bloc<WarningsEvent, WarningsState> {
  final WarningRepository warningRepository;
  WarningsBloc({
    required this.warningRepository,
  }) : super(WarningsInitial()) {
    on<GetWarnings>(_onGetWarnings);
  }

  _onGetWarnings(GetWarnings event, Emitter<WarningsState> emit) {
    emit(WarningsLoading());
    return emit.forEach(
      warningRepository.getWarnings(),
      onData: (warnings) {
        return warnings.fold(
          (failure) {
            return WarningsError(
              message: LocaleKeys.warnings_error_loading.tr(),
            );
          },
          (warnings) {
            return WarningsLoaded(
              warnings: warnings,
            );
          },
        );
      },
    );
  }
}
