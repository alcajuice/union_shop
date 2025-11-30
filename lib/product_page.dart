import 'package:flutter/material.dart';
import 'package:union_shop/widgets/site_header.dart';
import 'package:union_shop/widgets/site_footer.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String _selectedColor = 'Red';
  String _selectedSize = 'M';
  int _quantity = 1;

  final List<String> _colors = [
    'Red',
    'Orange',
    'Yellow',
    'Green',
    'Blue',
    'Indigo',
    'Violet',
  ];

  final List<String> _sizes = [
    'XS',
    'S',
    'M',
    'L',
    'XL',
    'XXL',
  ];

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 900;

    // Extract product data from route arguments
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final productTitle = args?['title'] ?? 'Classic Purple Hoodie';
    final productPrice = args?['price'] ?? '£25.00';
    final productImage = args?['imageUrl'] ??
        'https://shop.upsu.net/cdn/shop/files/PurpleHoodieFinal_720x.jpg?v=1742201957';
    final isClothing = args?['isClothing'] ?? true;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SiteHeader(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: isNarrow
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProductImage(productImage),
                        const SizedBox(height: 32),
                        _buildProductDetails(
                            productTitle, productPrice, isClothing),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: _buildProductImage(productImage),
                        ),
                        const SizedBox(width: 48),
                        Expanded(
                          flex: 1,
                          child: _buildProductDetails(
                              productTitle, productPrice, isClothing),
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

  Widget _buildProductImage(String imageUrl) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 600),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 500,
              color: Colors.grey[300],
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image_not_supported,
                      size: 64,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Image unavailable',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductDetails(String title, String price, bool isClothing) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product title
        Text(
          title,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),

        // Price
        Text(
          price,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),

        // Tax included
        Text(
          'Tax included.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 32),

        // Color dropdown (only for clothing)
        if (isClothing) ...[
          const Text(
            'Color:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedColor,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedColor = newValue;
                    });
                  }
                },
                items: _colors.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],

        // Size dropdown (only for clothing)
        if (isClothing) ...[
          const Text(
            'Size:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedSize,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedSize = newValue;
                    });
                  }
                },
                items: _sizes.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],

        // Quantity
        const Text(
          'Quantity:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 120,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  controller: TextEditingController(text: _quantity.toString()),
                  onChanged: (value) {
                    final parsed = int.tryParse(value);
                    if (parsed != null && parsed > 0) {
                      setState(() {
                        _quantity = parsed;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Add to cart button
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              // Add to cart functionality
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Added $_quantity x $title ($_selectedColor, $_selectedSize) to cart',
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4d2963),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: const Text(
              'ADD TO CART',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
