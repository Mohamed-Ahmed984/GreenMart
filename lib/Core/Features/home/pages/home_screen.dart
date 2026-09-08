import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../Constant/app_image.dart';
import '../data/product_model.dart';
import '../search/search_screen.dart';
import '../../../../shopping/product_card.dart';
import '../../../../shopping/shopping_store.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.store});
  final ShoppingStore store;

  void _browse(
    BuildContext context, {
    String title = 'Explore',
    List<ProductModel> products = allProducts,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) =>
            SearchScreen(store: store, title: title, products: products),
      ),
    );
  }

  Widget _section(
    BuildContext context,
    String title,
    List<ProductModel> products,
  ) {
    final scale = MediaQuery.textScalerOf(context).scale(16) / 16;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(title, style: Theme.of(context).textTheme.titleLarge),
            ),
            TextButton(
              onPressed: () =>
                  _browse(context, title: title, products: products),
              child: const Text('See all'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 275 + (scale - 1).clamp(0, 3).toDouble() * 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            separatorBuilder: (_, index) => const SizedBox(width: 14),
            itemBuilder: (_, index) => SizedBox(
              width: 180,
              child: ProductCard(product: products[index], store: store),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: SvgPicture.asset(
        AppImage.logo,
        height: 30,
        colorFilter: ColorFilter.mode(
          Theme.of(context).colorScheme.primary,
          BlendMode.srcIn,
        ),
      ),
    ),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Fresh picks, every day',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        const Text('Build a basket of your everyday favorites.'),
        const SizedBox(height: 20),
        OutlinedButton.icon(
          key: const Key('open-search'),
          onPressed: () => _browse(context),
          icon: const Icon(Icons.search),
          label: const Text('Search for products'),
        ),
        const SizedBox(height: 20),
        _section(context, 'Exclusive Offers', offers),
        const SizedBox(height: 24),
        _section(context, 'Best Selling', bestSelling),
        const SizedBox(height: 20),
      ],
    ),
  );
}
