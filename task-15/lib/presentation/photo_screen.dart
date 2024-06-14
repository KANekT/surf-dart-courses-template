import 'package:flutter/material.dart';
import 'package:surf_flutter_courses_template/domain/entity/photo_entity.dart';
import 'package:surf_flutter_courses_template/domain/entity/photo_state_entity.dart';

class PhotoScreen extends StatefulWidget {
  final PhotoStateEntity photoState;

  const PhotoScreen({super.key, required this.photoState});

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  late final PageController pageController;
  late double _currentPageValue;

  static const double pageTop = 40.0;
  static const double pageBottom = 72.0;

  // Уменьшение след / пред фотографии
  final double _scaleFactor = 0.8;

  @override
  void initState() {
    super.initState();
    pageController =
        PageController(initialPage: widget.photoState.index, viewportFraction: 0.8)
    ..addListener(_listenToPageController);
    _currentPageValue = widget.photoState.index.toDouble();
  }

  @override
  void dispose() {
    pageController
    ..removeListener(_listenToPageController)
    ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final photos = widget.photoState.photos;
    const sumPadding = pageTop + pageBottom;
    final heightPageView = MediaQuery
        .sizeOf(context)
        .height - kToolbarHeight - sumPadding;

    return Scaffold(
      appBar: AppBar(
        leading: _BackButton(),
        actions: [
          _PhotosIndicator(
              countPhotos: photos.length,
              currentPhoto: _currentPageValue.round() + 1
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: pageTop, bottom: pageBottom),
        child: PageView.builder(
            controller: pageController,
            itemCount: widget.photoState.photos.length,
            itemBuilder: (_, index) {
              final photo = photos[index];
              Matrix4 matrix = Matrix4.identity();

              var scale = 0.8;

              // только текущее фото + пред/след
              if (index == _currentPageValue.floor() ||
                  index == _currentPageValue.floor() + 1 ||
                  index == _currentPageValue.floor() - 1) {
                scale =
                    1 - (_currentPageValue - index).abs() * (1 - _scaleFactor);
              }

              var transform = heightPageView * (1 - scale) / 2;

              matrix = Matrix4.diagonal3Values(1.0, scale, 1.0)
              // смещение виджета для выравнивания по центру
                ..setTranslationRaw(0, transform, 0);

              return Transform(
                  transform: matrix,
                  child: _PhotoFullScreenWidget(
                      photo: photo,
                      tag: index == _currentPageValue.floor()
                          ? photo.getPath()
                          : null
                  ));
            }
        ),
      ),
    );
  }

  void _listenToPageController() {
    double page = pageController.page ?? 0;

    setState(() {
      _currentPageValue = page;
    });
  }
}

class _PhotoFullScreenWidget extends StatelessWidget {
  final PhotoEntity photo;

  final String? tag;

  const _PhotoFullScreenWidget({required this.photo, this.tag});

  @override
  Widget build(BuildContext context) {
    final imageWidget = Image.network(
      photo.getPath(),
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
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: AspectRatio(
        aspectRatio: 1 / 2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.0),
          child: tag == null
              ? imageWidget
              : Hero(tag: photo.name, child: imageWidget),
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }
}

class _PhotosIndicator extends StatelessWidget {
  // всего фото
  final int countPhotos;

  // текущее фото
  final int currentPhoto;

  const _PhotosIndicator({
    required this.currentPhoto,
    required this.countPhotos
  });

  @override
  Widget build(BuildContext context) {
    final themeText = Theme
        .of(context)
        .textTheme
        .titleLarge;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text.rich(
          TextSpan(
              text: '$currentPhoto',
              style: themeText?.copyWith(color: Colors.black),
              children: [
                TextSpan(
                    text: '/$countPhotos',
                    style: themeText?.copyWith(color: Colors.black)
                )
              ]
          )
      ),
    );
  }
}