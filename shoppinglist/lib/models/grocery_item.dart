import 'package:shoppinglist/data/categories.dart';
import 'package:shoppinglist/models/category.dart';

class GroceryItem {
  const GroceryItem(
      {required this.id,
      required this.name,
      required this.quantity,
      required this.category});
  final String id;
  final String name;
  final int quantity;
  final Category category;

  factory GroceryItem.fromJson(String id, Map<String, dynamic> itemVal) {
    return GroceryItem(
      name: itemVal['name'],
      id: id,
      quantity: itemVal['quantity'] as int,
      category: categories.entries
          .firstWhere((catItem) => catItem.value.title == itemVal['category'])
          .value,
    );
  }
}
