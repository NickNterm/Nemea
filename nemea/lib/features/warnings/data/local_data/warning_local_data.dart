import 'package:hive_flutter/hive_flutter.dart';
import 'package:nemea/features/warnings/domain/entities/warning.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String WARNINGS_BOX = 'warnings';
const String LATEST_DATE_TIME = 'latestDateTime';

abstract class WarningLocalData {
  Future<List<Warning>> getWarnings();
  Future<List<Warning>> setWarnings(List<Warning> warnings);

  Future<DateTime> getLatestDateTime();
  Future<DateTime> setLatestDateTime(DateTime dateTime);
}

class WarningLocalDataImpl implements WarningLocalData {
  late LazyBox<Warning> warningBox;
  SharedPreferences sharedPreferences;

  WarningLocalDataImpl(this.sharedPreferences);

  @override
  Future<List<Warning>> getWarnings() async {
    warningBox = await Hive.openLazyBox<Warning>(WARNINGS_BOX);
    List<Warning> warnings = [];
    for (var i = 0; i < warningBox.length; i++) {
      Warning? warning = await warningBox.getAt(i);
      warnings.add(warning!);
    }
    return warnings;
  }

  @override
  Future<List<Warning>> setWarnings(List<Warning> warnings) async {
    warningBox = await Hive.openLazyBox<Warning>(WARNINGS_BOX);
    await warningBox.clear();
    for (var warning in warnings) {
      await warningBox.add(warning);
    }
    return warnings;
  }

  @override
  Future<DateTime> getLatestDateTime() async {
    String datetime = await sharedPreferences.getString(LATEST_DATE_TIME) ?? '';
    if (datetime.isEmpty) {
      return DateTime(0);
    }
    return DateTime.parse(datetime);
  }

  @override
  Future<DateTime> setLatestDateTime(DateTime dateTime) async {
    await sharedPreferences.setString(
      LATEST_DATE_TIME,
      dateTime.toIso8601String(),
    );
    return dateTime;
  }
}
