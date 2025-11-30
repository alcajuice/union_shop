import 'package:flutter/material.dart';
import 'package:union_shop/widgets/site_header.dart';
import 'package:union_shop/widgets/site_footer.dart';

class MerchandisePage extends StatefulWidget {
  const MerchandisePage({super.key});

  @override
  State<MerchandisePage> createState() => _MerchandisePageState();
}

class _MerchandisePageState extends State<MerchandisePage> {
  String _selectedFilter = 'All Products';
  String _selectedSort = 'Featured';

  final List<String> _filterOptions = [
    'All Products',
    'Julia Gash',
    'Merchandise',
    'Portsmouth City Collection',
    'PSUT',
    'University Merch',
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
  final List<Map<String, String>> _products = [
    {
      'title': 'Portsmouth Postcard',
      'price': '£2.00',
      'imageUrl':
          'https://shop.upsu.net/cdn/shop/files/PurpleHoodieFinal_720x.jpg?v=1742201957',
    },
    {
      'title': 'Portsmouth Mug',
      'price': '£8.99',
      'imageUrl':
          'https://shop.upsu.net/cdn/shop/products/IMG_0651_1024x1024@2x.jpg?v=1557218799',
    },
    {
      'title': 'Portsmouth Postcard',
      'price': '£2.00',
      'imageUrl':
          'https://shop.upsu.net/cdn/shop/files/PurpleHoodieFinal_720x.jpg?v=1742201957',
    },
    {
      'title': 'Portsmouth Mug',
      'price': '£8.99',
      'imageUrl':
          'https://shop.upsu.net/cdn/shop/products/IMG_0651_1024x1024@2x.jpg?v=1557218799',
    },
    {
      'title': 'Portsmouth Postcard',
      'price': '£2.00',
      'imageUrl':
          'https://shop.upsu.net/cdn/shop/files/PurpleHoodieFinal_720x.jpg?v=1742201957',
    },
    {
      'title': 'Portsmouth Mug',
      'price': '£8.99',
      'imageUrl':
          'https://shop.upsu.net/cdn/shop/products/IMG_0651_1024x1024@2x.jpg?v=1557218799',
    },
  ];

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
                      'Merchandise',
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
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isNarrow ? 2 : 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 24,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      return _buildProductCard(
                        _products[index]['title']!,
                        _products[index]['price']!,
                        _products[index]['imageUrl']!,
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
