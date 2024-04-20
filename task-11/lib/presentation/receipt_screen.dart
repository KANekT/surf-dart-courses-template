import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:surf_flutter_courses_template/domain/entity/sorting_type.dart';
import 'package:surf_flutter_courses_template/presentation/empty_screen.dart';
import 'package:surf_flutter_courses_template/presentation/filter_screen.dart';
import 'package:surf_flutter_courses_template/utils/extensions/date_time_x.dart';
import 'package:surf_flutter_courses_template/utils/extensions/decimal_x.dart';
import 'package:surf_flutter_courses_template/utils/extensions/products_list_x.dart';

import 'package:surf_flutter_courses_template/domain/entity/category_type.dart';
import 'package:surf_flutter_courses_template/domain/entity/product_entity.dart';
import 'package:surf_flutter_courses_template/domain/entity/receipt_entity.dart';
import 'package:surf_flutter_courses_template/main.dart';

class ReceiptScreen extends StatefulWidget {
  // номер чека
  final int id;

  const ReceiptScreen({super.key, required this.id});

  @override
  State<StatefulWidget> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  Future<ReceiptEntity>? _data;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    _data = shoppingListRepository.getReceipt(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ReceiptEntity>(
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
  final ReceiptEntity data;

  const _ContentWidget({required this.data});

  @override
  State<_ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<_ContentWidget> {
  SortingType _currentFilter = SortingType.none;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios,
              color: colorGreen),
        ),
        title: Column(
          children: [
            Text('Чек № ${widget.data.id}',
                style: font18Weight700),
            Text(widget.data.date.toStringDateAndTime(),
                style: font10Weight400Grey)
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 20, right: 20, bottom: 8, top: 24),
            child: Row(
              children: [
                const Expanded(child: Text(
                  'Список покупок',
                  style: font18Weight700,
                )),
                InkWell(
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        height: 32.0,
                        width: 32.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          color: colorBtnGrey,
                        ),
                        child: SvgPicture.asset(
                            'assets/icons/sort.svg',
                            semanticsLabel: 'Поиск'
                        ),
                      ),
                      if (_currentFilter != SortingType.none)
                        Positioned(
                          bottom: 5.0,
                          right: 5.0,
                          child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: colorGreen,
                                shape: BoxShape.circle,
                              )
                          ),
                        )
                    ],
                  ),
                  onTap: () async {
                    _onPressedFilter();
                  },
                )
              ],
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        itemBuilder: (_, i) {
          if (_currentFilter == SortingType.none) {
            final isLastProd = i == widget.data.products.length - 1;

            if (isLastProd) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  _ProductWidget(product: widget.data.products[i]),
                  _FinancialWidget(
                    products: widget.data.products,
                  )
                ],
              );
            } else {
              return _ProductWidget(product: widget.data.products[i]);
            }
          } else {
            final cat = Category.values[i];
            final categoryProducts = widget.data.products.where((
                product) => product.category == cat).toList();
            final isLastCat = i == Category.values.length - 1;

            return categoryProducts.isNotEmpty ? _CategoryWidget(
              category: cat.name,
              productOfCategory: categoryProducts,
              products: widget.data.products,
              isLastCat: isLastCat,
              filter: _currentFilter,
            ) :
            const SizedBox();
          }
        },
        itemCount: _currentFilter == SortingType.none ? widget.data.products.length : Category.values.length,
      ),
    );
  }

  Future<void> _onPressedFilter() async {
    final SortingType? filter = await showFlexibleBottomSheet(
        initHeight: 0.8,
        bottomSheetColor: Colors.transparent,
        bottomSheetBorderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        context: context,
        builder: (_, __, ___) => FilterScreen(filter: _currentFilter),
        isExpand: true
    );

    if (filter == null) {
      return;
    }

    if (filter != _currentFilter) {
      setState(() {
        _currentFilter = filter;
      });
    }
  }
}

class _CategoryWidget extends StatelessWidget {
  final String category;
  final List<ProductEntity> productOfCategory;
  final List<ProductEntity> products;
  final bool isLastCat;
  final SortingType filter;

  const _CategoryWidget({
    required this.category,
    required this.productOfCategory,
    required this.products,
    required this.isLastCat,
    required this.filter
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        if (filter != SortingType.none) Text(category, style: font16Weight700),
        ...productOfCategory
            .sortByFilter(filter)
            .map((e) =>
                _ProductWidget(product: e)
            ),
        if (filter != SortingType.none) const Divider(),
        if(isLastCat)
          _FinancialWidget(
            products: products,
          )
      ],
    );
  }
}

class _ProductWidget extends StatelessWidget {
  final ProductEntity product;

  const _ProductWidget({
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                  product.imageUrl,
                  height: 68.0,
                  width: 68.0,
                  fit: BoxFit.cover),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(product.title,
                      style: font12Weight400),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(product.amount.value.toString()),
                      Row(
                        children: [
                          if (product.sale > 0) Text(product.decimalSale
                              .toFormattedCurrency(
                              symbol: 'руб', decimalDigits: 0),
                              style: font18Weight400Grey),
                          SizedBox(
                              width: 80.0,
                              child: Text(product.decimalPrice
                                  .toFormattedCurrency(
                                  symbol: '', decimalDigits: 0),
                                textAlign: TextAlign.right,
                                style: product.sale > 0 ? font12Weight700Red :
                                font12Weight700
                                ,
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
class _FinancialWidget extends StatelessWidget {
  final List<ProductEntity> products;

  const _FinancialWidget({
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    final fullTotal = _getFullTotal(products);
    final discount = _getDiscount(products);
    final total = fullTotal - discount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24.0),
        const Text('В вашей покупке', style: font16Weight700),
        _RowWidget(description: _plural(products.length),
            value: fullTotal.toFormattedCurrency(symbol: 'руб', decimalDigits: 0)),
        _RowWidget(
            description: 'Скидка 0%', value: discount.toFormattedCurrency(symbol: 'руб', decimalDigits: 0)),
        _RowWidget(description: 'Итого', value: total.toFormattedCurrency(symbol: 'руб', decimalDigits: 0), isItogo: true)
      ],
    );
  }

  String _plural(int count) {
    return Intl.plural(
        count,
        zero: 'нет товаров',
        one: '$count товар',
        few: '$count товара',
        many: '$count товаров',
        other: '$count товара',
        locale: 'ru'
    );
  }

  Decimal _getFullTotal(List<ProductEntity> products) {
    return products.fold(
        Decimal.zero, (previousValue, element) => previousValue + element.decimalPrice);
  }

  Decimal _getDiscount(List<ProductEntity> products) {
    final discount = products.where((element) => element.sale > 0).toList();

    return discount.isEmpty ?
    Decimal.zero :
    discount.fold(Decimal.zero, (previousValue, element) =>
    previousValue +
        _calculateDiscountForProduct(
            element.decimalPrice, element.sale.toString()
        )
    );
  }

  Decimal _calculateDiscountForProduct(Decimal price, String discountPercent) {
    final discountAmount = (price * Decimal.parse(discountPercent) /
        Decimal.fromInt(100)).toDecimal();
    return price - discountAmount;
  }
}

class _RowWidget extends StatelessWidget {
  final String description;
  final String value;
  final bool isItogo;

  const _RowWidget({
    required this.description,
    required this.value,
    this.isItogo = false
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(child: Text(description, style: isItogo ? font16Weight700 : font12Weight400)),
          Text(value, style: isItogo ? font16Weight700 : font12Weight700),
        ],
      ),
    );
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