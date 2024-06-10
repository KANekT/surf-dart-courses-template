import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:surf_flutter_courses_template/domain/entity/photo_entity.dart';
import 'package:surf_flutter_courses_template/domain/entity/rgb_type.dart';
import 'package:surf_flutter_courses_template/main.dart';
import 'package:surf_flutter_courses_template/utils/extensions/string_x.dart';

class ColorScreen extends StatelessWidget {
  final ColorEntity colorEntity;

  const ColorScreen({super.key, required this.colorEntity});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .sizeOf(context)
        .height;
    final colorBoxHeight = height / 2;
    final preferredSizeHeight = colorBoxHeight - kToolbarHeight;

    return Scaffold(
        appBar: AppBar(
            toolbarHeight: kToolbarHeight, // деaолтная высота 56
            foregroundColor: Colors.white,
            flexibleSpace: SizedBox(
              width: double.infinity,
              height: colorBoxHeight, // половина экрана
              child: ColoredBox(
                color: colorEntity.value.hexToColor() ?? Colors.white,
              ),
            ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(preferredSizeHeight),
            child: const SizedBox.shrink(),
          ),
        ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(colorEntity.name, style: font30Weight700),
            const SizedBox(height: 16),
            _ShadowBoxWidget(title: AppStrings.hexColorsScreen, value: colorEntity.value),
            const SizedBox(height: 16),
            _RgbWidget(color: colorEntity.value.hexToColor())
          ],
        ),
      ),
    );
  }
}

class _ShadowBoxWidget extends StatelessWidget {
  final String title;
  final String value;

  const _ShadowBoxWidget({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade100,
                blurRadius: 12,
                offset: const Offset(0, 12)
            )
          ]

      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () => _onTap(context),
          child: Row(
            children: [
              Expanded(child: Text(
                title,
                style: font16Weight400,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )),
              Text(value, style: font16Weight400)
            ],
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: value));
    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Скопировали ${value}"),
    ));
  }
}

class _RgbWidget extends StatelessWidget {
  final Color color;

  const _RgbWidget({required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
        children: RgbType.values
            .expandIndexed(
                (i, e) =>
            [
              Expanded(
                child: _ShadowBoxWidget(
                    title: e.name,
                    value: switch (e) {
                      RgbType.red => color.red.toString(),
                      RgbType.green => color.green.toString(),
                      RgbType.blue => color.blue.toString()
                    }
                ),
              ),
              if (i != RgbType.values.length - 1) const SizedBox(width: 8),
            ]
        ).toList()
    );
  }
}