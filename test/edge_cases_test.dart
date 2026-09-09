import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_13/Core/Features/aut/page/login_screen.dart';
import 'package:flutter_application_13/Core/Features/main/main_app_screen.dart';
import 'package:flutter_application_13/Core/Style/app_theme.dart';
import 'package:flutter_application_13/shopping/shopping_store.dart';
import 'navigation_test.dart' show tapVisible;

void main() {
  WidgetController.hitTestWarningShouldBeFatal = true;
  testWidgets(
    'guest entry works without credentials and starts an empty session',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(theme: AppThemes.light, home: const LoginScreen()),
      );
      await tapVisible(tester, find.byKey(const Key('guest-login')));
      await tapVisible(tester, find.text('Cart'));
      expect(find.text('Your basket is empty'), findsOneWidget);
      await tapVisible(tester, find.text('Favorites'));
      expect(find.textContaining('No favorites yet'), findsOneWidget);
      await tapVisible(tester, find.text('Account'));
      expect(find.text('Guest shopper'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'search route shares basket state and last-item removal stays usable',
    (tester) async {
      final store = ShoppingStore();
      addTearDown(store.dispose);
      await tester.pumpWidget(
        MaterialApp(
          theme: AppThemes.light,
          home: MainAppScreen(store: store),
        ),
      );
      await tapVisible(tester, find.byKey(const Key('open-search')));
      await tester.enterText(find.byKey(const Key('product-search')), 'apple');
      await tester.pumpAndSettle();
      await tapVisible(tester, find.byKey(const Key('add-1')));
      await tester.pageBack();
      await tester.pumpAndSettle();
      await tapVisible(tester, find.text('Cart'));
      expect(store.itemCount, 1);
      await tapVisible(tester, find.byKey(const Key('remove-1')));
      expect(find.text('Your basket is empty'), findsOneWidget);
      await tapVisible(tester, find.text('Browse products'));
      expect(find.byKey(const Key('open-search')), findsOneWidget);
      await tester.pumpWidget(const SizedBox.shrink());
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('catalog and basket tolerate larger text on a phone', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(400, 800);
    tester.platformDispatcher.textScaleFactorTestValue = 1.5;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    final store = ShoppingStore()..setQuantity('1', 99);
    addTearDown(store.dispose);
    await tester.pumpWidget(
      MaterialApp(
        theme: AppThemes.light,
        home: MainAppScreen(store: store),
      ),
    );
    await tester.pumpAndSettle();
    await tapVisible(tester, find.text('Explore'));
    await tapVisible(tester, find.text('Cart'));
    final plus = tester.widget<IconButton>(find.byKey(const Key('increase-1')));
    expect(plus.onPressed, isNull);
    await tapVisible(tester, find.byKey(const Key('decrease-1')));
    expect(store.quantity('1'), 98);
    await tester.pumpWidget(const SizedBox.shrink());
    expect(tester.takeException(), isNull);
  });
  testWidgets('rapid basket decrements use the latest quantity', (tester) async {
    final store = ShoppingStore()..setQuantity('1', 2);
    addTearDown(store.dispose);
    await tester.pumpWidget(MaterialApp(theme: AppThemes.light, home: MainAppScreen(store: store)));
    await tapVisible(tester, find.text('Cart'));
    final decrease = find.byKey(const Key('decrease-1'));
    await tester.tap(decrease);
    await tester.tap(decrease);
    await tester.tap(decrease);
    await tester.pumpAndSettle();
    expect(store.quantity('1'), 0);
    expect(find.text('Your basket is empty'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });

}
