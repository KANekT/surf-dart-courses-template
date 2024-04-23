import 'package:surf_flutter_courses_template/api/data/color_data.dart';
import 'package:surf_flutter_courses_template/domain/entity/color_entity.dart';

final class ColorMapper {
  // преобразование списка цветов
  List<ColorEntity> mapColor(List<ColorData> data){
    final mapList = <ColorEntity>[];
    for(var e in data){
      final entity = _mapColor(e);
      if(entity != null){
        mapList.add(entity);
      }
    }

    return mapList;
  }

  // преобразование из [ColorData] в [ColorEntity]
  ColorEntity? _mapColor(ColorData data) {
    final value = data.value;
    if (value == null){
      return null;
    }

    return ColorEntity(name: data.name, value: value);
  }
}