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

import '../domain/entity/category_type.dart';
import '../domain/entity/product_entity.dart';
import '../domain/entity/receipt_entity.dart';
import '../main.dart';

class ReceiptScreen extends StatefulWidget {
  // номер чека
  final int id;

  const ReceiptScreen({Key? key, required this.id}) : super(key: key);

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
          return _LoadingWidget();
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
          icon: Icon(Icons.arrow_back_ios,
          color: Colors.green),
        ),
        title: Column(
          children: [
            Text('Чек № ${widget.data.id}',
        style: Theme
            .of(context)
            .textTheme
            .labelLarge),
            Text(widget.data.date.toStringDateAndTime(),
                style: Theme
                    .of(context)
                    .textTheme
                    .labelSmall)
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 8, top: 24),
            child: Row(
              children: [
                Expanded(child: Text(
                  'Список покупок',
                  style: Theme
                      .of(context)
                      .textTheme
                      .labelLarge,
                )),
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    height: 32.0,
                    width: 32.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: const Color.fromRGBO(241, 241, 241, 1),
                    ),
                    child: SvgPicture.asset(
                          'assets/icons/sort.svg',
                          semanticsLabel: 'Поиск'
                    ),
                  ),
                  onTap: () {
                    _onPressedFilter();
                  },
                )
              ],
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        itemBuilder: (_, i) {
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
        },
        itemCount: Category.values.length,
      ),
    );
  }

  Future<void> _onPressedFilter() async {
    final SortingType? filter = await showFlexibleBottomSheet(
        initHeight: 0.0,
        bottomSheetColor: Colors.transparent,
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
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(category),
        ...productOfCategory
            .sortByFilter(filter)
            .map((e) =>
        /*
            ListTile(
                title: Text(e.title),
                trailing: Text(e.decimalPrice.toFormattedCurrency())
            )
            */
        _ProductWidget(product: e)
        )
            .toList(),
        const Divider(),
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
    return Column(
      children: [
        Row(
          children: [
            //Expanded(child: Text(description, style: textTheme.bodyMedium)),
            //Text(value, style: textTheme.headlineSmall),
          ],
        )
    ]
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
      children: [
        const Text('В вашей покупке'),
        _RowWidget(description: _plural(products.length),
            value: fullTotal.toFormattedCurrency()),
        _RowWidget(
            description: 'Скидка 0%', value: discount.toFormattedCurrency()),
        _RowWidget(description: 'Итого', value: total.toFormattedCurrency())
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

    return discount.isNotEmpty ?
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

  const _RowWidget({
    required this.description,
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Expanded(child: Text(description, style: textTheme.bodyMedium)),
        Text(value, style: textTheme.headlineSmall),
      ],
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Произошла ошибка при загрузке'),
    );
  }
}