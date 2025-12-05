import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/checkout_page.dart';
import 'package:union_shop/services/cart_service.dart';

void main() {
  group('Checkout Page Tests', () {
    setUp(() {
      // Clear cart before each test
      CartService().clear();
    });

    Widget createTestWidget() {
      return const MaterialApp(
        home: CheckoutPage(),
      );
    }

    testWidgets('should display checkout page title', (tester) async {
      // Set a larger viewport to avoid header overflow
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      // Add an item to cart for testing
      CartService().addToCart(
        title: 'Test Product',
        price: '£10.00',
        imageUrl: 'https://example.com/image.jpg',
        quantity: 1,
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check checkout page title
      expect(find.text('Checkout'), findsOneWidget);
    });

    testWidgets('should display order summary section', (tester) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      CartService().addToCart(
        title: 'Test Product',
        price: '£10.00',
        imageUrl: 'https://example.com/image.jpg',
        quantity: 1,
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check order summary heading
      expect(find.text('Order Summary'), findsOneWidget);
    });

    testWidgets('should display cart items in checkout', (tester) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      CartService().addToCart(
        title: 'Test Product',
        price: '£10.00',
        imageUrl: 'https://example.com/image.jpg',
        quantity: 2,
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check product title is displayed
      expect(find.text('Test Product'), findsOneWidget);

      // Check quantity is displayed
      expect(find.text('Quantity: 2'), findsOneWidget);
    });

    testWidgets('should display subtotal and total', (tester) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      CartService().addToCart(
        title: 'Test Product',
        price: '£10.00',
        imageUrl: 'https://example.com/image.jpg',
        quantity: 2,
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check subtotal is displayed
      expect(find.text('Subtotal'), findsOneWidget);
      expect(find.text('£20.00'), findsWidgets);

      // Check total is displayed
      expect(find.text('Total'), findsOneWidget);
    });

    testWidgets('should display shipping information', (tester) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      CartService().addToCart(
        title: 'Test Product',
        price: '£10.00',
        imageUrl: 'https://example.com/image.jpg',
        quantity: 1,
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check shipping is displayed
      expect(find.text('Shipping'), findsOneWidget);
      expect(find.text('Free'), findsOneWidget);
    });

    testWidgets('should display tax included message', (tester) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      CartService().addToCart(
        title: 'Test Product',
        price: '£10.00',
        imageUrl: 'https://example.com/image.jpg',
        quantity: 1,
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check tax included message
      expect(find.text('Tax included'), findsOneWidget);
    });

    testWidgets('should display place order button', (tester) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      CartService().addToCart(
        title: 'Test Product',
        price: '£10.00',
        imageUrl: 'https://example.com/image.jpg',
        quantity: 1,
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check place order button
      expect(find.text('PLACE ORDER'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsWidgets);
    });

    testWidgets('should have site header with sale banner', (tester) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      CartService().addToCart(
        title: 'Test Product',
        price: '£10.00',
        imageUrl: 'https://example.com/image.jpg',
        quantity: 1,
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check that header sale banner exists
      expect(find.textContaining('BIG SALE!'), findsOneWidget);
    });

    testWidgets('should display product image', (tester) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      CartService().addToCart(
        title: 'Test Product',
        price: '£10.00',
        imageUrl: 'https://example.com/image.jpg',
        quantity: 1,
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check that images are displayed (product + logo)
      expect(find.byType(Image), findsWidgets);
    });

    testWidgets('should display product color and size if available',
        (tester) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      CartService().addToCart(
        title: 'Test Product',
        price: '£10.00',
        imageUrl: 'https://example.com/image.jpg',
        quantity: 1,
        color: 'Red',
        size: 'M',
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check color and size are displayed
      expect(find.text('Color: Red'), findsOneWidget);
      expect(find.text('Size: M'), findsOneWidget);
    });
  });
}
