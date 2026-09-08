// Run: flutter test tool/capture_screenshots_test.dart
// Uses real Flutter widgets, bundled fonts and sample products.
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_13/Core/Features/main/main_app_screen.dart';
import 'package:flutter_application_13/Core/Style/app_theme.dart';
import 'package:flutter_application_13/shopping/shopping_store.dart';
import '../test/navigation_test.dart' show tapVisible;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  WidgetController.hitTestWarningShouldBeFatal = true;
  setUpAll(() async {
    final poppins = FontLoader('Poppins');
    for (final weight in ['Regular', 'Medium', 'SemiBold']) {
      poppins.addFont(rootBundle.load('Assets/Fonts/Poppins-$weight.ttf'));
    }
    await poppins.load();
    await (FontLoader('MaterialIcons')
      ..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'))).load();
    await (FontLoader('packages/cupertino_icons/CupertinoIcons')
      ..addFont(rootBundle.load('packages/cupertino_icons/assets/CupertinoIcons.ttf'))).load();
  });

  testWidgets('capture exactly three GreenMart screens', (tester) async {
    final shadows = debugDisableShadows;
    debugDisableShadows = false;
    try {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(430, 960);
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final store = ShoppingStore();
      addTearDown(store.dispose);
      final boundaryKey = GlobalKey();
      await tester.pumpWidget(RepaintBoundary(key: boundaryKey,
        child: MaterialApp(debugShowCheckedModeBanner: false, theme: AppThemes.light,
          home: MainAppScreen(store: store))));
      await tester.pumpAndSettle();
      Future<void> capture(String name) async {
        FocusManager.instance.primaryFocus?.unfocus();
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        final boundary = boundaryKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
        await tester.runAsync(() async {
          final image = await boundary.toImage(pixelRatio: 2);
          final data = await image.toByteData(format: ui.ImageByteFormat.png);
          final file = File('docs/screenshots/$name.png');
          await file.parent.create(recursive: true);
          await file.writeAsBytes(data!.buffer.asUint8List());
          image.dispose();
        });
      }
      await tapVisible(tester, find.byKey(const Key('favorite-1')));
      await capture('01-home');
      await tapVisible(tester, find.text('Explore'));
      await tapVisible(tester, find.text('Fruit'));
      await capture('02-explore');
      await tapVisible(tester, find.byKey(const Key('add-1')));
      await tapVisible(tester, find.byKey(const Key('add-2')));
      await tapVisible(tester, find.text('Cart'));
      await tapVisible(tester, find.byKey(const Key('increase-1')));
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();
      expect(store.totalCents, 5000);
      await capture('03-cart');
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpAndSettle();
    } finally {
      debugDisableShadows = shadows;
    }
  });
}
