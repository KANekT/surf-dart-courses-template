import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surf_flutter_courses_template/domain/entity/sorting_type.dart';
import 'package:surf_flutter_courses_template/main.dart';

class FilterScreen extends StatefulWidget {
  final SortingType filter;

  const FilterScreen({super.key, required this.filter});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen>{
  SortingType _selectedFilter = SortingType.none;

  @override
  void initState() {
    super.initState();
    _selectedFilter = widget.filter;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        itemBuilder: (_, i) {
          final type = FilterType.values[i];
          final sortingList = SortingType.values.where((e) => e.type == type)
              .toList();
          final isLastType = i == FilterType.values.length - 1;

          return sortingList.isNotEmpty ? _FilterWidget(
            type: type,
            sortingList: sortingList,
            selectedFilter: _selectedFilter,
            isLastType: isLastType,
            onChanged: _onChanged,
            onDone: _onPressDone,
          ) :
          const SizedBox();
        },
        itemCount: FilterType.values.length,
      ),
    );
  }

  void _onChanged(SortingType? value) {
    final newValue = value;
    if(newValue == null || (newValue == _selectedFilter)) return;

    setState(() {
      _selectedFilter = newValue;
    });
  }

  void _onPressDone() {
    Navigator.of(context).pop(_selectedFilter);
  }
}

class _FilterWidget extends StatelessWidget {
  final FilterType type;
  final List<SortingType> sortingList;
  final SortingType selectedFilter;
  final bool isLastType;
  final ValueChanged<SortingType?> onChanged;
  final VoidCallback onDone;

  const _FilterWidget({
    required this.type,
    required this.sortingList,
    required this.selectedFilter,
    required this.isLastType,
    required this.onChanged,
    required this.onDone
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        if(type == FilterType.none) Text('Сортировка', style: font20Weight700,),
        if(type != FilterType.none) Text(type.name),
        ...sortingList
            .map((e) =>
            CupertinoListTile(
                title: Text(e.name, style: font16Weight400),
                leading: CupertinoRadio<SortingType>(
                    value: e,
                    activeColor: colorGreen,
                    groupValue: selectedFilter,
                    onChanged: onChanged
                )
            )
        ),
        const Divider(),
        if(isLastType) ...[
          const SizedBox(height: 20),
          FilledButton(onPressed: onDone, child: const Text('Готово'))
        ]
      ],
    );
  }
}