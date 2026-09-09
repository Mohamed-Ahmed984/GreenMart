import 'package:flutter/material.dart';
import '../Core/Features/home/data/product_model.dart';
import 'product_card.dart';
import 'shopping_store.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, required this.store, required this.onBrowse});
  final ShoppingStore store;
  final VoidCallback onBrowse;

  Future<void> _review(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Review demo order'),
        content: Text(
          '${store.itemCount} items · ${money(store.totalCents)}\n\nThis is a demo. No payment will be taken and no delivery will be arranged.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Keep shopping'),
          ),
          FilledButton(
            key: const Key('confirm-order'),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Place demo order'),
          ),
        ],
      ),
    );
    if (!context.mounted || confirmed != true || store.itemCount == 0) return;
    final order = store.placeDemoOrder();
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Demo order created'),
        content: Text(
          '${order.reference}\n${money(order.totalCents)}\n\nYour basket is now empty. No payment or real order was sent.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: store,
    builder: (context, _) => Scaffold(
      appBar: AppBar(title: const Text('My basket')),
      body: store.lines.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.shopping_basket_outlined, size: 72),
                    const SizedBox(height: 20),
                    const Text(
                      'Your basket is empty',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: onBrowse,
                      child: const Text('Browse products'),
                    ),
                  ],
                ),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: store.lines.length,
                    separatorBuilder: (_, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final line = store.lines[index];
                      final product = line.product;
                      return Card(
                        key: Key('cart-${product.id}'),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 64,
                                    height: 64,
                                    child: ProductImage(product: product),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          '${product.quantity} · ${money(product.priceCents)} each',
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    key: Key('remove-${product.id}'),
                                    tooltip: 'Remove ${product.name}',
                                    onPressed: () => store.remove(product.id),
                                    icon: const Icon(Icons.close),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  IconButton.outlined(
                                    key: Key('decrease-${product.id}'),
                                    tooltip: 'Decrease ${product.name}',
                                    onPressed: () {
                                      final current = store.quantity(product.id);
                                      if (current > 0) {
                                        store.setQuantity(product.id, current - 1);
                                      }
                                    },
                                    icon: const Icon(Icons.remove),
                                  ),
                                  Text(
                                    '${line.quantity}',
                                    key: Key('quantity-${product.id}'),
                                  ),
                                  IconButton.outlined(
                                    key: Key('increase-${product.id}'),
                                    tooltip: 'Increase ${product.name}',
                                    onPressed:
                                        line.quantity >=
                                            ShoppingStore.maxQuantity
                                        ? null
                                        : () => store.add(product.id),
                                    icon: const Icon(Icons.add),
                                  ),
                                  Text(
                                    money(line.totalCents),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Basket total',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                            Text(
                              money(store.totalCents),
                              key: const Key('cart-total'),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Demo prices in USD. No payment or delivery.',
                          style: TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 12),
                        FilledButton(
                          key: const Key('review-order'),
                          onPressed: () => _review(context),
                          child: const Text('Review demo order'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    ),
  );
}
