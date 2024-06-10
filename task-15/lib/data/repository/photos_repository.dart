import 'package:surf_flutter_courses_template/data/mock_data.dart';
import 'package:surf_flutter_courses_template/domain/entity/photo_entity.dart';

final class PhotosRepository {
  /// Список фотографий
  Future<List<PhotoEntity>> getPosts() async {
    return Future.value(mockData);
  }
}