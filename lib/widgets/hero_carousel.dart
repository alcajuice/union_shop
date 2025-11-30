import 'dart:async';
import 'package:flutter/material.dart';

class HeroCarousel extends StatefulWidget {
  const HeroCarousel({super.key});

  @override
  State<HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<HeroCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isPaused = false;
  Timer? _autoScrollTimer;

  final List<Map<String, String>> _carouselItems = [
    {
      'image':
          'https://shop.upsu.net/cdn/shop/files/Signature_T-Shirt_Indigo_Blue_2.jpg?v=1758290534',
      'title': 'Signature Collection',
      'subtitle': 'Discover our premium t-shirt range',
      'buttonText': 'SHOP NOW',
    },
    {
      'image': 'https://shop.upsu.net/cdn/shop/files/Hoodie.jpg?v=1632306034',
      'title': 'Cozy Comfort',
      'subtitle': 'Stay warm with our hoodie collection',
      'buttonText': 'EXPLORE',
    },
    {
      'image':
          'https://shop.upsu.net/cdn/shop/files/Dominos_-_Shopify_Banner.jpg?v=1638793465',
      'title': 'Special Offers',
      'subtitle': 'Check out our latest deals',
      'buttonText': 'VIEW DEALS',
    },
    {
      'image':
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCarousel_1853x473_DesignA_01.jpg?v=1639407310',
      'title': 'Portsmouth Pride',
      'subtitle': 'Show your city spirit',
      'buttonText': 'DISCOVER',
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    if (!_isPaused) {
      _autoScrollTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
        if (!_isPaused && _pageController.hasClients) {
          final nextPage = (_currentPage + 1) % _carouselItems.length;
          _pageController.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
      if (!_isPaused) {
        _startAutoScroll();
      } else {
        _autoScrollTimer?.cancel();
      }
    });
  }

  void _goToPreviousPage() {
    if (_pageController.hasClients) {
      final previousPage =
          (_currentPage - 1 + _carouselItems.length) % _carouselItems.length;
      _pageController.animateToPage(
        previousPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToNextPage() {
    if (_pageController.hasClients) {
      final nextPage = (_currentPage + 1) % _carouselItems.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPage(int page) {
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: double.infinity,
      child: Stack(
        children: [
          // PageView with images
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _carouselItems.length,
            itemBuilder: (context, index) {
              final item = _carouselItems[index];
              return Stack(
                children: [
                  // Background image
                  Positioned.fill(
                    child: Image.network(
                      item['image']!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(Icons.image_not_supported,
                                color: Colors.grey, size: 50),
                          ),
                        );
                      },
                    ),
                  ),
                  // Dark overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.4),
                      ),
                    ),
                  ),
                  // Content overlay
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item['title']!,
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.2,
                              shadows: [
                                Shadow(
                                  color: Colors.black45,
                                  offset: Offset(2, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            item['subtitle']!,
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              height: 1.5,
                              shadows: [
                                Shadow(
                                  color: Colors.black45,
                                  offset: Offset(1, 1),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),
                          ElevatedButton(
                            onPressed: () {
                              // Placeholder action
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4d2963),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 20,
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            child: Text(
                              item['buttonText']!,
                              style: const TextStyle(
                                fontSize: 16,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // Bottom controls bar with navigation arrows, indicators, and pause button
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Left arrow
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.chevron_left,
                        color: Colors.white, size: 24),
                    onPressed: _goToPreviousPage,
                  ),
                ),
                const SizedBox(width: 16),
                // Page indicators (dots)
                ...List.generate(
                  _carouselItems.length,
                  (index) => GestureDetector(
                    onTap: () => _goToPage(index),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.5),
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Right arrow
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.chevron_right,
                        color: Colors.white, size: 24),
                    onPressed: _goToNextPage,
                  ),
                ),
                const SizedBox(width: 16),
                // Pause/Play button
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      _isPaused ? Icons.play_arrow : Icons.pause,
                      color: Colors.white,
                      size: 24,
                    ),
                    onPressed: _togglePause,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
