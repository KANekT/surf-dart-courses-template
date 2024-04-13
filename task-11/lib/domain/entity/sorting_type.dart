// типы сортировки
enum SortingType{
  none(type: FilterType.none, name: 'Без сортировки'),
  nameFromA(type: FilterType.none, name: 'По имени от А до Я'),
  nameFromZ(type: FilterType.none, name: 'По имени от Я до А'),
  ascOrder(type: FilterType.none, name: 'По возрастанию'),
  descOrder(type: FilterType.none, name: 'По убыванию'),
  typeFromA(type: FilterType.none, name: 'По типу от А до Я'),
  typeFromZ(type: FilterType.none, name: 'По типу от Я до А')
  ;

  final FilterType type;
  final String name;

  const SortingType({required this.type, required this.name});
}

// группы фильтров
enum FilterType{
  none('Без сортировки'),
  byName('По имени'),
  byPrice('По цене'),
  byType('По типу');

  final String name;

  const FilterType(this.name);
}