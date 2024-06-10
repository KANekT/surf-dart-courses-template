
import 'package:flutter/material.dart';
import 'package:surf_flutter_courses_template/assets/app_strings.dart';
import 'package:surf_flutter_courses_template/domain/entity/photo_entity.dart';
import 'package:surf_flutter_courses_template/domain/entity/photo_state_entity.dart';
import 'package:surf_flutter_courses_template/presentation/photo_screen.dart';
import 'package:surf_flutter_courses_template/main.dart';
import 'package:union_state/union_state.dart';

import 'package:surf_flutter_courses_template/app_consts.dart';

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
            mainAxisSpacing: 5,
            crossAxisSpacing: 3
        ),
        itemCount: data.length,
        itemBuilder: (_, i) => _PhotoWidget(index: i, entities: data));
  }
}

class _PhotoWidget extends StatelessWidget {
  final int index;
  final List<PhotoEntity> entities;

  const _PhotoWidget({required this.index, required this.entities});

  @override
  Widget build(BuildContext context) {
    final entity = entities[index];
    return Center(
      child: GestureDetector(
        onTap: () => _onTap(context, indexPhoto: index),
        child: AspectRatio(
          aspectRatio: 1,
          child: Hero(
            tag: entity.name,
            child: Image.network(entity.getPath(),
              fit: BoxFit.cover,
              loadingBuilder: (_, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes! : null
                  ),
                );
              },
              errorBuilder: (_, error, stackTrace) =>
                  Center(
                      child: Text(error.toString())
                  ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context, {required int indexPhoto}) {
    Navigator
        .of(context)
        .push(
        MaterialPageRoute(
            builder: (_) =>
                PhotoScreen(
                  photoState: PhotoStateEntity(
                      index: index,
                      photos: entities
                  ),
                )
        )
    );
  }
}


class _EmptyWidget extends StatelessWidget {
  const _EmptyWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(AppStrings.emptyText),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(AppStrings.errorText),
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