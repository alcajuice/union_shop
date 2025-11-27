import 'package:flutter/material.dart';

/// Reusable site footer containing Opening Hours, Help, and Latest Offers.
class SiteFooter extends StatefulWidget {
  const SiteFooter({super.key});

  @override
  State<SiteFooter> createState() => _SiteFooterState();
}

class _SiteFooterState extends State<SiteFooter> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          TextButton(
            style: buttonStyle,
            onPressed: () => Navigator.pushNamed(context, '/search'),
            child: const Align(
                alignment: Alignment.centerLeft, child: Text('Search')),
          ),
          const SizedBox(height: 8),
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

    Widget latestOffersSection = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Latest Offers',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        // Input followed by a square submit button on the right
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48.0,
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email Address',
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              height: 48.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                onPressed: () {
                  // Simulate subscribe by clearing the input
                  _emailController.clear();
                  setState(() {});
                },
                child: const Text('Subscribe', style: TextStyle(fontSize: 14)),
              ),
            ),
          ],
        ),
      ],
    );

    return Container(
      width: double.infinity,
      color: Colors.grey[100],
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 48),
      child: LayoutBuilder(builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 700;
        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              openingHoursColumn,
              const SizedBox(height: 24),
              helpColumn(context),
              const SizedBox(height: 24),
              latestOffersSection,
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 3, child: openingHoursColumn),
            const SizedBox(width: 48),
            Expanded(flex: 2, child: helpColumn(context)),
            const SizedBox(width: 48),
            Expanded(flex: 4, child: latestOffersSection),
          ],
        );
      }),
    );
  }
}
