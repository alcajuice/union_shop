import 'package:flutter/material.dart';
import 'package:union_shop/widgets/site_header.dart';
import 'package:union_shop/widgets/site_footer.dart';

class PortsmouthCityCollectionPage extends StatefulWidget {
  const PortsmouthCityCollectionPage({super.key});

  @override
  State<PortsmouthCityCollectionPage> createState() =>
      _PortsmouthCityCollectionPageState();
}

class _PortsmouthCityCollectionPageState
    extends State<PortsmouthCityCollectionPage> {
  String _selectedFilter = 'All Products';
  String _selectedSort = 'Featured';

  final List<String> _filterOptions = [
    'All Products',
    'Julia Gash',
    'Merchandise',
    'Portsmouth City Collection',
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

  // Product data - using the same postcard products from main page
  final List<Map<String, dynamic>> _products = [
    {
      'title': 'Portsmouth Postcard 1',
      'price': 10.00,
      'dateAdded': 1,
      'imageUrl':
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    },
    {
      'title': 'Portsmouth Postcard 2',
      'price': 15.00,
      'dateAdded': 2,
      'imageUrl':
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    },
    {
      'title': 'Portsmouth Postcard 3',
      'price': 20.00,
      'dateAdded': 3,
      'imageUrl':
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    },
    {
      'title': 'Portsmouth Postcard 4',
      'price': 25.00,
      'dateAdded': 4,
      'imageUrl':
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    },
  ];

  List<Map<String, dynamic>> _getSortedProducts() {
    var products = List<Map<String, dynamic>>.from(_products);

    switch (_selectedSort) {
      case 'Alphabetically, A-Z':
        products.sort((a, b) => a['title'].compareTo(b['title']));
        break;
      case 'Alphabetically, Z-A':
        products.sort((a, b) => b['title'].compareTo(a['title']));
        break;
      case 'Price, Low to High':
        products.sort((a, b) => a['price'].compareTo(b['price']));
        break;
      case 'Price, High to Low':
        products.sort((a, b) => b['price'].compareTo(a['price']));
        break;
      case 'Date, Old to New':
        products.sort((a, b) => a['dateAdded'].compareTo(b['dateAdded']));
        break;
      case 'Date, New to Old':
        products.sort((a, b) => b['dateAdded'].compareTo(a['dateAdded']));
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
                          'Portsmouth City Collection',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 900),
                          child: Text(
                            'We\'re excited to launch the Portsmouth City Collection, featuring products by renowned British illustrator Julia Gash, now available in our Students\' Union Shop!\n\nThis unique collection celebrates our vibrant city through Julia\'s iconic hand-drawn style - full of charm, character, and local landmarks that students and visitors alike will instantly recognise. From the Spinnaker Tower to The King\'s Theatre, each design captures the spirit of Portsmouth in bold lines and colourful detail.\n\nAvailable in postcards, magnets, bookmarks and water bottles, these items make perfect mementos, gifts, or affordable keepsakes - whether you\'re a new student, proud local, or just passing through.',
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
                            '£${(product['price'] as num).toStringAsFixed(2)}',
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

  Widget _buildProductCard(String title, String price, String imageUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/product',
          arguments: {
            'title': title,
            'price': price,
            'imageUrl': imageUrl,
            'isClothing': false,
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
          Text(
            price,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
