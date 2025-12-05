import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';

void main() {
  group('Home Page Tests', () {
    Widget createTestWidget() {
      return const UnionShopApp();
    }

    testWidgets('should display hero carousel on home page', (
      tester,
    ) async {
      // Set a larger viewport to avoid header overflow in tests
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check that the hero carousel is displayed with first slide
      expect(
        find.text('Essential Range - Over 20% OFF!'),
        findsOneWidget,
      );
      expect(
        find.text('BROWSE COLLECTION'),
        findsOneWidget,
      );
    });

    testWidgets('should display Essential Range section', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check that Essential Range section heading is present
      expect(
        find.text('ESSENTIAL RANGE - OVER 20% OFF!'),
        findsOneWidget,
      );

      // Check that Essential Range products are displayed
      expect(
        find.text('Limited Edition Essential Zip Hoodie'),
        findsOneWidget,
      );
      expect(find.text('Essential T-Shirt'), findsOneWidget);

      // Check sale prices are displayed (£14.99 appears for both Essential and Signature T-shirts)
      expect(find.text('£14.99'), findsWidgets);
      expect(find.text('£6.99'), findsOneWidget);

      // Check original prices with strikethrough
      expect(find.text('£20.00'), findsWidgets);
      expect(find.text('£10.00'), findsWidgets);
    });

    testWidgets('should display Signature Range section', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check that Signature Range section heading is present
      expect(find.text('Signature Range'), findsOneWidget);

      // Check that Signature Range products are displayed
      expect(find.text('Signature Hoodie'), findsOneWidget);
      expect(find.text('Signature T-shirt'), findsOneWidget);

      // Check prices are displayed
      expect(find.text('£32.99'), findsOneWidget);
      expect(find.text('£14.99'), findsWidgets);
    });

    testWidgets('should display Portsmouth City Collection section', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check that Portsmouth City Collection heading is present
      expect(find.text('Portsmouth City Collection'), findsOneWidget);

      // Check that Portsmouth postcards are displayed
      expect(find.text('Portsmouth Postcard 1'), findsOneWidget);
      expect(find.text('Portsmouth Postcard 2'), findsOneWidget);
      expect(find.text('Portsmouth Postcard 3'), findsOneWidget);
      expect(find.text('Portsmouth Postcard 4'), findsOneWidget);

      // Check prices are displayed
      expect(find.text('£10.00'), findsWidgets);
      expect(find.text('£15.00'), findsWidgets);
      expect(find.text('£20.00'), findsWidgets);
      expect(find.text('£25.00'), findsWidgets);
    });

    testWidgets('should display site header with icons', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check that header icons are present
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
    });

    testWidgets('should display site footer with opening hours', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Check that footer is present with opening hours information
      expect(find.text('Opening Hours'), findsOneWidget);
      expect(find.text('❄️  Winter Break Closure Dates ❄️'), findsOneWidget);
    });

    testWidgets('should display all product cards with titles and prices', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Verify Essential Range products
      expect(find.text('Limited Edition Essential Zip Hoodie'), findsOneWidget);
      expect(find.text('Essential T-Shirt'), findsOneWidget);

      // Verify Signature Range products
      expect(find.text('Signature Hoodie'), findsOneWidget);
      expect(find.text('Signature T-shirt'), findsOneWidget);

      // Verify Portsmouth City Collection products
      expect(find.text('Portsmouth Postcard 1'), findsOneWidget);
      expect(find.text('Portsmouth Postcard 2'), findsOneWidget);
      expect(find.text('Portsmouth Postcard 3'), findsOneWidget);
      expect(find.text('Portsmouth Postcard 4'), findsOneWidget);

      // Verify all product cards are present
      expect(find.byType(ProductCard), findsNWidgets(8));
    });

    testWidgets('should handle multiple product sections on single page', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Verify all three product sections exist
      expect(find.text('ESSENTIAL RANGE - OVER 20% OFF!'), findsOneWidget);
      expect(find.text('Signature Range'), findsOneWidget);
      expect(find.text('Portsmouth City Collection'), findsOneWidget);

      // Verify total number of product cards (2 + 2 + 4 = 8 products)
      expect(find.byType(ProductCard), findsNWidgets(8));
    });

    testWidgets('should display sale pricing with original price strikethrough',
        (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check that sale items show both original and sale price
      final essentialHoodie = find.text('Limited Edition Essential Zip Hoodie');
      expect(essentialHoodie, findsOneWidget);

      // Both prices should be visible for sale items
      expect(find.text('£20.00'), findsWidgets); // Original price
      expect(find.text('£14.99'),
          findsWidgets); // Sale price (appears multiple times)
    });
  });
}
