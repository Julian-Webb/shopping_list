import 'package:flutter/material.dart';
import 'package:shopping_list/data/dummy_items.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItems = groceryItems;
  Widget content = const Center(
    child: Text('No items added yet.'),
  );

  void _addItem() async {
    // the type of push<> (the part that is in <>) tells us the return type of
    // this generic function
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );
    if (newItem == null) {
      // return;
    } else {
      setState(() {
        _groceryItems.add(newItem);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      // should show the list of grocery items or Text if none were added yet
      body: _groceryItems.isEmpty
          ? const Center(child: Text('No items to display.'))
          : ListView.builder(
              itemCount: _groceryItems.length,
              itemBuilder: (context, index) {
                final item = _groceryItems[index];
                return Dismissible(
                  key: ValueKey(item.id),
                  onDismissed: (direction) {
                    setState(
                      () {
                        _groceryItems.removeAt(index);
                      },
                    );
                  },
                  background: Container(color: Colors.red),
                  child: ListTile(
                    leading: Container(
                      width: 24,
                      height: 24,
                      color: item.category.color,
                    ),
                    title: Text(item.name),
                    trailing: Text(item.quantity.toString()),
                  ),
                );
              },
            ),
    );
  }
}
