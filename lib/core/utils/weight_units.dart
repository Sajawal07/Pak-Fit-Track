/// Weight display unit helpers. Storage is always in kg.
enum WeightUnit { kg, lbs }

class WeightUnits {
  WeightUnits._();

  static const double _kgToLbs = 2.2046226218;

  static WeightUnit fromPrefs(String? raw) =>
      raw == 'lbs' ? WeightUnit.lbs : WeightUnit.kg;

  static String toPrefs(WeightUnit unit) =>
      unit == WeightUnit.lbs ? 'lbs' : 'kg';

  static String label(WeightUnit unit) =>
      unit == WeightUnit.lbs ? 'lbs' : 'kg';

  /// Convert stored kg → display value.
  static double toDisplay(double kg, WeightUnit unit) =>
      unit == WeightUnit.lbs ? kg * _kgToLbs : kg;

  /// Convert user-entered display value → kg for storage.
  static double toKg(double value, WeightUnit unit) =>
      unit == WeightUnit.lbs ? value / _kgToLbs : value;

  static String format(double kg, WeightUnit unit, {int decimals = 1}) =>
      '${toDisplay(kg, unit).toStringAsFixed(decimals)} ${label(unit)}';
}
