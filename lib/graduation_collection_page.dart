import 'package:flutter/material.dart';
import 'package:union_shop/widgets/site_header.dart';
import 'package:union_shop/widgets/site_footer.dart';

class GraduationCollectionPage extends StatefulWidget {
  const GraduationCollectionPage({super.key});

  @override
  State<GraduationCollectionPage> createState() =>
      _GraduationCollectionPageState();
}

class _GraduationCollectionPageState extends State<GraduationCollectionPage> {
  String _selectedFilter = 'All Products';
  String _selectedSort = 'Alphabetically, A-Z';

  final List<String> _filterOptions = [
    'All Products',
    'Clothing',
    'Graduation',
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

  // Product data
  final List<Map<String, dynamic>> _products = [
    {
      'title': 'Graduation Hoodies',
      'price': 35.00,
      'originalPrice': null,
      'dateAdded': 1,
      'imageUrl':
          'https://shop.upsu.net/cdn/shop/products/GradGrey_720x.jpg?v=1657288025',
      'category': 'Clothing',
      'isClothing': true,
    },
    {
      'title': 'Graduation 3/4 Zipped Sweatshirt',
      'price': 45.00,
      'originalPrice': null,
      'dateAdded': 2,
      'imageUrl':
          'https://shop.upsu.net/cdn/shop/files/Graduation3_4ZipSweatshirt_720x.jpg?v=1685631207',
      'category': 'Clothing',
      'isClothing': true,
    },
    {
      'title': 'Crested Tie',
      'price': 10.99,
      'originalPrice': 15.00,
      'dateAdded': 3,
      'imageUrl':
          'https://shop.upsu.net/cdn/shop/products/Tie_720x.jpg?v=1657031719',
      'category': 'Graduation',
      'isClothing': false,
    },
  ];

  List<Map<String, dynamic>> _getFilteredAndSortedProducts() {
    // Filter products
    List<Map<String, dynamic>> filtered = _products;
    if (_selectedFilter != 'All Products') {
      filtered = _products
          .where((product) => product['category'] == _selectedFilter)
          .toList();
    }

    // Sort products
    List<Map<String, dynamic>> sorted = List.from(filtered);
    switch (_selectedSort) {
      case 'Alphabetically, A-Z':
        sorted.sort(
            (a, b) => (a['title'] as String).compareTo(b['title'] as String));
        break;
      case 'Alphabetically, Z-A':
        sorted.sort(
            (a, b) => (b['title'] as String).compareTo(a['title'] as String));
        break;
      case 'Price, Low to High':
        sorted.sort((a, b) => (a['price'] as num).compareTo(b['price'] as num));
        break;
      case 'Price, High to Low':
        sorted.sort((a, b) => (b['price'] as num).compareTo(a['price'] as num));
        break;
      case 'Date, Old to New':
        sorted.sort(
            (a, b) => (a['dateAdded'] as int).compareTo(b['dateAdded'] as int));
        break;
      case 'Date, New to Old':
        sorted.sort(
            (a, b) => (b['dateAdded'] as int).compareTo(a['dateAdded'] as int));
        break;
      default:
        break;
    }

    return sorted;
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
                      'Graduation Collection',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
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
                            product['originalPrice'] != null
                                ? (product['originalPrice'] as num)
                                    .toStringAsFixed(2)
                                : null,
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
      String? originalPrice, bool isClothing) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/product',
          arguments: {
            'title': title,
            'price': '£$price',
            'originalPrice': originalPrice != null ? '£$originalPrice' : null,
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
          if (originalPrice != null)
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
            )
          else
            Text(
              '£$price',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
        ],
      ),
    );
  }
}
