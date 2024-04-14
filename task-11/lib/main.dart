import 'package:flutter/material.dart';
import 'package:surf_flutter_courses_template/presentation/tabs_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'data/repository/shopping_list_repository.dart';

void main() {
  initializeDateFormatting('ru_RU', null).then((_) =>
      runApp(const MainApp())
  );
}

final shoppingListRepository = ShoppingListRepository();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Список покупок',
      theme: ThemeData(
          fontFamily: 'Sora',
          textTheme: const TextTheme(
              labelLarge: TextStyle(
                  fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(37, 40, 73, 1)
              ),
              labelSmall: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(96, 96, 123, 1)
              )
          )
      ),
      home: const TabsScreen(),
    );
  }
}
