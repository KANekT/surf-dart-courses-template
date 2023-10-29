import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:surf_flutter_courses_template/domain/entity/color_entity.dart';
import 'package:surf_flutter_courses_template/presentation/empty_screen.dart';
import 'package:surf_flutter_courses_template/main.dart';

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
    _data = colorListRepository.getColors();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ColorEntity>>(
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
    );
  }
}

class _ContentWidget extends StatefulWidget {
  final List<ColorEntity> data;

  const _ContentWidget({required this.data});

  @override
  State<_ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<_ContentWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Эксклюзивная палитра «Colored Box»',
            style: font30Weight700,
            maxLines: 2),
        toolbarHeight: 98,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        itemBuilder: (_, i) {
            return Text(widget.data[i].name);
        },
        itemCount: widget.data.length,
      ),
    );
  }

  Future<void> _onPressedFilter() async {
      setState(() {

      });
    }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Произошла ошибка при загрузке'),
    );
  }
}