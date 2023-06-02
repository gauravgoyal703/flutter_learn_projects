import 'dart:convert';

import 'package:shoppinglist/models/grocery_item.dart';
import 'package:shoppinglist/service/base_service.dart';

const String host =
    'asflutter-prep-5ae6c-default-rtdb.asia-southeast1.firebasedatabase.app';

final uri = Uri.https(host, 'shopping-list.json');

class GroceryService {
  Future<GroceryItem> addItem(Map<String, dynamic> item) async {
    final response = await BaseClient()
        .post(uri, {'Content-Type': 'application/json'}, item);
    Map<String, dynamic> itemData = json.decode(response);
    return GroceryItem.fromJson(itemData['name'], item);
  }

  Future<dynamic> removeItem(String id) {
    Uri removeUri = Uri.https(host, 'shopping-list/$id.json');
    return BaseClient().delete(removeUri, {}, null);
  }

  Future<List<GroceryItem>> getItems() async {
    final response = await BaseClient().get(uri);
    if (response == 'null') {
      return [];
    }
    Map<String, dynamic> itemMap = json.decode(response);
    return itemMap.entries
        .map<GroceryItem>(
            (entry) => GroceryItem.fromJson(entry.key, entry.value))
        .toList();
  }
}
