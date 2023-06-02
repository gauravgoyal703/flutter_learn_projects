import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:shoppinglist/models/grocery_item.dart';
import 'package:shoppinglist/service/grocery_service.dart';
import 'package:shoppinglist/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  late Future<List<GroceryItem>> _groceryItems;

  @override
  void initState() {
    super.initState();
    _groceryItems = GroceryService().getItems();
  }

  void _addItem() async {
    final item = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );

    if (item == null) {
      return;
    }

    setState(() {
      _groceryItems.then((value) => value.add(item));
    });
  }

  void _removeItem(List<GroceryItem> groceryItems, GroceryItem item) {
    int index = groceryItems.indexOf(item);
    setState(() {
      groceryItems.remove(item);
    });
    GroceryService().removeItem(item.id).onError((error, stackTrace) {
      log(error.toString());
      setState(() {
        groceryItems.insert(index, item);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: _groceryItems,
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.none) {
              return const Text('Cannot establish connection with the server.');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('Please add item');
            }
            return buildDataLayout(snapshot.data as List<GroceryItem>);
          },
        ),
      ),
    );
  }

  Widget buildDataLayout(List<GroceryItem> groceryItems) {
    return ListView.builder(
      itemCount: groceryItems.length,
      itemBuilder: (ctx, index) => Dismissible(
        onDismissed: (direction) {
          _removeItem(groceryItems, groceryItems[index]);
        },
        key: ValueKey(groceryItems[index].id),
        child: ListTile(
          title: Text(groceryItems[index].name),
          leading: Container(
            width: 24,
            height: 24,
            color: groceryItems[index].category.color,
          ),
          trailing: Text(
            groceryItems[index].quantity.toString(),
          ),
        ),
      ),
    );
  }
}
