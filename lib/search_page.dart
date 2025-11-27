import 'package:flutter/material.dart';
import 'package:union_shop/widgets/site_header.dart';
import 'package:union_shop/widgets/site_footer_fixed.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SiteHeader(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: const [
                  SizedBox(height: 24),
                  Text('Search (placeholder)',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  Text('This is a placeholder search page.'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const SiteFooter(),
          ],
        ),
      ),
    );
  }
}
