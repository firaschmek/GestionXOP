
import 'package:flutter/foundation.dart';

import 'commande_item.dart';

class CartModel extends ChangeNotifier {
  int item_count = 0;
  List<CommandItem> _items = [];

  void addToItems(CommandItem p) {
    _items.add(p);
    item_count++;
    notifyListeners();
  }

  void removeFromItems(CommandItem p) {
    _items.remove(p);
    item_count--;
    notifyListeners();
  }

  void clearItems() {
    _items = [];
    item_count = 0;
    notifyListeners();
  }

  double get totalPrice => _items.fold(
      0,
          (total, current) =>
      total + double.parse(current.price) * current.quantity);

  List<CommandItem> get items => _items;
}