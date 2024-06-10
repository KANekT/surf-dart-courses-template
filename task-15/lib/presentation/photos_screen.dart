import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:surf_flutter_courses_template/domain/entity/photo_entity.dart';
import 'package:surf_flutter_courses_template/presentation/photo_screen.dart';
import 'package:surf_flutter_courses_template/presentation/empty_screen.dart';
import 'package:surf_flutter_courses_template/main.dart';
import 'package:union_state/union_state.dart';

import 'package:surf_flutter_courses_template/assets/app_images.dart';

class PhotosScreen extends StatefulWidget {
  const PhotosScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  final screenState = UnionStateNotifier<List<PhotoEntity>>.loading();

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final data = await photosRepository.getPosts();
      screenState.content(data);
    } on Exception catch (e) {
      screenState.failure(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AppImages.logo),
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
      ),
      body: UnionStateListenableBuilder<List<PhotoEntity>>(
        unionStateListenable: screenState,
        loadingBuilder: (_, __) => const _LoadingWidget(),
        builder: (_, state) =>
        state.isNotEmpty
            ? _ContentWidget(data: state)
            : const _EmptyWidget(),
        failureBuilder: (_, __, ___) => const _ErrorWidget(),
      ),
    );
  }
}

class _ContentWidget extends StatelessWidget {
  final List<PhotoEntity> data;

  const _ContentWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 3
        ),
        itemCount: data.length,
        itemBuilder: (_, i) => _PhotoWidget(index: i, entity: data[i]));
  }
}

class _PhotoWidget extends StatelessWidget {
  final int index;
  final PhotoEntity entity;

  const _PhotoWidget({required this.index, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => _onTap(context),
        child: AspectRatio(
            aspectRatio: 1,
          child: Hero(
            tag: entity.path,
            child: Image.asset(entity.path,
            fit: BoxFit.cover,
            ),
          ),
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
}


class _EmptyWidget extends StatelessWidget {
  const _EmptyWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Постов нет'),
    );
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