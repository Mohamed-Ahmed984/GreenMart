import 'package:flutter/material.dart';
import '../Core/Features/home/data/product_model.dart';
import 'shopping_store.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({super.key, required this.product});
  final ProductModel product;

  Widget _fallback(BuildContext context) => Container(
    color: Theme.of(
      context,
    ).colorScheme.primaryContainer.withValues(alpha: 0.35),
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.eco_outlined, size: 32),
        Text(
          product.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) => Semantics(
    label: product.name,
    image: true,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: product.imageAsset != null
          ? Image.asset(
              product.imageAsset!,
              fit: BoxFit.contain,
              errorBuilder: (_, error, stack) => _fallback(context),
            )
          : Image.network(
              product.image,
              fit: BoxFit.contain,
              errorBuilder: (_, error, stack) => _fallback(context),
              loadingBuilder: (context, child, progress) =>
                  progress == null ? child : _fallback(context),
            ),
    ),
  );
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, required this.store});
  final ProductModel product;
  final ShoppingStore store;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: store,
    builder: (context, _) => Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: ProductImage(product: product),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      key: Key('favorite-${product.id}'),
                      tooltip: store.isFavorite(product.id)
                          ? 'Unsave ${product.name}'
                          : 'Save ${product.name}',
                      onPressed: () => store.toggleFavorite(product.id),
                      icon: Icon(
                        store.isFavorite(product.id)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            Text(
              product.quantity,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    money(product.priceCents),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                IconButton.filled(
                  key: Key('add-${product.id}'),
                  tooltip: 'Add ${product.name}',
                  onPressed: () {
                    final added = store.add(product.id);
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 1),
                          content: Text(
                            added
                                ? '${product.name} added to basket'
                                : 'Maximum quantity is 99',
                          ),
                        ),
                      );
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    super.key,
    required this.products,
    required this.store,
    this.emptyMessage = 'No products match your search.',
  });
  final List<ProductModel> products;
  final ShoppingStore store;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(emptyMessage, textAlign: TextAlign.center),
        ),
      );
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        final count = ((constraints.maxWidth - 32) / 180)
            .floor()
            .clamp(1, 4)
            .toInt();
        final scale = MediaQuery.textScalerOf(context).scale(16) / 16;
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: count,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            mainAxisExtent: 290 + (scale - 1).clamp(0, 3).toDouble() * 100,
          ),
          itemBuilder: (_, index) =>
              ProductCard(product: products[index], store: store),
        );
      },
    );
  }
}
