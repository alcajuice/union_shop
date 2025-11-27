import 'package:flutter/material.dart';

/// Reusable site footer containing Opening Hours and future columns.
class SiteFooter extends StatelessWidget {
  const SiteFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey[100],
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 48),
      child: Column(
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
      ),
    );
  }
}
