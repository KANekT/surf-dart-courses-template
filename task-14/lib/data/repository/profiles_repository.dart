import 'package:surf_flutter_courses_template/data/mock_data.dart';
import 'package:surf_flutter_courses_template/domain/entity/profile_entity.dart';

final class ProfilesRepository {
  /// Список элементов профиля
  Future<List<ProfileEntity>> getPosts() async {
    return Future.value(mockData);
  }
}