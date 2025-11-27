import 'package:flutter/material.dart';

/// Reusable site footer containing Opening Hours and additional columns.
class SiteFooter extends StatelessWidget {
  const SiteFooter({super.key});

  @override
  Widget build(BuildContext context) {
    // Button style similar to header text buttons
    final buttonStyle = TextButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.grey[800],
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      textStyle: const TextStyle(fontSize: 14),
    );

    Widget openingHoursColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Opening Hours',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Text('❄️  Winter Break Closure Dates ❄️',
            style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 8),
        Text('Closing 4pm 19/12/2025',
            style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 4),
        Text('Reopening 10am 05/01/2026',
            style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 8),
        Text('Last post date: 12pm on 18/12/2025',
            style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 12),
        Text('------------------------------'),
        SizedBox(height: 12),
        Text('(Term Time)', style: TextStyle(fontStyle: FontStyle.italic)),
        SizedBox(height: 8),
        Text('Monday - Friday 10am - 4pm',
            style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 12),
        Text('(Outside of Term Time / Consolidation Weeks)',
            style: TextStyle(fontStyle: FontStyle.italic)),
        SizedBox(height: 8),
        Text('Monday - Friday 10am - 3pm',
            style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 12),
        Text('Purchase online 24/7',
            style: TextStyle(fontWeight: FontWeight.w600)),
      ],
    );

    Widget helpColumn(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Help and Information',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          // Search button - navigates to /search
          TextButton(
            style: buttonStyle,
            onPressed: () => Navigator.pushNamed(context, '/search'),
            child: const Align(
                alignment: Alignment.centerLeft, child: Text('search')),
          ),
          const SizedBox(height: 8),
          // Terms & Conditions button - no output as requested
          TextButton(
            style: buttonStyle,
            onPressed: () {},
            child: const Align(
                alignment: Alignment.centerLeft,
                child: Text('Terms & Conditions of Sale Policy')),
          ),
        ],
      );
    }

    Widget latestOffersPlaceholder = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Latest Offers',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        // Placeholder area
        SizedBox(height: 48),
      ],
    );

    return Container(
      width: double.infinity,
      color: Colors.grey[100],
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 48),
      child: LayoutBuilder(builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 700;
        if (isNarrow) {
          // Stack columns vertically on narrow screens
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              openingHoursColumn,
              const SizedBox(height: 24),
              helpColumn(context),
              const SizedBox(height: 24),
              latestOffersPlaceholder,
            ],
          );
        }

        // Three columns side-by-side on wider screens
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left: Opening Hours
            Expanded(flex: 3, child: openingHoursColumn),
            const SizedBox(width: 48),
            // Middle: Help & Information
            Expanded(flex: 2, child: helpColumn(context)),
            const SizedBox(width: 48),
            // Right: Latest Offers placeholder
            Expanded(flex: 4, child: latestOffersPlaceholder),
          ],
        );
      }),
    );
  }
}
