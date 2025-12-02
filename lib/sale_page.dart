import 'package:flutter/material.dart';
import 'package:union_shop/widgets/site_header.dart';
import 'package:union_shop/widgets/site_footer.dart';

class SalePage extends StatefulWidget {
  const SalePage({super.key});

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  String _selectedFilter = 'All Products';
  String _selectedSort = 'Alphabetically, A-Z';

  final List<String> _filterOptions = [
    'All Products',
    'Clothing',
    'Merchandise',
    'PSUT',
  ];

  final List<String> _sortOptions = [
    'Alphabetically, A-Z',
    'Alphabetically, Z-A',
    'Price, Low to High',
    'Price, High to Low',
    'Date, Old to New',
    'Date, New to Old',
  ];

  // Product data - all products with sale prices
  final List<Map<String, dynamic>> _products = [
    {
      'title': 'Limited Edition Essential Zip Hoodie',
      'price': 14.99,
      'originalPrice': 20.00,
      'dateAdded': 1,
      'imageUrl':
          'https://shop.upsu.net/cdn/shop/files/Pink_Essential_Hoodie_2a3589c2-096f-479f-ac60-d41e8a853d04_720x.jpg?v=1749131089',
      'isClothing': true,
      'category': 'Clothing',
    },
    {
      'title': 'Essential T-Shirt',
      'price': 6.99,
      'originalPrice': 10.00,
      'dateAdded': 2,
      'imageUrl':
          'https://shop.upsu.net/cdn/shop/files/Sage_T-shirt_720x.png?v=1759827236',
      'isClothing': true,
      'category': 'Clothing',
    },
    {
      'title': 'Pride Flag Pin',
      'price': 0.50,
      'originalPrice': 1.00,
      'dateAdded': 3,
      'imageUrl':
          'https://shop.upsu.net/cdn/shop/files/Pin_540x.jpg?v=1749118523',
      'isClothing': false,
      'category': 'Merchandise',
    },
    {
      'title': 'Crested Tie',
      'price': 10.99,
      'originalPrice': 15.00,
      'dateAdded': 4,
      'imageUrl':
          'https://shop.upsu.net/cdn/shop/products/Tie_720x.jpg?v=1657031719',
      'isClothing': false,
      'category': 'Merchandise',
    },
  ];

  List<Map<String, dynamic>> _getFilteredAndSortedProducts() {
    // Filter products
    var products = _selectedFilter == 'All Products'
        ? List<Map<String, dynamic>>.from(_products)
        : _products
            .where((product) => product['category'] == _selectedFilter)
            .toList();

    switch (_selectedSort) {
      case 'Alphabetically, A-Z':
        products.sort(
            (a, b) => (a['title'] as String).compareTo(b['title'] as String));
        break;
      case 'Alphabetically, Z-A':
        products.sort(
            (a, b) => (b['title'] as String).compareTo(a['title'] as String));
        break;
      case 'Price, Low to High':
        products
            .sort((a, b) => (a['price'] as num).compareTo(b['price'] as num));
        break;
      case 'Price, High to Low':
        products
            .sort((a, b) => (b['price'] as num).compareTo(a['price'] as num));
        break;
      case 'Date, Old to New':
        products.sort(
            (a, b) => (a['dateAdded'] as int).compareTo(b['dateAdded'] as int));
        break;
      case 'Date, New to Old':
        products.sort(
            (a, b) => (b['dateAdded'] as int).compareTo(a['dateAdded'] as int));
        break;
      default:
        break;
    }

    return products;
  }

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SiteHeader(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  const Center(
                    child: Text(
                      'Sale',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Subtext
                  Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: const Text(
                        'Don\'t miss out! Get yours before they\'re all gone!\nAll prices shown are inclusive of the discount',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Filter and Sort controls
                  isNarrow
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFilterDropdown(),
                            const SizedBox(height: 16),
                            _buildSortDropdown(),
                          ],
                        )
                      : Row(
                          children: [
                            SizedBox(
                              width: 350,
                              child: _buildFilterDropdown(),
                            ),
                            const SizedBox(width: 24),
                            SizedBox(
                              width: 350,
                              child: _buildSortDropdown(),
                            ),
                          ],
                        ),

                  const SizedBox(height: 40),

                  // Products Grid
                  Builder(
                    builder: (context) {
                      final sortedProducts = _getFilteredAndSortedProducts();
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isNarrow ? 2 : 3,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 24,
                          childAspectRatio: 0.85,
                        ),
                        itemCount: sortedProducts.length,
                        itemBuilder: (context, index) {
                          final product = sortedProducts[index];
                          return _buildProductCard(
                            product['title'],
                            (product['price'] as num).toStringAsFixed(2),
                            product['imageUrl'],
                            (product['originalPrice'] as num)
                                .toStringAsFixed(2),
                            product['isClothing'] as bool,
                          );
                        },
                      );
                    },
                  ),
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

  Widget _buildFilterDropdown() {
    return Row(
      children: [
        const Text(
          'FILTER BY',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedFilter,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedFilter = newValue;
                    });
                  }
                },
                items: _filterOptions
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSortDropdown() {
    return Row(
      children: [
        const Text(
          'SORT BY',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedSort,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedSort = newValue;
                    });
                  }
                },
                items:
                    _sortOptions.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(String title, String price, String imageUrl,
      String originalPrice, bool isClothing) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/product',
          arguments: {
            'title': title,
            'price': '£$price',
            'originalPrice': '£$originalPrice',
            'imageUrl': imageUrl,
            'isClothing': isClothing,
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.image_not_supported,
                          color: Colors.grey, size: 40),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                '£$originalPrice',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '£$price',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
