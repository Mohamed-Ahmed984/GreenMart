import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_13/main.dart';
import 'package:flutter_application_13/Core/Features/intro/splash_screen.dart';

Future<void> tapVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  WidgetController.hitTestWarningShouldBeFatal = true;
  testWidgets('small-screen onboarding, validation, demo sign-in and exit', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(320, 568);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MainApp());
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    await tapVisible(tester, find.text('Get started'));
    await tapVisible(tester, find.byKey(const Key('demo-login')));
    expect(find.text('Enter a valid email address'), findsOneWidget);
    expect(find.text('Use at least 6 characters'), findsOneWidget);
    await tester.enterText(
      find.byKey(const Key('login-email')),
      'demo@example.com',
    );
    await tester.enterText(
      find.byKey(const Key('login-password')),
      'sample123',
    );
    await tapVisible(tester, find.byTooltip('Show password'));
    expect(find.byTooltip('Hide password'), findsOneWidget);
    await tapVisible(tester, find.byKey(const Key('demo-login')));
    await tapVisible(tester, find.text('Account'));
    expect(find.text('demo@example.com'), findsOneWidget);
    await tapVisible(tester, find.text('Leave demo'));
    expect(find.text('Welcome to GreenMart'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('disposing splash cancels delayed navigation', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SplashScreen()));
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 2));
    expect(tester.takeException(), isNull);
  });
}
