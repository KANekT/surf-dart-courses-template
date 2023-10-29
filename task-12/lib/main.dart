import 'package:flutter/material.dart';
import 'package:surf_flutter_courses_template/presentation/colors_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'data/repository/shopping_list_repository.dart';

void main() {
  initializeDateFormatting('ru_RU', null).then((_) =>
      runApp(const MainApp())
  );
}

final colorListRepository = ColorListRepository();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Эксклюзивная палитра Colored Box',
      theme: ThemeData(
          fontFamily: 'Ubuntu',
      ),
      home: const ColorsScreen(),
    );
  }
}
const TextStyle font30Weight700 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    color: Color.fromRGBO(37, 40, 73, 1)
);
