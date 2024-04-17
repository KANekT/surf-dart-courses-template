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
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 24.0),
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
        if(type == FilterType.none) Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Row(
            children: [
              const Expanded(
                  child: Text('Сортировка', style: font20Weight700)
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.clear),
              )
            ],
          ),
        ),
        if(type != FilterType.none) Text(type.name, style: font12Weight400),
        ...sortingList
            .map((e) =>
            CustomRadio(
                value: e,
                groupValue: selectedFilter,
                onChanged: onChanged
            )
        ),
        if(!isLastType) const Divider(color: colorBtnGrey, height: 16.0,),
        if(isLastType) ...[
          SizedBox(height: 24.0),
          Container(
            width: double.infinity,
            child: FilledButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(colorGreen),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            side: BorderSide(color: colorGreen)
                        )
                    )
                ),
                onPressed: onDone,
                child: const Text('Готово', style: font16Weight700Default)
            ),
          )
        ]
      ],
    );
  }
}

class CustomRadio extends StatefulWidget {
  final SortingType value;
  final SortingType groupValue;
  final void Function(SortingType) onChanged;
  const CustomRadio({super.key, required this.value, required this.groupValue, required this.onChanged});

  @override
  State<CustomRadio> createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  @override
  Widget build(BuildContext context) {
    bool selected = (widget.value == widget.groupValue);

    return InkWell(
      onTap: () => widget.onChanged(widget.value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: selected ? 7 : 2,
                  color: selected ? colorGreen : colorGrey,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Text(widget.value.name, style: font16Weight400),
          ],
        ),
      ),
    );
  }
}