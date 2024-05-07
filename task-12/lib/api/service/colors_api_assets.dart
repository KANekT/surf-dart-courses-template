import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:surf_flutter_courses_template/api/colors_api_urls.dart';
import 'package:surf_flutter_courses_template/api/data/color_data.dart';
import 'package:surf_flutter_courses_template/api/service/colors_api.dart';

class ColorApiAssets implements IColorApi{
  @override
  Future<List<ColorData>> getColors() async {
    final colors = <ColorData>[];

    await _addDelay(1500);
    final jsonStr = await _loadAssets(ColorsApiUrls.colors);
    final data = jsonDecode(jsonStr) as Map<String, dynamic>;

    final colorsData = data['colors'] as List;

    if (colorsData.isNotEmpty) {
      for (final e in colorsData) {
        colors.add(ColorData.fromJson(e as Map<String, dynamic>));
      }
    }

    return colors;
  }

  ///имитация загрузки
  Future<void> _addDelay(int ms) => Future<void>.delayed(Duration(milliseconds: ms));

  ///загрузка данных
  Future<String> _loadAssets(String path) => rootBundle.loadString(path);
}