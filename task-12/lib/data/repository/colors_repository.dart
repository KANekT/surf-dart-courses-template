import 'package:surf_flutter_courses_template/api/service/colors_api.dart';
import 'package:surf_flutter_courses_template/data/mapper/color_mapper.dart';
import 'package:surf_flutter_courses_template/domain/entity/color_entity.dart';

final class ColorsRepository {
  final ColorsApi _colorsApi;
  final ColorMapper _colorMapper;

  ColorsRepository({
    required ColorsApi colorsApi,
    required ColorMapper colorMapper
  })
      : _colorsApi = colorsApi,
        _colorMapper = colorMapper;

  Future<List<ColorEntity>> getColors() => _colorsApi.getColors().then((value) => _colorMapper.mapColor(value));
}