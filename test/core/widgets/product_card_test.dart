import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:furnishop/core/theme/app_theme.dart';
import 'package:furnishop/core/widgets/product_card.dart';

void main() {
  Widget createTestWidget(Widget child) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: Scaffold(
        body: SizedBox(
          width: 200,
          height: 350,
          child: child,
        ),
      ),
    );
  }

  group('ProductCard Widget Tests', () {
    testWidgets('should render product name and price', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          const ProductCard(
            name: 'Test Product',
            price: 99.99,
          ),
        ),
      );

      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('\$99.99'), findsOneWidget);
    });

    testWidgets('should render description when provided', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          const ProductCard(
            name: 'Test Product',
            description: 'This is a test description',
            price: 99.99,
          ),
        ),
      );

      expect(find.text('This is a test description'), findsOneWidget);
    });

    testWidgets('should show original price when provided', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          const ProductCard(
            name: 'Test Product',
            price: 79.99,
            originalPrice: 99.99,
          ),
        ),
      );

      expect(find.text('\$79.99'), findsOneWidget);
      expect(find.text('\$99.99'), findsOneWidget);
    });

    testWidgets('should show discount badge when original price is higher',
        (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          const ProductCard(
            name: 'Test Product',
            price: 80.00,
            originalPrice: 100.00,
          ),
        ),
      );

      // 20% discount
      expect(find.text('-20%'), findsOneWidget);
    });

    testWidgets('should show rating when provided', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          const ProductCard(
            name: 'Test Product',
            price: 99.99,
            rating: 4.5,
            reviewCount: 100,
          ),
        ),
      );

      expect(find.text('4.5'), findsOneWidget);
      expect(find.text('(100)'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('should call onTap when card is tapped', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        createTestWidget(
          ProductCard(
            name: 'Test Product',
            price: 99.99,
            onTap: () => tapped = true,
          ),
        ),
      );

      await tester.tap(find.byType(Card));
      expect(tapped, true);
    });

    testWidgets('should show add to cart button when callback is provided',
        (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          ProductCard(
            name: 'Test Product',
            price: 99.99,
            onAddToCart: () {},
          ),
        ),
      );

      expect(find.text('Add to Cart'), findsOneWidget);
    });

    testWidgets('should show Out of Stock when not in stock', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          ProductCard(
            name: 'Test Product',
            price: 99.99,
            inStock: false,
            onAddToCart: () {},
          ),
        ),
      );

      expect(find.text('Out of Stock'), findsWidgets);
    });

    testWidgets('should call onAddToCart when button is pressed',
        (tester) async {
      var addedToCart = false;

      await tester.pumpWidget(
        createTestWidget(
          ProductCard(
            name: 'Test Product',
            price: 99.99,
            onAddToCart: () => addedToCart = true,
          ),
        ),
      );

      await tester.tap(find.text('Add to Cart'));
      expect(addedToCart, true);
    });

    testWidgets('should show wishlist button when callback is provided',
        (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          ProductCard(
            name: 'Test Product',
            price: 99.99,
            onWishlistToggle: () {},
          ),
        ),
      );

      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    });

    testWidgets('should show filled heart when wishlisted', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          ProductCard(
            name: 'Test Product',
            price: 99.99,
            isWishlisted: true,
            onWishlistToggle: () {},
          ),
        ),
      );

      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });

    testWidgets('should call onWishlistToggle when heart is pressed',
        (tester) async {
      var toggled = false;

      await tester.pumpWidget(
        createTestWidget(
          ProductCard(
            name: 'Test Product',
            price: 99.99,
            onWishlistToggle: () => toggled = true,
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.favorite_border));
      expect(toggled, true);
    });

    testWidgets('should render compact layout when compact is true',
        (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          const ProductCard(
            name: 'Test Product',
            price: 99.99,
            compact: true,
          ),
        ),
      );

      // In compact mode, layout is Row instead of Column
      expect(find.text('Test Product'), findsOneWidget);
    });
  });
}
