import 'dart:math';

extension DoubleExtension on double {
  double roundedPrecision(int precision) {
    num mod = pow(10.0, precision);
    return ((this * mod).round().toDouble() / mod);
  }
}
