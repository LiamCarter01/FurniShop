import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:furnishop/core/theme/app_theme.dart';
import 'package:furnishop/features/living_rooms/data/datasources/living_room_datasource.dart';
import 'package:furnishop/features/living_rooms/data/models/living_room_model.dart';
import 'package:furnishop/features/living_rooms/presentation/pages/living_rooms_page.dart';
import 'package:furnishop/features/living_rooms/presentation/providers/providers.dart';
import 'package:mocktail/mocktail.dart';

class MockLivingRoomDataSource extends Mock implements LivingRoomDataSource {}

void main() {
  late MockLivingRoomDataSource mockDataSource;

  final testRooms = [
    const LivingRoomModel(
      id: 'livingroom-001',
      name: 'Contemporary Sofa',
      description: 'A stylish, comfortable sofa.',
      price: 799.99,
      originalPrice: 999.99,
      imageUrl: 'https://example.com/sofa.jpg',
      rating: 4.7,
      reviewCount: 142,
      inStock: true,
      category: 'sofa',
      material: 'fabric',
      color: 'gray',
      dimensions: LivingRoomDimensionsModel(
        width: 200,
        height: 90,
        depth: 100,
        weight: 60,
      ),
      isFeatured: true,
      tags: ['sofa', 'living room'],
    ),
    const LivingRoomModel(
      id: 'livingroom-002',
      name: 'Modern Coffee Table',
      description: 'Sleek modern coffee table.',
      price: 249.99,
      imageUrl: 'https://example.com/table.jpg',
      rating: 4.5,
      reviewCount: 80,
      inStock: true,
      category: 'coffee_table',
      material: 'glass',
      color: 'black',
      dimensions: LivingRoomDimensionsModel(
        width: 120,
        height: 45,
        depth: 60,
        weight: 20,
      ),
      isFeatured: false,
      tags: ['coffee table', 'modern'],
    ),
  ];

  setUp(() {
    mockDataSource = MockLivingRoomDataSource();
  });

  Widget createTestWidget() {
    return ProviderScope(
      overrides: [
        livingRoomDataSourceProvider.overrideWithValue(mockDataSource),
      ],
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        home: const LivingRoomsPage(),
      ),
    );
  }

  testWidgets('should show loading indicator initially', (tester) async {
    when(() => mockDataSource.getLivingRooms()).thenAnswer(
      (_) => Future.delayed(
        const Duration(seconds: 2),
        () => testRooms,
      ),
    );

    await tester.pumpWidget(createTestWidget());
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show living rooms after loading', (tester) async {
    when(() => mockDataSource.getLivingRooms()).thenAnswer((_) async => testRooms);

    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    expect(find.text('Contemporary Sofa'), findsOneWidget);
    expect(find.text('Modern Coffee Table'), findsOneWidget);
  });

  testWidgets('should show category filter chips', (tester) async {
    when(() => mockDataSource.getLivingRooms()).thenAnswer((_) async => testRooms);

    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    expect(find.text('All'), findsOneWidget);
    expect(find.text('Coffee_table'), findsOneWidget);
    expect(find.text('Sofa'), findsOneWidget);
  });
}
