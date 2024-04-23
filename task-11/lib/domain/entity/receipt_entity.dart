import 'package:surf_flutter_courses_template/domain/entity/product_entity.dart';

// Модель чека о покупке
class ReceiptEntity {
  final int id;
  final DateTime date;
  final List<ProductEntity> products;

  ReceiptEntity({required this.id, required this.date, required this.products});
}