import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/widgets/site_header.dart';
import 'package:union_shop/widgets/site_footer.dart';

void main() {
  group('Product Page Tests', () {
    Widget createTestWidget() {
      return const MaterialApp(home: ProductPage());
    }

    testWidgets('should display default product with title and price', (
      tester,
    ) async {
      // Set a larger viewport to avoid header overflow
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check default product details
      expect(find.text('Classic Purple Hoodie'), findsOneWidget);
      expect(find.text('£25.00'), findsOneWidget);
      expect(find.text('Tax included.'), findsOneWidget);
    });

    testWidgets('should display color and size dropdowns for clothing', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check that color and size options are present for clothing items
      expect(find.text('Color:'), findsOneWidget);
      expect(find.text('Size:'), findsOneWidget);

      // Check default selections
      expect(find.text('Red'), findsOneWidget);
      expect(find.text('M'), findsOneWidget);
    });

    testWidgets('should display quantity selector', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check quantity selector is present
      expect(find.text('Quantity:'), findsOneWidget);

      // Check TextFields are present (quantity + footer email)
      expect(find.byType(TextField), findsWidgets);
    });

    testWidgets('should display add to cart button', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check add to cart button is present
      expect(find.text('ADD TO CART'), findsOneWidget);

      // Check ElevatedButtons are present (add to cart + footer subscribe)
      expect(find.byType(ElevatedButton), findsWidgets);
    });

    testWidgets('should display site header', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check that header is present
      expect(find.byType(SiteHeader), findsOneWidget);
    });

    testWidgets('should display site footer with opening hours', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check that footer is present with opening hours
      expect(find.byType(SiteFooter), findsOneWidget);
      expect(find.text('Opening Hours'), findsOneWidget);
    });

    testWidgets('should display product image placeholder', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check that images are present (logo + product image)
      expect(find.byType(Image), findsWidgets);
    });

    testWidgets('should have all interactive elements for purchase flow', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Verify complete purchase flow elements are present
      expect(find.text('Color:'), findsOneWidget);
      expect(find.text('Size:'), findsOneWidget);
      expect(find.text('Quantity:'), findsOneWidget);
      expect(find.text('ADD TO CART'), findsOneWidget);

      // Verify dropdowns are interactive
      expect(find.byType(DropdownButton<String>), findsNWidgets(2));
    });
  });
}
