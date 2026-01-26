import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:furnishop/core/theme/app_theme.dart';
import 'package:furnishop/features/chairs/data/datasources/chair_datasource.dart';
import 'package:furnishop/features/chairs/data/models/chair_model.dart';
import 'package:furnishop/features/chairs/presentation/pages/chairs_page.dart';
import 'package:furnishop/features/chairs/presentation/providers/chairs_providers.dart';
import 'package:mocktail/mocktail.dart';

// Mock data source
class MockChairDataSource extends Mock implements ChairDataSource {}

void main() {
  late MockChairDataSource mockDataSource;

  // Test data
  final testChairs = [
    const ChairModel(
      id: 'chair-001',
      name: 'Ergonomic Office Chair',
      description: 'Premium ergonomic office chair',
      price: 299.99,
      originalPrice: 399.99,
      imageUrl: 'https://example.com/chair1.jpg',
      rating: 4.8,
      reviewCount: 256,
      inStock: true,
      category: 'office',
      material: 'mesh',
      color: 'black',
      dimensions: ChairDimensionsModel(
        width: 65,
        height: 120,
        depth: 60,
        weight: 15,
      ),
      isFeatured: true,
      tags: ['ergonomic', 'office'],
    ),
    const ChairModel(
      id: 'chair-002',
      name: 'Modern Dining Chair',
      description: 'Sleek modern dining chair',
      price: 149.99,
      imageUrl: 'https://example.com/chair2.jpg',
      rating: 4.5,
      reviewCount: 128,
      inStock: true,
      category: 'dining',
      material: 'fabric',
      color: 'gray',
      dimensions: ChairDimensionsModel(
        width: 45,
        height: 85,
        depth: 50,
        weight: 8,
      ),
      isFeatured: false,
      tags: ['dining', 'modern'],
    ),
  ];

  setUp(() {
    mockDataSource = MockChairDataSource();
  });

  Widget createTestWidget() {
    return ProviderScope(
      overrides: [
        chairDataSourceProvider.overrideWithValue(mockDataSource),
      ],
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        home: const ChairsPage(),
      ),
    );
  }

  group('ChairsPage Widget Tests', () {
    testWidgets('should show loading indicator initially', (tester) async {
      // Arrange
      when(() => mockDataSource.getChairs()).thenAnswer(
        (_) => Future.delayed(
          const Duration(seconds: 2),
          () => testChairs,
        ),
      );

      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show chairs after loading', (tester) async {
      // Arrange
      when(() => mockDataSource.getChairs())
          .thenAnswer((_) async => testChairs);

      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Ergonomic Office Chair'), findsOneWidget);
      expect(find.text('Modern Dining Chair'), findsOneWidget);
    });

    testWidgets('should show category filter chips', (tester) async {
      // Arrange
      when(() => mockDataSource.getChairs())
          .thenAnswer((_) async => testChairs);

      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('All'), findsOneWidget);
      expect(find.text('Dining'), findsOneWidget);
      expect(find.text('Office'), findsOneWidget);
    });

    testWidgets('should filter chairs when category is selected',
        (tester) async {
      // Arrange
      when(() => mockDataSource.getChairs())
          .thenAnswer((_) async => testChairs);

      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Tap on Office category
      await tester.tap(find.text('Office'));
      await tester.pumpAndSettle();

      // Assert - should show only office chairs
      expect(find.text('Ergonomic Office Chair'), findsOneWidget);
      expect(find.text('1 results'), findsOneWidget);
    });

    testWidgets('should show all chairs when All is selected', (tester) async {
      // Arrange
      when(() => mockDataSource.getChairs())
          .thenAnswer((_) async => testChairs);

      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // First filter to office
      await tester.tap(find.text('Office'));
      await tester.pumpAndSettle();

      // Then tap All
      await tester.tap(find.text('All'));
      await tester.pumpAndSettle();

      // Assert - should show all chairs
      expect(find.text('2 results'), findsOneWidget);
    });

    testWidgets('should show error widget on failure', (tester) async {
      // Arrange
      when(() => mockDataSource.getChairs())
          .thenThrow(Exception('Network error'));

      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Assert
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('should retry loading when retry button is pressed',
        (tester) async {
      // Arrange - first call fails, second succeeds
      var callCount = 0;
      when(() => mockDataSource.getChairs()).thenAnswer((_) async {
        callCount++;
        if (callCount == 1) {
          throw Exception('Network error');
        }
        return testChairs;
      });

      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Verify error is shown
      expect(find.text('Retry'), findsOneWidget);

      // Tap retry
      await tester.tap(find.text('Retry'));
      await tester.pumpAndSettle();

      // Assert - should now show chairs
      expect(find.text('Ergonomic Office Chair'), findsOneWidget);
    });

    testWidgets('should show app bar with title', (tester) async {
      // Arrange
      when(() => mockDataSource.getChairs())
          .thenAnswer((_) async => testChairs);

      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Chairs'), findsOneWidget);
    });

    testWidgets('should show search and cart icons in app bar',
        (tester) async {
      // Arrange
      when(() => mockDataSource.getChairs())
          .thenAnswer((_) async => testChairs);

      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Assert
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.shopping_cart_outlined), findsOneWidget);
    });

    testWidgets('should show snackbar when add to cart is pressed',
        (tester) async {
      // Arrange
      when(() => mockDataSource.getChairs())
          .thenAnswer((_) async => testChairs);

      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Find and tap add to cart button (first one)
      final addToCartButtons = find.text('Add to Cart');
      await tester.tap(addToCartButtons.first);
      await tester.pump();

      // Assert
      expect(find.text('Ergonomic Office Chair added to cart'), findsOneWidget);
    });
  });
}
