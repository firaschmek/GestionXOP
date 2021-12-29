import 'package:appgestion/model/Product.dart';
import 'package:flutter/foundation.dart';

class CartModel extends ChangeNotifier {
  int item_count = 0;
  List<Product> _items = [];

  void addToItems(Product p) {
    _items.add(p);
    item_count++;
    notifyListeners();
  }

  void removeFromItems(Product p) {
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

  List<Product> get items => _items;
}
