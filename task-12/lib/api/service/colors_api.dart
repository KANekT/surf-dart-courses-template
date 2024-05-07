import 'package:surf_flutter_courses_template/api/data/color_data.dart';

// Цветное апи
abstract class IColorApi {
  // список цветов
  Future<List<ColorData>> getColors();
}