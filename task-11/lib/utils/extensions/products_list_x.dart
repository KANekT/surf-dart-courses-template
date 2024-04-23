import 'package:surf_flutter_courses_template/domain/entity/product_entity.dart';
import 'package:surf_flutter_courses_template/domain/entity/sorting_type.dart';

extension ProductListX on List<ProductEntity> {
  List<ProductEntity> sortByFilter(SortingType type) {
    final List<ProductEntity> sortedList = switch(type){
      SortingType.none => this,
      SortingType.nameFromA => _sortByName(this),
      SortingType.nameFromZ => _sortByName(this, isFromA: false),
      SortingType.ascOrder => _sortByPrice(this),
      SortingType.descOrder => _sortByPrice(this, isCheapFirst: false),
      SortingType.typeFromA => this,
      SortingType.typeFromZ => this,
    };

    return sortedList;
  }

  List<ProductEntity> _sortByPrice(List<ProductEntity> initialList, {bool isCheapFirst = true}){
    final result = initialList;

    result.sort(
        (a, b) => isCheapFirst ? a.decimalPrice.compareTo(b.decimalPrice) : b.decimalPrice.compareTo(a.decimalPrice)
    );

    return result;
  }

  List<ProductEntity> _sortByName(List<ProductEntity> initialList, {bool isFromA = true}){
    final result = initialList;

    result.sort(
            (a, b) => isFromA ? a.title.compareTo(b.title) : b.title.compareTo(a.title)
    );
    return result;
  }
}