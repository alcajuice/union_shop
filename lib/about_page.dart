import 'package:flutter/material.dart';
import 'package:union_shop/widgets/site_header.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Use the shared header and mark 'about' active so it underlines
            const SiteHeader(active: 'about'),

            // Simple placeholder content at the top center under the header
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),

                  // Top-centered bold About heading
                  const Text(
                    'About us',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  const Text(
                    '''Welcome to the Union Shop!

We’re dedicated to giving you the very best University branded products, with a
range of clothing and merchandise available to shop all year round! We even offer
an exclusive personalisation service!

All online purchases are available for delivery or instore collection!

We hope you enjoy our products as much as we enjoy offering them to you. If you
have any questions or comments, please don’t hesitate to contact us at hello@upsu.net.

Happy shopping!

The Union Shop & Reception Team​​​​​​​​​''',
                  ),
                ],
              ),
            ),
            // Opening Hours section (footer-like content)
            Container(
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
                  Text('(Term Time)',
                      style: TextStyle(fontStyle: FontStyle.italic)),
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
            ),
          ],
        ),
      ),
    );
  }
}
