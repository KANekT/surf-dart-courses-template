import 'package:surf_flutter_courses_template/domain/entity/receipt_entity.dart';
import 'package:surf_flutter_courses_template/data/mock_data.dart';

class ShoppingListRepository {
  Future<ReceiptEntity> getReceipt(int id) async {
    // данные чека
    return Future.value(
        ReceiptEntity(
            id: id,
            date: DateTime(2024, 02, 04, 23, 32,04),
            products: dataForStudents
        )
    );
  }
}