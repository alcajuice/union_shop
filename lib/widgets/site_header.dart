import 'package:flutter/material.dart';

/// Reusable site header used on all pages.
///
/// - Shows the logo on the left.
/// - Shows `Home` and `About` buttons next to the logo.
/// - The active item can be underlined by passing `active` = 'home'|'about'.
class SiteHeader extends StatelessWidget {
  final String? active; // 'home' | 'about' | null

  const SiteHeader({super.key, this.active});

  @override
  Widget build(BuildContext context) {
    void navigateToHome() {
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    }

    void navigateToAbout() {
      Navigator.pushNamed(context, '/about');
    }

    final buttonStyle = TextButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.grey,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      textStyle: const TextStyle(fontSize: 14),
    );

    TextStyle underlineIf(String key) {
      if (active == key) {
        return const TextStyle(decoration: TextDecoration.underline);
      }
      return const TextStyle();
    }

    // Central text buttons (kept here so future additions can be reused)
    final List<Map<String, String>> centerButtons = [
      {'key': 'home', 'label': 'Home'},
      {'key': 'about', 'label': 'About'},
    ];

    final isNarrow = MediaQuery.of(context).size.width < 600;
    final double headerHeight = isNarrow ? 120.0 : 100.0;

    return Container(
      height: headerHeight,
      color: Colors.white,
      child: Column(
        children: [
          // Top banner remains part of the header for now; keep existing colour
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: isNarrow ? 10 : 8),
            color: const Color(0xFF4d2963),
            child: const Text(
              'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          // Main header row with logo, home/about buttons and icon buttons
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: isNarrow ? 14 : 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: navigateToHome,
                    child: Image.network(
                      'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                      height: isNarrow ? 20 : 16,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          width: isNarrow ? 20 : 16,
                          height: isNarrow ? 20 : 16,
                          child: const Center(
                            child: Icon(Icons.image_not_supported,
                                color: Colors.grey),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(width: isNarrow ? 6 : 12),

                  // Center the Home/About buttons between logo and icons
                  // On narrow screens we hide textual buttons so only icons remain
                  Expanded(
                    child: Center(
                      child: isNarrow
                          ? const SizedBox.shrink()
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                for (var b in centerButtons) ...[
                                  TextButton(
                                    onPressed: () {
                                      if (b['key'] == 'home') navigateToHome();
                                      if (b['key'] == 'about')
                                        navigateToAbout();
                                    },
                                    style: buttonStyle,
                                    child: Text(
                                      b['label']!.toUpperCase(),
                                      style: underlineIf(b['key']!).merge(
                                          const TextStyle(color: Colors.grey)),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ],
                            ),
                    ),
                  ),

                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.search,
                            size: isNarrow ? 20 : 18,
                            color: Colors.grey,
                          ),
                          padding: EdgeInsets.all(isNarrow ? 6 : 8),
                          constraints: BoxConstraints(
                            minWidth: isNarrow ? 32 : 32,
                            minHeight: isNarrow ? 32 : 32,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.person_outline,
                            size: isNarrow ? 20 : 18,
                            color: Colors.grey,
                          ),
                          padding: EdgeInsets.all(isNarrow ? 6 : 8),
                          constraints: BoxConstraints(
                            minWidth: isNarrow ? 32 : 32,
                            minHeight: isNarrow ? 32 : 32,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.shopping_bag_outlined,
                            size: isNarrow ? 20 : 18,
                            color: Colors.grey,
                          ),
                          padding: EdgeInsets.all(isNarrow ? 6 : 8),
                          constraints: BoxConstraints(
                            minWidth: isNarrow ? 32 : 32,
                            minHeight: isNarrow ? 32 : 32,
                          ),
                          onPressed: () {},
                        ),
                        // Dropdown menu: only shown on narrow screens. When the
                        // center text buttons are visible (wide screens) the
                        // menu button is hidden.
                        isNarrow
                            ? PopupMenuButton<String>(
                                icon: Icon(
                                  Icons.menu,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                                onSelected: (value) {
                                  if (value == 'home') navigateToHome();
                                  if (value == 'about') navigateToAbout();
                                },
                                itemBuilder: (context) {
                                  return centerButtons.map((b) {
                                    return PopupMenuItem<String>(
                                      value: b['key'],
                                      child: Text(b['label']!),
                                    );
                                  }).toList();
                                },
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
