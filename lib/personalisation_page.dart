import 'package:flutter/material.dart';
import 'package:union_shop/widgets/site_header.dart';
import 'package:union_shop/widgets/site_footer.dart';
import 'package:union_shop/services/cart_service.dart';

class PersonalisationPage extends StatefulWidget {
  const PersonalisationPage({super.key});

  @override
  State<PersonalisationPage> createState() => _PersonalisationPageState();
}

class _PersonalisationPageState extends State<PersonalisationPage> {
  String _selectedOption = 'One Line of Text';
  final Map<String, TextEditingController> _lineControllers = {
    'line1': TextEditingController(),
    'line2': TextEditingController(),
    'line3': TextEditingController(),
    'line4': TextEditingController(),
  };
  int _quantity = 1;

  final List<String> _options = [
    'One Line of Text',
    'Two Lines of Text',
    'Three Lines of Text',
    'Four Lines of Text',
    'Logo (Front)',
    'Logo (Back)',
  ];

  @override
  void dispose() {
    _lineControllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  int _getNumberOfLines() {
    switch (_selectedOption) {
      case 'One Line of Text':
        return 1;
      case 'Two Lines of Text':
        return 2;
      case 'Three Lines of Text':
        return 3;
      case 'Four Lines of Text':
        return 4;
      default:
        return 0;
    }
  }

  String _calculatePrice() {
    int numberOfLines = _getNumberOfLines();
    if (numberOfLines == 0) {
      return '£3.00';
    }
    int totalPrice = numberOfLines * 3;
    return '£$totalPrice.00';
  }

  void _addToCart() {
    // Build the personalisation details
    String personalisationDetails = _selectedOption;
    if (_getNumberOfLines() > 0) {
      List<String> lines = [];
      for (int i = 1; i <= _getNumberOfLines(); i++) {
        String lineText = _lineControllers['line$i']!.text;
        if (lineText.isNotEmpty) {
          lines.add('Line $i: $lineText');
        }
      }
      if (lines.isNotEmpty) {
        personalisationDetails += ' - ' + lines.join(', ');
      }
    }

    CartService().addToCart(
      title: 'Personalisation',
      price: _calculatePrice(),
      imageUrl:
          'https://shop.upsu.net/cdn/shop/products/Personalised_Image_1024x1024@2x.jpg?v=1562949869',
      quantity: _quantity,
      size: personalisationDetails,
    );

    // Show confirmation snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Personalisation has been added to your cart.'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'View Cart',
          textColor: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          },
        ),
        backgroundColor: const Color(0xFF4d2963),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SiteHeader(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: isNarrow ? _buildMobileLayout() : _buildDesktopLayout(),
            ),
            const SiteFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product image
        Container(
          width: double.infinity,
          height: 400,
          decoration: BoxDecoration(
            color: Colors.grey[200],
          ),
          child: Image.network(
            'https://shop.upsu.net/cdn/shop/products/Personalised_Image_1024x1024@2x.jpg?v=1562949869',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Icon(Icons.image_not_supported,
                    color: Colors.grey, size: 50),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
        _buildProductDetails(),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product image
        Expanded(
          flex: 1,
          child: Container(
            height: 600,
            decoration: BoxDecoration(
              color: Colors.grey[200],
            ),
            child: Image.network(
              'https://shop.upsu.net/cdn/shop/products/Personalised_Image_1024x1024@2x.jpg?v=1562949869',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(Icons.image_not_supported,
                      color: Colors.grey, size: 50),
                );
              },
            ),
          ),
        ),
        const SizedBox(width: 48),
        // Product details
        Expanded(
          flex: 1,
          child: _buildProductDetails(),
        ),
      ],
    );
  }

  Widget _buildProductDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Personalisation',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          _calculatePrice(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          '(£3.00 per line)',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Tax included.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 32),

        // Per Line dropdown
        const Text(
          'Per Line: One Line of Text',
          style: TextStyle(
            fontSize: 14,
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
              value: _selectedOption,
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedOption = newValue;
                  });
                }
              },
              items: _options.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 32),

        // Personalisation text inputs
        if (_getNumberOfLines() > 0) ...[
          for (int i = 1; i <= _getNumberOfLines(); i++) ...[
            Text(
              'Personalisation Line $i:',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _lineControllers['line$i'],
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ],

        // Quantity
        const Text(
          'Quantity',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 120,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove, size: 18),
                onPressed: () {
                  if (_quantity > 1) {
                    setState(() {
                      _quantity--;
                    });
                  }
                },
              ),
              Expanded(
                child: Text(
                  _quantity.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, size: 18),
                onPressed: () {
                  setState(() {
                    _quantity++;
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Add to cart button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _addToCart,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4d2963),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: const Text(
              'ADD TO CART',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
