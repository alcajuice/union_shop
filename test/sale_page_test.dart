import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/sale_page.dart';
import 'package:union_shop/widgets/site_header.dart';
import 'package:union_shop/widgets/site_footer.dart';

void main() {
  group('Sale Page Tests', () {
    Widget createTestWidget() {
      return const MaterialApp(
        home: SalePage(),
      );
    }

    testWidgets('should display sale page title and description', (
      tester,
    ) async {
      // Set a larger viewport to avoid header overflow
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check sale page title
      expect(find.text('Sale'), findsOneWidget);

      // Check description text
      expect(
        find.text(
          'Don\'t miss out! Get yours before they\'re all gone!\nAll prices shown are inclusive of the discount',
        ),
        findsOneWidget,
      );
    });

    testWidgets('should display filter dropdown', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check filter label
      expect(find.text('FILTER BY'), findsOneWidget);

      // Check default filter option
      expect(find.text('All Products'), findsOneWidget);
    });

    testWidgets('should display sort dropdown', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check sort label
      expect(find.text('SORT BY'), findsOneWidget);

      // Check default sort option
      expect(find.text('Alphabetically, A-Z'), findsOneWidget);
    });

    testWidgets('should display sale products', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check that sale products are displayed
      expect(find.text('Limited Edition Essential Zip Hoodie'), findsOneWidget);
      expect(find.text('Essential T-Shirt'), findsOneWidget);
      expect(find.text('Pride Flag Pin'), findsOneWidget);
      expect(find.text('Crested Tie'), findsOneWidget);
    });

    testWidgets('should display sale and original prices', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check that both sale and original prices are displayed
      expect(find.text('£14.99'), findsOneWidget);
      expect(find.text('£20.00'), findsOneWidget);
      expect(find.text('£6.99'), findsOneWidget);
      expect(find.text('£10.00'), findsWidgets);
    });

    testWidgets('should display strikethrough on original prices', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Find Text widgets with strikethrough decoration
      final strikeThroughTexts = find.byWidgetPredicate(
        (widget) =>
            widget is Text &&
            widget.style?.decoration == TextDecoration.lineThrough,
      );

      // Should have 4 strikethrough prices (one per product)
      expect(strikeThroughTexts, findsNWidgets(4));
    });

    testWidgets('should filter products by category', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Initially all 4 products should be visible
      expect(find.text('Limited Edition Essential Zip Hoodie'), findsOneWidget);
      expect(find.text('Pride Flag Pin'), findsOneWidget);

      // Find and tap the filter dropdown
      final filterDropdown = find.text('All Products');
      await tester.tap(filterDropdown);
      await tester.pumpAndSettle();

      // Select "Clothing" filter
      final clothingOption = find.text('Clothing').last;
      await tester.tap(clothingOption);
      await tester.pumpAndSettle();

      // Only clothing items should be visible
      expect(find.text('Limited Edition Essential Zip Hoodie'), findsOneWidget);
      expect(find.text('Essential T-Shirt'), findsOneWidget);

      // Non-clothing items should not be visible
      expect(find.text('Pride Flag Pin'), findsNothing);
      expect(find.text('Crested Tie'), findsNothing);
    });

    testWidgets('should sort products alphabetically Z-A', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Find and tap the sort dropdown
      final sortDropdown = find.text('Alphabetically, A-Z');
      await tester.tap(sortDropdown);
      await tester.pumpAndSettle();

      // Select "Alphabetically, Z-A" option
      final sortOption = find.text('Alphabetically, Z-A').last;
      await tester.tap(sortOption);
      await tester.pumpAndSettle();

      // Verify the sort dropdown shows the selected option
      expect(find.text('Alphabetically, Z-A'), findsOneWidget);
    });

    testWidgets('should have site header and footer', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check that header and footer are present
      expect(find.byType(SiteHeader), findsOneWidget);
      expect(find.byType(SiteFooter), findsOneWidget);
    });

    testWidgets('should display product images', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check that images are displayed (4 products + 1 logo)
      expect(find.byType(Image), findsWidgets);
    });

    testWidgets('should display dropdown buttons', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check that both dropdowns are present
      expect(find.byType(DropdownButton<String>), findsNWidgets(2));
    });

    testWidgets('should display all filter options', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Tap filter dropdown to show options
      final filterDropdown = find.text('All Products');
      await tester.tap(filterDropdown);
      await tester.pumpAndSettle();

      // Check all filter options are present
      expect(find.text('All Products'), findsWidgets);
      expect(find.text('Clothing'), findsOneWidget);
      expect(find.text('Merchandise'), findsOneWidget);
      expect(find.text('PSUT'), findsOneWidget);
    });

    testWidgets('should display all sort options', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Tap sort dropdown to show options
      final sortDropdown = find.text('Alphabetically, A-Z');
      await tester.tap(sortDropdown);
      await tester.pumpAndSettle();

      // Check all sort options are present
      expect(find.text('Alphabetically, A-Z'), findsWidgets);
      expect(find.text('Alphabetically, Z-A'), findsOneWidget);
      expect(find.text('Price, Low to High'), findsOneWidget);
      expect(find.text('Price, High to Low'), findsOneWidget);
      expect(find.text('Date, Old to New'), findsOneWidget);
      expect(find.text('Date, New to Old'), findsOneWidget);
    });

    testWidgets('should display products in grid layout', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check that GridView is present
      expect(find.byType(GridView), findsOneWidget);

      // Check all 4 products are displayed by verifying product titles
      expect(find.text('Limited Edition Essential Zip Hoodie'), findsOneWidget);
      expect(find.text('Essential T-Shirt'), findsOneWidget);
      expect(find.text('Pride Flag Pin'), findsOneWidget);
      expect(find.text('Crested Tie'), findsOneWidget);
    });
  });
}
