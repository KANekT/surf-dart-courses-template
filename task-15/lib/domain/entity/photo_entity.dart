// Модель Поста
class PhotoEntity {
  final String name;

  PhotoEntity({required this.name});

  // формирование строки картинки из network
  String getPath(){
    return 'https://raw.githubusercontent.com/KANekT/surf-dart-courses/task-15/task-15/assets/images/3.0x/$name';
  }
}