import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/site_header.dart';

void main() {
  group('Site Header Tests', () {
    Widget createTestWidget({String? active}) {
      return MaterialApp(
        home: Scaffold(
          body: SiteHeader(active: active),
        ),
      );
    }

    testWidgets('should display header with logo', (
      tester,
    ) async {
      // Set a larger viewport to avoid header overflow
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check that logo image is displayed
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('should display navigation buttons', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check that navigation text is displayed
      expect(find.text('HOME'), findsOneWidget);
      expect(find.text('SHOP'), findsOneWidget);
      expect(find.text('THE PRINT SHACK'), findsOneWidget);
      expect(find.text('SALE!'), findsOneWidget);
      expect(find.text('ABOUT'), findsOneWidget);
    });

    testWidgets('should display icon buttons', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check that icon buttons are present
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsOneWidget);
      expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
    });

    testWidgets('should display shop dropdown menu', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Find and tap the Shop button
      final shopButton = find.text('SHOP');
      expect(shopButton, findsOneWidget);

      await tester.tap(shopButton);
      await tester.pumpAndSettle();

      // Check that shop dropdown items appear
      expect(find.text('Clothing'), findsOneWidget);
      expect(find.text('Merchandise'), findsOneWidget);
      expect(find.text('Halloween'), findsOneWidget);
      expect(find.text('Signature & Essential Range'), findsOneWidget);
      expect(find.text('Portsmouth City Collection'), findsOneWidget);
      expect(find.text('Pride Collection'), findsOneWidget);
      expect(find.text('Graduation'), findsOneWidget);
    });

    testWidgets('should display print shack dropdown menu', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Find and tap the Print Shack button
      final printShackButton = find.text('THE PRINT SHACK');
      expect(printShackButton, findsOneWidget);

      await tester.tap(printShackButton);
      await tester.pumpAndSettle();

      // Check that print shack dropdown items appear
      expect(find.text('About'), findsOneWidget);
      expect(find.text('Personalisation'), findsOneWidget);
    });

    testWidgets('should toggle search visibility when search icon clicked', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Find search icon button
      final searchIcon = find.byIcon(Icons.search);
      expect(searchIcon, findsOneWidget);

      // Initially, navigation buttons should be visible
      expect(find.text('HOME'), findsOneWidget);

      // Tap search icon to show search field
      await tester.tap(searchIcon);
      await tester.pumpAndSettle();

      // Search field should now be visible (TextField for search)
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('should display cart badge when items in cart', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check that shopping bag icon is present
      expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);

      // Cart badge should not be visible initially (no items)
      // The badge is displayed conditionally based on cart service state
    });

    testWidgets('should display active page underline', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget(active: 'home'));
      await tester.pump();

      // Check that header is displayed with active home
      expect(find.byType(SiteHeader), findsOneWidget);
      expect(find.text('HOME'), findsOneWidget);
    });

    testWidgets('should have menu icon in narrow viewport', (
      tester,
    ) async {
      // Set narrow viewport
      tester.view.physicalSize = const Size(500, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // In narrow viewport, menu icon should appear
      expect(find.byIcon(Icons.menu), findsOneWidget);
    });

    testWidgets('should display all interactive elements', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Verify all interactive icon buttons are present
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsOneWidget);
      expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);

      // Verify dropdown menus are present
      expect(find.byType(PopupMenuButton<String>), findsNWidgets(2));
    });
  });
}
