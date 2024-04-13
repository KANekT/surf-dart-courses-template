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
    return const MaterialApp(
      title: 'Список покупок',
      home: TabsScreen(),
    );
  }
}
