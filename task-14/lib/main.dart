import 'package:surf_flutter_courses_template/feature/theme/ui/theme_builder.dart';
import 'package:surf_flutter_courses_template/feature/theme/domain/theme_controller.dart';
import 'package:surf_flutter_courses_template/presentation/home.dart';
import 'package:surf_flutter_courses_template/uikit/theme/theme_data.dart';
import 'package:surf_flutter_courses_template/feature/theme/di/theme_inherited.dart';
import 'package:surf_flutter_courses_template/feature/theme/data/theme_repository.dart';
import 'package:surf_flutter_courses_template/storage/theme/theme_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final themeStorage = ThemeStorage(
    prefs: prefs,
  );
  final themeRepository = ThemeRepository(
    themeStorage: themeStorage,
  );
  final themeController = ThemeController(
    themeRepository: themeRepository,
  );

  runApp(App(
    themeController: themeController,
  ));
}

class App extends StatelessWidget {
  final ThemeController themeController;

  const App({
    required this.themeController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeInherited(
      themeController: themeController,
      child: ThemeBuilder(
        builder: (_, themeMode) {
          return MaterialApp(
            theme: AppThemeData.lightTheme,
            darkTheme: AppThemeData.darkTheme,
            themeMode: themeMode,
            home: const ProfileScreen(),
          );
        },
      ),
    );
  }
}

const TextStyle font18Weight700 = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 18,
    fontWeight: FontWeight.w700
);

const TextStyle font14Weight400 = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 14,
    fontWeight: FontWeight.w400
);

const TextStyle font30Weight400 = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 30,
    fontWeight: FontWeight.w400
);

const TextStyle font12Weight400 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400
);
