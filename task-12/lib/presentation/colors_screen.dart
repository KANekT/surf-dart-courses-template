import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:surf_flutter_courses_template/domain/entity/color_entity.dart';
import 'package:surf_flutter_courses_template/presentation/color_screen.dart';
import 'package:surf_flutter_courses_template/presentation/empty_screen.dart';
import 'package:surf_flutter_courses_template/main.dart';
import 'package:surf_flutter_courses_template/utils/extensions/string_x.dart';

class ColorsScreen extends StatefulWidget {
  const ColorsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ColorsScreenState();
}

class _ColorsScreenState extends State<ColorsScreen> {
  Future<List<ColorEntity>>? _data;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    _data = colorsRepository.getColors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          bottom: const PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                    'Эксклюзивная палитра «Colored Box»',
                    style: font30Weight700,
                    maxLines: 2
                ),
              )
          )
      ),
      body: FutureBuilder<List<ColorEntity>>(
          future: _data,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const _ErrorWidget();
              } else if (snapshot.hasData) {
                final data = snapshot.data;
                return data != null
                    ? _ContentWidget (data: data)
                    : const EmptyScreen();
              }
            }
            return const _LoadingWidget();
          }
      ),
    );
  }
}

class _ContentWidget extends StatelessWidget {
  final List<ColorEntity> data;

  const _ContentWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.8,
          mainAxisSpacing: 40.0,
          crossAxisSpacing: 22
        ),
        itemCount: data.length,
        itemBuilder: (_, i) => _ColorWidget(entity: data[i]));
  }
}

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