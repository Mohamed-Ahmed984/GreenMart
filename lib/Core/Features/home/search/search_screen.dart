import 'package:flutter/material.dart';
import '../data/product_model.dart';
import '../../../../shopping/product_card.dart';
import '../../../../shopping/shopping_store.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.store, this.title = 'Explore',
    this.products = allProducts});
  final ShoppingStore store;
  final String title;
  final List<ProductModel> products;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _search = TextEditingController();
  ProductCategory? _category;
  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(widget.title)),
    body: Column(children: [
      Padding(padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: TextField(key: const Key('product-search'), controller: _search,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(hintText: 'Search for products', prefixIcon: const Icon(Icons.search),
            suffixIcon: _search.text.isEmpty ? null : IconButton(tooltip: 'Clear search',
              onPressed: () => setState(_search.clear), icon: const Icon(Icons.close))))),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Wrap(spacing: 8, runSpacing: 8, children: [
          ChoiceChip(label: const Text('All'), selected: _category == null,
            onSelected: (_) => setState(() => _category = null)),
          ChoiceChip(label: const Text('Fruit'), selected: _category == ProductCategory.fruit,
            onSelected: (_) => setState(() => _category = ProductCategory.fruit)),
          ChoiceChip(label: const Text('Vegetables'), selected: _category == ProductCategory.vegetables,
            onSelected: (_) => setState(() => _category = ProductCategory.vegetables)),
        ])),
      Expanded(child: ProductGrid(products: getProductsByName(_search.text,
        category: _category, products: widget.products), store: widget.store)),
    ]),
  );
}
