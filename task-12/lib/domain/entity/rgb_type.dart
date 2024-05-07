import 'package:surf_flutter_courses_template/main.dart';

enum RgbType {
  red (AppStrings.redColorsScreen),
  green (AppStrings.greenColorsScreen),
  blue (AppStrings.blueColorsScreen);

  final String name;

  const RgbType(this.name);
}