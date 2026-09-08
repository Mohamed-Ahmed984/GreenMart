import 'package:flutter/foundation.dart';
import '../Core/Features/home/data/product_model.dart';

class CartLine {
  const CartLine(this.product, this.quantity);
  final ProductModel product;
  final int quantity;
  int get totalCents => product.priceCents * quantity;
}

class DemoOrder {
  DemoOrder({required this.number, required List<CartLine> lines})
      : lines = List.unmodifiable(lines);
  final int number;
  final List<CartLine> lines;
  int get totalCents => lines.fold(0, (sum, line) => sum + line.totalCents);
  String get reference => 'DEMO-${number.toString().padLeft(4, '0')}';
}

class ShoppingStore extends ChangeNotifier {
  static const maxQuantity = 99;
  final Map<String, int> _quantities = {};
  final Set<String> _favorites = {};
  final Map<String, ProductModel> _catalog = {for (final p in allProducts) p.id: p};
  DemoOrder? lastOrder;
  int _orderNumber = 0;

  ProductModel _product(String id) => _catalog[id] ??
      (throw ArgumentError.value(id, 'id', 'Unknown product'));
  int quantity(String id) => _quantities[id] ?? 0;
  bool isFavorite(String id) => _favorites.contains(id);
  List<CartLine> get lines => List.unmodifiable(_quantities.entries
      .map((entry) => CartLine(_product(entry.key), entry.value)));
  List<ProductModel> get favorites => List.unmodifiable(allProducts
      .where((product) => _favorites.contains(product.id)));
  int get itemCount => _quantities.values.fold(0, (sum, value) => sum + value);
  int get totalCents => lines.fold(0, (sum, line) => sum + line.totalCents);

  bool add(String id) {
    _product(id);
    final current = quantity(id);
    if (current >= maxQuantity) return false;
    setQuantity(id, current + 1);
    return true;
  }

  void setQuantity(String id, int value) {
    _product(id);
    if (value < 0 || value > maxQuantity) {
      throw RangeError.range(value, 0, maxQuantity, 'quantity');
    }
    if (value == quantity(id)) return;
    if (value == 0) {
      _quantities.remove(id);
    } else {
      _quantities[id] = value;
    }
    notifyListeners();
  }

  void remove(String id) => setQuantity(id, 0);

  void toggleFavorite(String id) {
    _product(id);
    if (!_favorites.add(id)) _favorites.remove(id);
    notifyListeners();
  }

  DemoOrder placeDemoOrder() {
    if (_quantities.isEmpty) throw StateError('The basket is empty');
    final order = DemoOrder(number: ++_orderNumber, lines: lines);
    lastOrder = order;
    _quantities.clear();
    notifyListeners();
    return order;
  }
}
