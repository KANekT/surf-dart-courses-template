import 'dart:convert';
import 'package:surf_flutter_courses_template/domain/entity/color_entity.dart';
import 'package:flutter/services.dart';

class ColorListRepository {
  Future<List<ColorEntity>> getColors() async {
    List<dynamic> colors = await rootBundle
        .loadString('assets/mock_data.json')
        .then((value) => jsonDecode(value))
        .then((value) => value['colors'])
    ;

    return colors.map((e) =>
        ColorEntity(name: e['name'], value: e['value'])
    ).toList();
  }
}