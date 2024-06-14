import 'package:flutter/material.dart';
import 'package:surf_flutter_courses_template/feature/theme/di/theme_inherited.dart';
import 'package:surf_flutter_courses_template/main.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {
                  ThemeInherited.of(context).switchThemeMode();
                },
                child: const Text('Switch theme'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ThemeInherited.of(context).setThemeMode(
                    ThemeMode.light,
                  );
                },
                child: const Text('Set light theme'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ThemeInherited.of(context).setThemeMode(
                    ThemeMode.dark,
                  );
                },
                child: const Text('Set dark theme'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  ThemeInherited.of(context).setThemeMode(
                    ThemeMode.system,
                  );
                },
                child: const Text('Set system theme'),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text(
              'Профиль',
              style: font18Weight700
          ),
          actions: [TextButton(
            onPressed: () {},
            child: Text(
              "Save",
              style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Theme
                      .of(context)
                      .appBarTheme
                      .actionsIconTheme
                      ?.color
              ),
            ),
          )
          ]
      ),
      body: const _ContentWidget(),
    );
  }
}

class _ContentWidget extends StatelessWidget {
  const _ContentWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Stack(
            children: [
              const CircleAvatar(
                  radius: 40.0,
                  backgroundImage: AssetImage('assets/images/avatar.png')
              ),
              SizedBox(
                  height: 80.0,
                  width: 80.0,
                  child: Center(
                    child: Text(
                        'Edit',
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.onPrimary
                          )
                    ),
                  )
              )
            ]
          ),
        ),
        const Text('Мои награды', style: font14Weight400),
        const Text('🥇🥇🥉🥈🥉', style: font30Weight400)
        /*
        GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.8,
                mainAxisSpacing: 40.0,
                crossAxisSpacing: 22
            ),
            itemCount: data.length,
            itemBuilder: (_, i) => _ColorWidget(entity: data[i])),
            */
      ],
    );
  }
}

/*
class _ColorWidget extends StatelessWidget {
  final ColorEntity entity;

  const _ColorWidget({required this.entity});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => _onTap(context),
        onLongPress: () => _onLongPress(context),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              SizedBox.square(
                dimension: 100.0,
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: entity.value.hexToColor()
                    )
                ),
              ),
              Text(entity.name, style: font12Weight400),
              Text(entity.value, style: font12Weight400)
            ]
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(
        builder: (_) => ColorScreen(colorEntity: entity))
    );
  }

  void _onLongPress(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: entity.value));
    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Скопировали ${entity.value}"),
    ));
  }
}
*/

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Произошла ошибка при загрузке'),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}