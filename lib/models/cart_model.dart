import 'package:flutter/foundation.dart';

import 'commande_item.dart';

class CartModel extends ChangeNotifier {
  int item_count = 0;
  List<CommandItemEntity> _items = [];

  void addToItems(CommandItemEntity p) {
    _items.add(p);
    item_count++;
    notifyListeners();
  }

  double sousTotal() {
    double total = _items.fold(
        0, (sum, item) => sum + double.parse(item.price) * item.quantity);
    return total;
  }

  void removeFromItems(CommandItemEntity p) {
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

  List<CommandItemEntity> get items => _items;
}
