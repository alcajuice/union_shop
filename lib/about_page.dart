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

            // Simple placeholder content
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(height: 24),
                  Text(
                    'About (placeholder)',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Text('This page is a placeholder for the About content.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
