import 'package:flutter/material.dart';
import '../home/pages/home_screen.dart';
import '../home/search/search_screen.dart';
import '../home/data/product_model.dart';
import '../intro/welcome_screen.dart';
import '../../../shopping/shopping_store.dart';
import '../../../shopping/product_card.dart';
import '../../../shopping/cart_screen.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key, this.email, this.store});
  final String? email;
  final ShoppingStore? store;
  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _index = 0;
  late final ShoppingStore _store = widget.store ?? ShoppingStore();
  @override
  void dispose() {
    if (widget.store == null) _store.dispose();
    super.dispose();
  }

  Widget _account() => Scaffold(
    appBar: AppBar(title: const Text('Your account')),
    body: ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Icon(Icons.person_outline, size: 72),
        const SizedBox(height: 20),
        Text(widget.email ?? 'Guest shopper', textAlign: TextAlign.center),
        const SizedBox(height: 16),
        const Text(
          'This is a local shopping demo. No real account, payment, or delivery service is connected.',
        ),
        const SizedBox(height: 16),
        const Text(
          'Your basket and favorites stay available while this session is open. Leaving the demo or restarting the app clears them.',
        ),
        if (_store.lastOrder != null) ...[
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Latest demo order'),
                  Text(_store.lastOrder!.reference),
                  Text(money(_store.lastOrder!.totalCents)),
                ],
              ),
            ),
          ),
        ],
        const SizedBox(height: 24),
        OutlinedButton(
          onPressed: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute<void>(builder: (_) => const WelcomeScreen()),
            (_) => false,
          ),
          child: const Text('Leave demo'),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _store,
    builder: (context, _) => Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          HomeScreen(store: _store),
          SearchScreen(store: _store),
          CartScreen(store: _store, onBrowse: () => setState(() => _index = 0)),
          Scaffold(
            appBar: AppBar(title: const Text('Saved favorites')),
            body: ProductGrid(
              products: _store.favorites,
              store: _store,
              emptyMessage:
                  'No favorites yet. Tap a heart on any product to save it.',
            ),
          ),
          _account(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        onTap: (index) => setState(() => _index = index),
        selectedFontSize: 11,
        unselectedFontSize: 11,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.storefront_outlined),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              isLabelVisible: _store.itemCount > 0,
              label: Text('${_store.itemCount}'),
              child: const Icon(Icons.shopping_basket_outlined),
            ),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorites',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Account',
          ),
        ],
      ),
    ),
  );
}
