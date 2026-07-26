import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants/prefs_keys.dart';
import '../core/utils/weight_units.dart';
import '../main.dart';

final weightUnitProvider =
    StateNotifierProvider<WeightUnitNotifier, WeightUnit>((ref) {
  return WeightUnitNotifier(ref.watch(sharedPreferencesProvider));
});

class WeightUnitNotifier extends StateNotifier<WeightUnit> {
  WeightUnitNotifier(this._prefs)
      : super(WeightUnits.fromPrefs(_prefs.getString(PrefsKeys.weightUnit)));

  final SharedPreferences _prefs;

  Future<void> setUnit(WeightUnit unit) async {
    state = unit;
    await _prefs.setString(PrefsKeys.weightUnit, WeightUnits.toPrefs(unit));
  }

  Future<void> toggle() => setUnit(
        state == WeightUnit.kg ? WeightUnit.lbs : WeightUnit.kg,
      );
}
