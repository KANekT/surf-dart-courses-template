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
      ),
      home: const TabsScreen(),
    );
  }
}
const TextStyle font16Weight400 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Color.fromRGBO(37, 40, 73, 1)
);
const TextStyle font16Weight700 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Color.fromRGBO(37, 40, 73, 1)
);
const TextStyle font16Weight700Default = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700
);
const TextStyle font18Weight700 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: Color.fromRGBO(37, 40, 73, 1)
);
const TextStyle font20Weight700 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Color.fromRGBO(37, 40, 73, 1)
);
const TextStyle font10Weight400Grey = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: Color.fromRGBO(96, 96, 123, 1)
);
const TextStyle font12Weight400 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Color.fromRGBO(37, 40, 73, 1)
);
const TextStyle font12Weight700 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: Color.fromRGBO(37, 40, 73, 1)
);
const TextStyle font12Weight700Red = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: Color.fromRGBO(255, 0, 0, 1)
);
const TextStyle font18Weight400 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Color.fromRGBO(37, 40, 73, 1)
);
const TextStyle font18Weight400Grey = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.lineThrough,
    decorationColor: Color.fromRGBO(
        181, 181, 181, 1),
    color: Color.fromRGBO(181, 181, 181, 1)
);
const Color colorGreen = Color.fromRGBO(103, 205, 0, 1);
const Color colorGrey = Color.fromRGBO(96, 96, 123, 1);
const Color colorBtnGrey = Color.fromRGBO(241, 241, 241, 1);

