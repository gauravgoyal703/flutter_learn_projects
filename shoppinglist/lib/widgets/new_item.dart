import 'package:flutter/material.dart';
import 'package:shoppinglist/data/categories.dart';
import 'package:shoppinglist/models/category.dart';
import 'package:shoppinglist/service/grocery_service.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() {
    return NewItemState();
  }
}

class NewItemState extends State<NewItem> {
  final _finalKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredQuantity = 1;
  var _selectedCategory = categories[Categories.fruit]!;
  var _isSending = false;

  void _saveItem() {
    if (_finalKey.currentState!.validate()) {
      _finalKey.currentState!.save();
      setState(() {
        _isSending = true;
      });
      Map<String, dynamic> groceryItem = {
        'name': _enteredName,
        'quantity': _enteredQuantity,
        'category': _selectedCategory.title
      };
      GroceryService().addItem(groceryItem).then((value) {
        Navigator.of(context).pop(value);
      });
    }
  }

  void _resetItem() {
    _finalKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _finalKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                validator: (value) {
                  if (isEmpty(value) ||
                      value!.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'Name must be between 1 and 50 characters';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
                onSaved: (newValue) {
                  _enteredName = newValue!;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Quantity'),
                      ),
                      initialValue: _enteredQuantity.toString(),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (isEmpty(value) ||
                            int.tryParse(value!) == null ||
                            int.tryParse(value)! <= 0) {
                          return 'Must be a valid, positive number';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _enteredQuantity = int.parse(newValue!);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _selectedCategory,
                      items: getDropdownList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: _isSending ? null : _resetItem,
                      child: const Text('Reset')),
                  ElevatedButton(
                    onPressed: _isSending ? null : _saveItem,
                    child: _isSending
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Add Item'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  bool isEmpty(value) {
    if (value == null || value.isEmpty || value.trim().length <= 0) {
      return true;
    }
    return false;
  }

  List<DropdownMenuItem<Category>> getDropdownList() {
    return categories.entries.map((category) {
      return DropdownMenuItem(
        value: category.value,
        child: Row(
          children: [
            Container(
              width: 16,
              height: 16,
              color: category.value.color,
            ),
            const SizedBox(),
            Text(category.value.title),
          ],
        ),
      );
    }).toList();
  }
}
