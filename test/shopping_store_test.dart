import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_13/shopping/shopping_store.dart';
import 'package:flutter_application_13/Core/Features/home/data/product_model.dart';

void main() {
  test(
    'catalog has unique IDs and search trims spaces and respects category',
    () {
      expect(
        allProducts.map((p) => p.id).toSet(),
        hasLength(allProducts.length),
      );
      expect(
        getProductsByName('  APPLE  ').map((p) => p.name),
        contains('Apple'),
      );
      expect(
        getProductsByName('apple', category: ProductCategory.vegetables),
        isEmpty,
      );
      expect(getProductsByName('     '), hasLength(allProducts.length));
      expect(getProductsByName('not a product'), isEmpty);
    },
  );
  test('cart uses integer cents, merges duplicates and updates quantities', () {
    final store = ShoppingStore();
    addTearDown(store.dispose);
    store.add('1');
    store.add('1');
    store.add('2');
    expect(store.lines, hasLength(2));
    expect(store.itemCount, 3);
    expect(store.totalCents, 5000);
    store.setQuantity('1', 1);
    expect(store.totalCents, 3500);
    store.remove('2');
    expect(store.totalCents, 1500);
    store.setQuantity('1', 0);
    expect(store.lines, isEmpty);
  });
  test('quantity limits and unknown products cannot corrupt the basket', () {
    final store = ShoppingStore();
    addTearDown(store.dispose);
    store.setQuantity('1', 99);
    expect(store.add('1'), isFalse);
    expect(() => store.setQuantity('1', -1), throwsRangeError);
    expect(() => store.setQuantity('1', 100), throwsRangeError);
    expect(() => store.add('missing'), throwsArgumentError);
    expect(store.quantity('1'), 99);
  });
  test('favorite toggles are shared without modifying the catalog', () {
    final store = ShoppingStore();
    addTearDown(store.dispose);
    store.toggleFavorite('1');
    expect(store.favorites.single.id, '1');
    store.toggleFavorite('1');
    expect(store.favorites, isEmpty);
  });
  test('demo checkout snapshots the order and clears only the basket', () {
    final store = ShoppingStore();
    addTearDown(store.dispose);
    expect(store.placeDemoOrder, throwsStateError);
    store.add('1');
    store.toggleFavorite('1');
    final order = store.placeDemoOrder();
    expect(order.totalCents, 1500);
    expect(order.reference, 'DEMO-0001');
    expect(store.lines, isEmpty);
    expect(store.isFavorite('1'), isTrue);
    store.add('2');
    expect(order.totalCents, 1500);
    expect(store.placeDemoOrder().reference, 'DEMO-0002');
  });
}
