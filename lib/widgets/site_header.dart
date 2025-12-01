import 'package:flutter/material.dart';

/// Reusable site header used on all pages.
///
/// - Shows the logo on the left.
/// - Shows `Home` and `About` buttons next to the logo.
/// - The active item can be underlined by passing `active` = 'home'|'about'.
class SiteHeader extends StatefulWidget {
  final String? active; // 'home' | 'about' | null

  const SiteHeader({super.key, this.active});

  @override
  State<SiteHeader> createState() => _SiteHeaderState();
}

class _SiteHeaderState extends State<SiteHeader> {
  bool _searchVisible = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
      if (widget.active == key) {
        return const TextStyle(decoration: TextDecoration.underline);
      }
      return const TextStyle();
    }

    // Shop dropdown menu items
    final List<Map<String, String>> shopMenuItems = [
      {'key': 'clothing', 'label': 'Clothing'},
      {'key': 'merchandise', 'label': 'Merchandise'},
      {'key': 'halloween', 'label': 'Halloween'},
      {'key': 'signature-essential', 'label': 'Signature & Essential Range'},
      {'key': 'portsmouth', 'label': 'Portsmouth City Collection'},
      {'key': 'pride', 'label': 'Pride Collection'},
      {'key': 'graduation', 'label': 'Graduation'},
    ];

    // Central text buttons (kept here so future additions can be reused)
    final List<Map<String, String>> centerButtons = [
      {'key': 'home', 'label': 'Home'},
      {'key': 'shop', 'label': 'Shop'},
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

                  // Center area: show search input when active, otherwise show text buttons
                  Expanded(
                    child: _searchVisible
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: isNarrow ? 0 : 16),
                            child: TextField(
                              controller: _searchController,
                              autofocus: true,
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                border: OutlineInputBorder(),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.close, size: 18),
                                  onPressed: () {
                                    setState(() {
                                      _searchVisible = false;
                                      _searchController.clear();
                                    });
                                  },
                                ),
                              ),
                              onSubmitted: (query) {
                                if (query.isNotEmpty) {
                                  Navigator.pushNamed(
                                    context,
                                    '/search',
                                    arguments: {'query': query},
                                  );
                                }
                              },
                            ),
                          )
                        : Center(
                            child: isNarrow
                                ? const SizedBox.shrink()
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      for (var b in centerButtons) ...[
                                        if (b['key'] == 'shop')
                                          PopupMenuButton<String>(
                                            offset: const Offset(0, 40),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 8),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    b['label']!.toUpperCase(),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 4),
                                                  const Icon(
                                                    Icons.arrow_drop_down,
                                                    size: 18,
                                                    color: Colors.grey,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onSelected: (value) {
                                              // Handle shop submenu navigation
                                              if (value == 'clothing') {
                                                Navigator.pushNamed(
                                                    context, '/clothing');
                                              } else if (value ==
                                                  'merchandise') {
                                                Navigator.pushNamed(
                                                    context, '/merchandise');
                                              } else if (value == 'halloween') {
                                                Navigator.pushNamed(
                                                    context, '/halloween');
                                              } else if (value ==
                                                  'signature-essential') {
                                                Navigator.pushNamed(context,
                                                    '/essential-range');
                                              } else if (value == 'portsmouth') {
                                                Navigator.pushNamed(context,
                                                    '/portsmouth-city-collection');
                                              }
                                              // Add other shop submenu navigation here
                                            },
                                            itemBuilder: (context) {
                                              return shopMenuItems.map((item) {
                                                return PopupMenuItem<String>(
                                                  value: item['key'],
                                                  child: Text(item['label']!),
                                                );
                                              }).toList();
                                            },
                                          )
                                        else
                                          TextButton(
                                            onPressed: () {
                                              if (b['key'] == 'home')
                                                navigateToHome();
                                              if (b['key'] == 'about')
                                                navigateToAbout();
                                            },
                                            style: buttonStyle,
                                            child: Text(
                                              b['label']!.toUpperCase(),
                                              style: underlineIf(b['key']!)
                                                  .merge(const TextStyle(
                                                      color: Colors.grey)),
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
                          onPressed: () {
                            setState(() {
                              _searchVisible = !_searchVisible;
                            });
                          },
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
                          onPressed: () {
                            Navigator.pushNamed(context, '/cart');
                          },
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
                                  // Handle shop submenu items
                                  if (value == 'clothing') {
                                    Navigator.pushNamed(context, '/clothing');
                                  }
                                },
                                itemBuilder: (context) {
                                  final items = <PopupMenuEntry<String>>[];
                                  for (var b in centerButtons) {
                                    if (b['key'] == 'shop') {
                                      // Add Shop as header
                                      items.add(
                                        PopupMenuItem<String>(
                                          enabled: false,
                                          child: Text(
                                            b['label']!,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                      );
                                      // Add shop submenu items indented
                                      for (var item in shopMenuItems) {
                                        items.add(
                                          PopupMenuItem<String>(
                                            value: item['key'],
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16),
                                              child: Text(item['label']!),
                                            ),
                                          ),
                                        );
                                      }
                                    } else {
                                      items.add(
                                        PopupMenuItem<String>(
                                          value: b['key'],
                                          child: Text(b['label']!),
                                        ),
                                      );
                                    }
                                  }
                                  return items;
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
