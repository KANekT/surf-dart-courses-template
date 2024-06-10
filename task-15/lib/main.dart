import 'package:flutter/material.dart';
import 'package:surf_flutter_courses_template/data/repository/photos_repository.dart';
import 'package:surf_flutter_courses_template/presentation/photos_screen.dart';

void main() {
  runApp(const MainApp());
}

final photosRepository = PhotosRepository();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Постограмм',
      theme: ThemeData(
          fontFamily: 'Ubuntu',
      ),
      home: const PhotosScreen(),
    );
  }
}

abstract class AppStrings {
  static const hexColorsScreen = 'Hex';
  static const redColorsScreen = 'Red';
  static const greenColorsScreen = 'Green';
  static const blueColorsScreen = 'Blue';
}
const TextStyle font30Weight700 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    color: Color.fromRGBO(37, 40, 73, 1)
);

const TextStyle font16Weight400 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Color.fromRGBO(37, 40, 73, 1)
);

const TextStyle font12Weight400 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Color.fromRGBO(37, 40, 73, 1)
);
