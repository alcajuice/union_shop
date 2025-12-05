import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/hero_carousel.dart';

void main() {
  group('Hero Carousel Tests', () {
    Widget createTestWidgetWithRoutes() {
      return MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 1200,
            height: 600,
            child: HeroCarousel(),
          ),
        ),
        routes: {
          '/essential-range': (context) => const Scaffold(
                body: Center(child: Text('Essential Range')),
              ),
          '/print-shack-about': (context) => const Scaffold(
                body: Center(child: Text('Print Shack About')),
              ),
        },
      );
    }

    testWidgets('should display hero carousel with initial slide', (
      tester,
    ) async {
      await tester.pumpWidget(createTestWidgetWithRoutes());
      await tester.pump();

      // Check that the first carousel item is displayed
      expect(find.text('Essential Range - Over 20% OFF!'), findsOneWidget);
      expect(
        find.text(
            'Over 20% off our Essential Range. Come and grab yours while stock lasts!'),
        findsOneWidget,
      );
      expect(find.text('BROWSE COLLECTION'), findsOneWidget);
    });

    testWidgets('should display navigation controls', (tester) async {
      await tester.pumpWidget(createTestWidgetWithRoutes());
      await tester.pump();

      // Check that navigation controls are present
      expect(find.byIcon(Icons.chevron_left), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
      expect(find.byIcon(Icons.pause), findsOneWidget);

      // Check that page indicators (dots) are present (4 carousel items)
      final containerFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).shape == BoxShape.circle &&
            widget.margin == const EdgeInsets.symmetric(horizontal: 4),
      );
      expect(containerFinder, findsNWidgets(4));
    });

    testWidgets('should navigate to next slide when right arrow is tapped', (
      tester,
    ) async {
      await tester.pumpWidget(createTestWidgetWithRoutes());
      await tester.pump();

      // Verify we're on the first slide
      expect(find.text('Essential Range - Over 20% OFF!'), findsOneWidget);

      // Tap the right arrow
      await tester.tap(find.byIcon(Icons.chevron_right));
      await tester.pumpAndSettle();

      // Verify we've moved to the second slide
      expect(find.text('The Print Shack'), findsOneWidget);
      expect(
        find.text(
            'Let\'s create something uniquely you with our personilsation service - From £3 for one line of text!'),
        findsOneWidget,
      );
      expect(find.text('FIND OUT MORE'), findsOneWidget);
    });

    testWidgets('should navigate to previous slide when left arrow is tapped', (
      tester,
    ) async {
      await tester.pumpWidget(createTestWidgetWithRoutes());
      await tester.pump();

      // Verify we're on the first slide
      expect(find.text('Essential Range - Over 20% OFF!'), findsOneWidget);

      // Tap the left arrow (should wrap to last slide)
      await tester.tap(find.byIcon(Icons.chevron_left));
      await tester.pumpAndSettle();

      // Verify we've moved to the last slide
      expect(find.text('What\'s your next move...'), findsOneWidget);
      expect(find.text('Are you with us?'), findsOneWidget);
      expect(find.text('FIND YOUR STUDENT ACCOMMODATION'), findsOneWidget);
    });

    testWidgets('should toggle pause/play when pause button is tapped', (
      tester,
    ) async {
      await tester.pumpWidget(createTestWidgetWithRoutes());
      await tester.pump();

      // Initially should show pause icon (carousel is playing)
      expect(find.byIcon(Icons.pause), findsOneWidget);
      expect(find.byIcon(Icons.play_arrow), findsNothing);

      // Tap the pause button
      await tester.tap(find.byIcon(Icons.pause));
      await tester.pump();

      // Should now show play icon (carousel is paused)
      expect(find.byIcon(Icons.play_arrow), findsOneWidget);
      expect(find.byIcon(Icons.pause), findsNothing);

      // Tap the play button
      await tester.tap(find.byIcon(Icons.play_arrow));
      await tester.pump();

      // Should now show pause icon again (carousel is playing)
      expect(find.byIcon(Icons.pause), findsOneWidget);
      expect(find.byIcon(Icons.play_arrow), findsNothing);
    });

    testWidgets('should navigate through all slides using right arrow', (
      tester,
    ) async {
      await tester.pumpWidget(createTestWidgetWithRoutes());
      await tester.pump();

      // First slide
      expect(find.text('Essential Range - Over 20% OFF!'), findsOneWidget);

      // Navigate to second slide
      await tester.tap(find.byIcon(Icons.chevron_right));
      await tester.pumpAndSettle();
      expect(find.text('The Print Shack'), findsOneWidget);

      // Navigate to third slide
      await tester.tap(find.byIcon(Icons.chevron_right));
      await tester.pumpAndSettle();
      expect(find.text('Hungry?'), findsOneWidget);
      expect(find.text('We got this'), findsOneWidget);

      // Navigate to fourth slide
      await tester.tap(find.byIcon(Icons.chevron_right));
      await tester.pumpAndSettle();
      expect(find.text('What\'s your next move...'), findsOneWidget);

      // Navigate back to first slide (wrapping)
      await tester.tap(find.byIcon(Icons.chevron_right));
      await tester.pumpAndSettle();
      expect(find.text('Essential Range - Over 20% OFF!'), findsOneWidget);
    });

    testWidgets('should navigate to previous slide when left arrow is tapped', (
      tester,
    ) async {
      await tester.pumpWidget(createTestWidgetWithRoutes());
      await tester.pump();

      // Start on first slide
      expect(find.text('Essential Range - Over 20% OFF!'), findsOneWidget);

      // Find all indicator dots
      final dotFinder = find.byWidgetPredicate(
        (widget) =>
            widget is GestureDetector &&
            widget.child is Container &&
            (widget.child as Container).margin ==
                const EdgeInsets.symmetric(horizontal: 4),
      );
      expect(dotFinder, findsNWidgets(4));

      // Tap the third indicator dot (index 2)
      await tester.tap(dotFinder.at(2));
      await tester.pumpAndSettle();

      // Verify we're on the third slide
      expect(find.text('Hungry?'), findsOneWidget);
      expect(find.text('We got this'), findsOneWidget);
      expect(find.text('ORDER DOMINO\'S PIZZA NOW'), findsOneWidget);
    });

    testWidgets('should respond when BROWSE COLLECTION button is pressed', (
      tester,
    ) async {
      await tester.pumpWidget(createTestWidgetWithRoutes());
      await tester.pump();

      // Find and tap the BROWSE COLLECTION button - should trigger navigation
      final button = find.text('BROWSE COLLECTION');
      expect(button, findsOneWidget);
      await tester.tap(button);
      await tester.pump();

      // Test passes if no errors thrown during tap
    });

    testWidgets('should respond when FIND OUT MORE button is pressed', (
      tester,
    ) async {
      await tester.pumpWidget(createTestWidgetWithRoutes());
      await tester.pump();

      // Navigate to second slide (Print Shack)
      await tester.tap(find.byIcon(Icons.chevron_right));
      await tester.pumpAndSettle();

      // Verify we're on the Print Shack slide
      expect(find.text('The Print Shack'), findsOneWidget);

      // Tap the FIND OUT MORE button - should trigger navigation
      final button = find.text('FIND OUT MORE');
      expect(button, findsOneWidget);
      await tester.tap(button);
      await tester.pump();

      // Test passes if no errors thrown during tap
    });

    testWidgets('should display all carousel buttons with correct text', (
      tester,
    ) async {
      await tester.pumpWidget(createTestWidgetWithRoutes());
      await tester.pump();

      // First slide button
      expect(find.text('BROWSE COLLECTION'), findsOneWidget);

      // Navigate to second slide
      await tester.tap(find.byIcon(Icons.chevron_right));
      await tester.pumpAndSettle();
      expect(find.text('FIND OUT MORE'), findsOneWidget);

      // Navigate to third slide
      await tester.tap(find.byIcon(Icons.chevron_right));
      await tester.pumpAndSettle();
      expect(find.text('ORDER DOMINO\'S PIZZA NOW'), findsOneWidget);

      // Navigate to fourth slide
      await tester.tap(find.byIcon(Icons.chevron_right));
      await tester.pumpAndSettle();
      expect(find.text('FIND YOUR STUDENT ACCOMMODATION'), findsOneWidget);
    });

    testWidgets('should maintain carousel state when paused and navigating', (
      tester,
    ) async {
      await tester.pumpWidget(createTestWidgetWithRoutes());
      await tester.pump();

      // Pause the carousel
      await tester.tap(find.byIcon(Icons.pause));
      await tester.pump();
      expect(find.byIcon(Icons.play_arrow), findsOneWidget);

      // Navigate to next slide
      await tester.tap(find.byIcon(Icons.chevron_right));
      await tester.pumpAndSettle();
      expect(find.text('The Print Shack'), findsOneWidget);

      // Should still be paused
      expect(find.byIcon(Icons.play_arrow), findsOneWidget);

      // Navigate back
      await tester.tap(find.byIcon(Icons.chevron_left));
      await tester.pumpAndSettle();
      expect(find.text('Essential Range - Over 20% OFF!'), findsOneWidget);

      // Should still be paused
      expect(find.byIcon(Icons.play_arrow), findsOneWidget);
    });
  });
}
