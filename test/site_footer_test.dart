import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/site_footer.dart';

void main() {
  group('Site Footer Tests', () {
    Widget createTestWidget() {
      return const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: SiteFooter(),
          ),
        ),
      );
    }

    testWidgets('should display opening hours section', (
      tester,
    ) async {
      // Set a larger viewport to avoid layout issues
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check opening hours heading
      expect(find.text('Opening Hours'), findsOneWidget);

      // Check winter break dates
      expect(
        find.text('❄️  Winter Break Closure Dates ❄️'),
        findsOneWidget,
      );
      expect(find.text('Closing 4pm 19/12/2025'), findsOneWidget);
      expect(find.text('Reopening 10am 05/01/2026'), findsOneWidget);
    });

    testWidgets('should display term time hours', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check term time information
      expect(find.text('(Term Time)'), findsOneWidget);
      expect(find.text('Monday - Friday 10am - 4pm'), findsOneWidget);

      // Check outside term time information
      expect(
        find.text('(Outside of Term Time / Consolidation Weeks)'),
        findsOneWidget,
      );
      expect(find.text('Monday - Friday 10am - 3pm'), findsOneWidget);

      // Check 24/7 online purchase text
      expect(find.text('Purchase online 24/7'), findsOneWidget);
    });

    testWidgets('should display help and information section', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check help section heading
      expect(find.text('Help and Information'), findsOneWidget);

      // Check help buttons
      expect(find.text('Search'), findsOneWidget);
      expect(
        find.text('Terms & Conditions of Sale Policy'),
        findsOneWidget,
      );
    });

    testWidgets('should display latest offers section', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check latest offers heading
      expect(find.text('Latest Offers'), findsOneWidget);
    });

    testWidgets('should display email subscription input', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check email input field
      final emailField = find.byType(TextField);
      expect(emailField, findsOneWidget);

      // Check email placeholder text
      expect(find.text('Email Address'), findsOneWidget);
    });

    testWidgets('should display subscribe button', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check subscribe button
      expect(find.text('Subscribe'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('should clear email input when subscribe button clicked', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Find email text field
      final emailField = find.byType(TextField);
      expect(emailField, findsOneWidget);

      // Enter email address
      await tester.enterText(emailField, 'test@example.com');
      await tester.pump();

      // Verify text was entered
      expect(find.text('test@example.com'), findsOneWidget);

      // Tap subscribe button
      final subscribeButton = find.text('Subscribe');
      await tester.tap(subscribeButton);
      await tester.pumpAndSettle();

      // Email field should be cleared
      expect(find.text('test@example.com'), findsNothing);
    });

    testWidgets('should have search button functionality', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Find search button
      final searchButton = find.text('Search');
      expect(searchButton, findsOneWidget);

      // Verify it's a TextButton
      final textButton = find.ancestor(
        of: searchButton,
        matching: find.byType(TextButton),
      );
      expect(textButton, findsOneWidget);
    });

    testWidgets('should have terms and conditions button', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Find terms button
      final termsButton = find.text('Terms & Conditions of Sale Policy');
      expect(termsButton, findsOneWidget);

      // Verify it's a TextButton
      final textButton = find.ancestor(
        of: termsButton,
        matching: find.byType(TextButton),
      );
      expect(textButton, findsOneWidget);
    });

    testWidgets('should display all three sections', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Verify all three main sections are present
      expect(find.text('Opening Hours'), findsOneWidget);
      expect(find.text('Help and Information'), findsOneWidget);
      expect(find.text('Latest Offers'), findsOneWidget);

      // Verify footer has proper structure
      expect(find.byType(SiteFooter), findsOneWidget);
    });

    testWidgets('should handle narrow viewport layout', (
      tester,
    ) async {
      // Set narrow viewport
      tester.view.physicalSize = const Size(500, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // All sections should still be present in narrow layout
      expect(find.text('Opening Hours'), findsOneWidget);
      expect(find.text('Help and Information'), findsOneWidget);
      expect(find.text('Latest Offers'), findsOneWidget);
    });

    testWidgets('should have all interactive elements', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Verify all interactive elements are present
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(TextButton), findsNWidgets(2));

      // Verify Subscribe button is functional
      expect(find.text('Subscribe'), findsOneWidget);
    });
  });
}
