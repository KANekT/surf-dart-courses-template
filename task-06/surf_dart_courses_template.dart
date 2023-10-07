final articles = '''
1,хлеб,Бородинский,500,5
2,хлеб,Белый,200,15
3,молоко,Полосатый кот,50,53
4,молоко,Коровка,50,53
5,вода,Апельсин,25,100
6,вода,Бородинский,500,5
''';

class Product {
  final int key;
  final String category;
  final String name;
  final int price;
  final int amount;

  Product(this.key, this.category, this.name, this.price, this.amount);

  @override String toString() {
    return '$key\t$category\t$name\t$price\tрублей\t$amount\tшт';
  }
}

List<Product> createProductList() {
  List<String> lines = articles.split('\n'); // Разбиваем строку на строки

  List<Product> productList = [];

  for (String line in lines) {
    if (line.isEmpty) {
      continue;
    }

    List<String> parts = line.split(','); // Разбиваем строку на части по запятым

    int key = int.parse(
        parts[0].trim()); // Получаем Id товара и преобразуем в целое число
    String category = parts[1]
        .trim(); // Получаем Категорию товара и удаляем лишние пробелы
    String name = parts[2]
        .trim(); // Получаем Наименование товара и удаляем лишние пробелы
    int price = int.parse(
        parts[3].trim()); // Получаем Цену товара и преобразуем в целое число
    int amount = int.parse(
        parts[4].trim()); // Получаем Количество товара и преобразуем в целое число

    Product product = Product(key, category, name, price, amount);
    // Создаем объект Product с полученными значениями
    productList.add(product); // Добавляем объект в список
  }
  return productList;
}

abstract class Filter<T> {
  bool apply(T item);
}

List<T> applyFilter<T>(List<T> items, Filter<T> filter) {
  List<T> filteredItems = [];
  for (var item in items) {
    if (filter.apply(item)) {
      filteredItems.add(item);
    }
  }
  return filteredItems;
}

class CategoryFilter implements Filter<Product> {
  String category;

  CategoryFilter(this.category);

  bool apply(Product product) {
    return product.category == category;
  }
}

class PriceFilter implements Filter<Product> {
  final int maxPrice;

  PriceFilter(this.maxPrice);

  bool apply(Product product) {
    return product.price <= maxPrice;
  }
}

class AmountFilter implements Filter<Product> {
  int maxStock;

  AmountFilter(this.maxStock);

  bool apply(Product product) {
    return product.amount < maxStock;
  }
}

void main() {
  List<Product> products = createProductList();

  print('Пример фильтра по категории');
  Filter<Product> categoryFilter = CategoryFilter('хлеб');
  for (var product in applyFilter(products, categoryFilter)) {
    print(product.toString());
  }

  print('\nПример фильтра по цене');
  Filter<Product> priceFilter = PriceFilter(200);
  for (var product in applyFilter(products, priceFilter)) {
    print(product.toString());
  }

  print('\nПример фильтра по количеству');
  Filter<Product> amountFilter = AmountFilter(6);
  for (var product in applyFilter(products, amountFilter)) {
    print(product.toString());
  }
}