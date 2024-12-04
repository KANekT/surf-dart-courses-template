import 'package:surf_flutter_courses_template/domain/entity/profile_entity.dart';

final List<ProfileEntity> mockData = [
  ProfileEntity(
      name: 'Имя',
      value: 'Маркус Хассельборг',
      isEdited: false
  ),
  ProfileEntity(
      name: 'Email',
      value: 'MarkusHSS@gmail.com',
      isEdited: false
  ),
  ProfileEntity(
      name: 'Дата рождения',
      value: '03.03.1986',
      isEdited: false
  ),
  ProfileEntity(
      name: 'Команда',
      value: 'Сборная Швеции',
      isEdited: true
  ),
  ProfileEntity(
      name: 'Позиция',
      value: 'Скип',
      isEdited: true
  ),
  ProfileEntity(
      name: 'Тема оформления',
      value: 'Системная',
      isEdited: true
  ),
];