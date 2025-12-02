# Union Shop - Flutter E-Commerce Website

A fully functional e-commerce website built with Flutter for the University of Portsmouth Students' Union shop. This web application provides a complete shopping experience with product browsing, filtering, sorting, cart management, and personalisation features.

## Features

### 🏠 Homepage
- **Hero Carousel**: Auto-scrolling image carousel with 4 slides showcasing promotions
  - Essential Range promotion with navigation to collection page
  - Print Shack information (coming soon)
  - Domino's Pizza ordering - external link to dominos.co.uk
  - Student Accommodation - external link to studentaccommodation.com
- **Product Showcases**: Featured collections displayed directly on homepage
  - Essential Range section (20% off promotion)
  - Signature Range section
  - Portsmouth City Collection section

### 📦 Product Collections
Multiple collection pages with comprehensive filtering and sorting:

1. **Clothing Collection**
   - Variety of apparel items
   - Size and color selection options

2. **Merchandise Collection**
   - General merchandise and accessories
   - Product variety with multiple categories

3. **Essential Range**
   - Sale items with strikethrough pricing
   - Limited Edition Essential Zip Hoodie
   - Essential T-Shirts
   - Signature Hoodies and T-Shirts

4. **Portsmouth City Collection**
   - Portsmouth-themed postcards and merchandise
   - Local pride items

5. **Pride Collection**
   - LGBTQ+ pride merchandise
   - Pride Flag Pin with sale pricing

6. **Graduation Collection**
   - Graduation-specific apparel
   - Graduation Hoodies, Sweatshirts, and accessories
   - Crested Tie with discount pricing

7. **Halloween Collection**
   - Seasonal Halloween tote bag
   - Multiple design options

8. **Sale Collection**
   - All discounted items in one place
   - Clear original and sale pricing display
   - "Don't miss out!" promotional messaging

### 🔍 Filtering & Sorting
All collection pages include:

**Filter Options:**
- All Products
- Clothing
- Merchandise
- Graduation
- PSUT
- Portsmouth City Collection
- Julia Gash
- University Merch

**Sort Options:**
- Alphabetically (A-Z / Z-A)
- Price (Low to High / High to Low)
- Date (Old to New / New to Old)
- Featured
- Best Selling

### 🛒 Shopping Cart
**Full cart management system:**
- Add items to cart with quantities
- **Visual cart badge** - Purple circle with white number showing item count (displays "9+" for 10+ items)
- Real-time cart updates
- **Quantity adjustment** - Increase/decrease quantities directly in cart with +/- buttons
- Remove items from cart
- Automatic subtotal calculation
- Tax calculation (20% VAT)
- Shipping cost (£4.50)
- Total price calculation
- Order notes functionality
- Checkout button
- Cart persists across navigation

### 👕 Product Pages
**Dynamic product pages with:**
- High-quality product images
- Product title and pricing
- Sale pricing with strikethrough for discounted items
- Tax information
- **Color selection** (for clothing items)
- **Size selection** (for clothing items)
- **Design selection** (for non-clothing items like Halloween tote bags)
- Quantity selector
- "Add to Cart" button
- Responsive layout for desktop and mobile

### 🎨 Personalisation Service
**The Print Shack - Custom Personalisation:**
- Personalisation product page (£3.00)
- **Dynamic options:**
  - One Line of Text
  - Two Lines of Text
  - Three Lines of Text
  - Four Lines of Text
  - Logo (Front)
  - Logo (Back)
- **Dynamic text input fields** - Appears based on selected option (1-4 text lines)
- Quantity selection
- Add to cart with personalisation details stored
- **Snackbar confirmation** - Non-intrusive confirmation with "View Cart" action
- About page explaining the personalisation service

### 🔗 External Links
- **Domino's Pizza ordering** - Opens dominos.co.uk in new tab
- **Student Accommodation search** - Opens studentaccommodation.com in new tab
- Links integrated into hero carousel buttons

### 🎯 Navigation
**Header with dropdown menus:**
- Home
- **Shop dropdown** with 7 categories:
  - Clothing
  - Merchandise
  - Halloween
  - Signature & Essential Range
  - Portsmouth City Collection
  - Pride Collection
  - Graduation
- **The Print Shack dropdown**:
  - About
  - Personalisation
- **SALE!** button - Direct access to all sale items
- About page
- Search functionality (with search bar and icon)
- User account icon (placeholder)
- **Shopping cart icon with badge** - Shows item count
- Mobile-responsive hamburger menu

### 🎨 Design Features
- **Purple brand theme** (#4d2963) throughout
- Promotional banner at top of every page
- Consistent site header and footer across all pages
- **Sale pricing display** - Original price crossed out in grey, sale price in red
- Responsive grid layouts (3 columns desktop, 2 columns tablet, 1 column mobile)
- Product cards with hover effects
- Clean, modern UI with Material Design components

### 📱 Responsive Design
- Mobile-friendly layouts
- Adaptive navigation (hamburger menu on small screens)
- Responsive product grids
- Touch-friendly buttons and controls
- Optimized for various screen sizes

### 🔔 User Feedback
- **Visual cart badge** - Real-time item count display
- **Snackbar notifications** - Subtle confirmation when adding items to cart
- Loading states for images
- Error handling for missing images
- Interactive buttons with visual feedback

## Technical Stack

- **Framework**: Flutter (Dart)
- **State Management**: ChangeNotifier (for cart service)
- **Architecture**: Singleton pattern for cart management
- **Navigation**: Named routes
- **Responsive Design**: MediaQuery breakpoints
- **Platform**: Web (Chrome)

## Project Structure

```
lib/
├── main.dart                           # App entry point and routing
├── about_page.dart                     # About page
├── cart_page.dart                      # Shopping cart
├── clothing_page.dart                  # Clothing collection
├── essential_range_page.dart           # Essential & Signature range
├── graduation_collection_page.dart     # Graduation collection
├── halloween_product_page.dart         # Halloween tote bag
├── merchandise_page.dart               # Merchandise collection
├── personalisation_page.dart           # Personalisation product
├── portsmouth_city_collection_page.dart # Portsmouth collection
├── pride_collection_page.dart          # Pride collection
├── print_shack_about_page.dart         # Print Shack about
├── product_page.dart                   # Dynamic product display
├── sale_page.dart                      # Sale collection
├── search_page.dart                    # Search functionality
├── services/
│   └── cart_service.dart              # Cart state management
└── widgets/
    ├── hero_carousel.dart             # Homepage carousel
    ├── site_footer.dart               # Footer component
    └── site_header.dart               # Header with navigation
```

## Key Functionality Highlights

### Cart Service (Singleton)
- Centralized cart management
- Add/remove items
- Update quantities
- Calculate totals
- Persistent across navigation
- Notifies listeners of changes

### Dynamic Product System
- Conditional rendering based on product type
- Clothing vs. merchandise handling
- Sale price vs. regular price display
- Custom options (colors, sizes, designs)

### Filtering & Sorting System
- Real-time product filtering
- Multiple sort algorithms
- Category-based filtering
- Efficient list manipulation

### External Navigation
- `dart:html` for web-based URL opening
- Opens links in new browser tabs
- Seamless external service integration

## Running the Project

```bash
# Get dependencies
flutter pub get

# Run on Chrome
flutter run -d chrome

# Build for web
flutter build web
```

## Future Enhancements

- User authentication
- Order history
- Payment integration
- Product reviews and ratings
- Wishlist functionality
- Advanced search with filters
- Order tracking
- Email notifications

## Author

Built as a university project for the University of Portsmouth Students' Union shop.

## License

This project is for educational purposes.
