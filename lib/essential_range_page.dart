import 'package:flutter/material.dart';
import 'package:union_shop/widgets/site_header.dart';
import 'package:union_shop/widgets/site_footer.dart';

class EssentialRangePage extends StatefulWidget {
  const EssentialRangePage({super.key});

  @override
  State<EssentialRangePage> createState() => _EssentialRangePageState();
}

class _EssentialRangePageState extends State<EssentialRangePage> {
  String _selectedFilter = 'All Products';
  String _selectedSort = 'Featured';

  final List<String> _filterOptions = [
    'All Products',
    'Clothing',
  ];

  final List<String> _sortOptions = [
    'Featured',
    'Best Selling',
    'Alphabetically, A-Z',
    'Alphabetically, Z-A',
    'Price, Low to High',
    'Price, High to Low',
    'Date, Old to New',
    'Date, New to Old',
  ];

  // Product data
  final List<Map<String, dynamic>> _products = [
    {
      'title': 'Limited Edition Essential Zip Hoodie',
      'originalPrice': 20.00,
      'salePrice': 14.99,
      'dateAdded': 1,
      'imageUrl':
          'https://shop.upsu.net/cdn/shop/files/Pink_Essential_Hoodie_2a3589c2-096f-479f-ac60-d41e8a853d04_720x.jpg?v=1749131089',
    },
    {
      'title': 'Essential T-Shirt',
      'originalPrice': 10.00,
      'salePrice': 6.99,
      'dateAdded': 2,
      'imageUrl':
          'https://shop.upsu.net/cdn/shop/files/Sage_T-shirt_720x.png?v=1759827236',
    },
  ];

  List<Map<String, dynamic>> _getSortedProducts() {
    var products = List<Map<String, dynamic>>.from(_products);

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
        products.sort(
            (a, b) => (a['salePrice'] as num).compareTo(b['salePrice'] as num));
        break;
      case 'Price, High to Low':
        products.sort(
            (a, b) => (b['salePrice'] as num).compareTo(a['salePrice'] as num));
        break;
      case 'Date, Old to New':
        products.sort(
            (a, b) => (a['dateAdded'] as int).compareTo(b['dateAdded'] as int));
        break;
      case 'Date, New to Old':
        products.sort(
            (a, b) => (b['dateAdded'] as int).compareTo(a['dateAdded'] as int));
        break;
      case 'Featured':
      case 'Best Selling':
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
                  // Title and Description
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          'Signature & Essential Range',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 800),
                          child: Text(
                            '''Discover effortless style and comfort with our latest drop - the Signature & Essential range. The Signature line features premium embroidered hoodies in limited colours, plus the new Signature T-Shirt, combining classic design with elevated details. The Essential line offers versatile, must-have t-shirts with a fresh chest logo design, adding a clean, modern touch to your daily rotation.
                              \nPlus, grab the limited edition zip hoodie while stocks last - a standout piece designed for those who move differently.''',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.6,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

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
                      final sortedProducts = _getSortedProducts();
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
                            '£${(product['originalPrice'] as num).toStringAsFixed(2)}',
                            '£${(product['salePrice'] as num).toStringAsFixed(2)}',
                            product['imageUrl'],
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

  Widget _buildProductCard(
      String title, String originalPrice, String salePrice, String imageUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/product',
          arguments: {
            'title': title,
            'price': salePrice,
            'imageUrl': imageUrl,
            'isClothing': true,
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
                originalPrice,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.grey[600],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                salePrice,
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
