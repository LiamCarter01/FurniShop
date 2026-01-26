import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:furnishop/core/errors/failures.dart';
import 'package:furnishop/features/chairs/domain/entities/chair_entity.dart';
import 'package:furnishop/features/chairs/domain/repositories/chair_repository.dart';
import 'package:furnishop/features/chairs/domain/usecases/chair_usecases.dart';
import 'package:mocktail/mocktail.dart';

// Mock repository
class MockChairRepository extends Mock implements ChairRepository {}

void main() {
  late MockChairRepository mockRepository;
  late GetChairsUseCase getChairsUseCase;
  late GetChairByIdUseCase getChairByIdUseCase;
  late GetFeaturedChairsUseCase getFeaturedChairsUseCase;
  late SearchChairsUseCase searchChairsUseCase;

  // Test data
  const testChair = Chair(
    id: 'test-001',
    name: 'Test Chair',
    description: 'A test chair',
    price: 199.99,
    originalPrice: 249.99,
    imageUrl: 'https://example.com/chair.jpg',
    rating: 4.5,
    reviewCount: 100,
    inStock: true,
    category: 'office',
    material: 'mesh',
    color: 'black',
    dimensions: ChairDimensions(
      width: 60,
      height: 120,
      depth: 55,
      weight: 15,
    ),
    isFeatured: true,
    tags: ['ergonomic', 'office'],
  );

  final testChairsList = [testChair];

  setUp(() {
    mockRepository = MockChairRepository();
    getChairsUseCase = GetChairsUseCase(mockRepository);
    getChairByIdUseCase = GetChairByIdUseCase(mockRepository);
    getFeaturedChairsUseCase = GetFeaturedChairsUseCase(mockRepository);
    searchChairsUseCase = SearchChairsUseCase(mockRepository);
  });

  group('GetChairsUseCase', () {
    test('should return list of chairs from repository on success', () async {
      // Arrange
      when(() => mockRepository.getChairs())
          .thenAnswer((_) async => Right(testChairsList));

      // Act
      final result = await getChairsUseCase();

      // Assert
      expect(result, Right(testChairsList));
      verify(() => mockRepository.getChairs()).called(1);
    });

    test('should return failure from repository on error', () async {
      // Arrange
      const failure = ServerFailure(message: 'Server error');
      when(() => mockRepository.getChairs())
          .thenAnswer((_) async => const Left(failure));

      // Act
      final result = await getChairsUseCase();

      // Assert
      expect(result, const Left(failure));
      verify(() => mockRepository.getChairs()).called(1);
    });
  });

  group('GetChairByIdUseCase', () {
    test('should return chair from repository on success', () async {
      // Arrange
      when(() => mockRepository.getChairById('test-001'))
          .thenAnswer((_) async => const Right(testChair));

      // Act
      final result = await getChairByIdUseCase('test-001');

      // Assert
      expect(result, const Right(testChair));
      verify(() => mockRepository.getChairById('test-001')).called(1);
    });

    test('should return not found failure when chair does not exist', () async {
      // Arrange
      const failure = NotFoundFailure(message: 'Chair not found');
      when(() => mockRepository.getChairById('invalid-id'))
          .thenAnswer((_) async => const Left(failure));

      // Act
      final result = await getChairByIdUseCase('invalid-id');

      // Assert
      expect(result, const Left(failure));
      verify(() => mockRepository.getChairById('invalid-id')).called(1);
    });
  });

  group('GetFeaturedChairsUseCase', () {
    test('should return featured chairs from repository', () async {
      // Arrange
      when(() => mockRepository.getFeaturedChairs())
          .thenAnswer((_) async => Right(testChairsList));

      // Act
      final result = await getFeaturedChairsUseCase();

      // Assert
      expect(result, Right(testChairsList));
      verify(() => mockRepository.getFeaturedChairs()).called(1);
    });

    test('should return empty list when no featured chairs', () async {
      // Arrange
      when(() => mockRepository.getFeaturedChairs())
          .thenAnswer((_) async => const Right([]));

      // Act
      final result = await getFeaturedChairsUseCase();

      // Assert
      expect(result, const Right(<Chair>[]));
      verify(() => mockRepository.getFeaturedChairs()).called(1);
    });
  });

  group('SearchChairsUseCase', () {
    test('should return matching chairs from repository', () async {
      // Arrange
      when(() => mockRepository.searchChairs('ergonomic'))
          .thenAnswer((_) async => Right(testChairsList));

      // Act
      final result = await searchChairsUseCase('ergonomic');

      // Assert
      expect(result, Right(testChairsList));
      verify(() => mockRepository.searchChairs('ergonomic')).called(1);
    });

    test('should return empty list when no matches found', () async {
      // Arrange
      when(() => mockRepository.searchChairs('nonexistent'))
          .thenAnswer((_) async => const Right([]));

      // Act
      final result = await searchChairsUseCase('nonexistent');

      // Assert
      expect(result, const Right(<Chair>[]));
      verify(() => mockRepository.searchChairs('nonexistent')).called(1);
    });
  });

  group('Chair Entity', () {
    test('hasDiscount should return true when originalPrice > price', () {
      expect(testChair.hasDiscount, true);
    });

    test('hasDiscount should return false when originalPrice is null', () {
      const chairWithoutDiscount = Chair(
        id: 'test-002',
        name: 'Test Chair 2',
        description: 'A test chair without discount',
        price: 199.99,
        imageUrl: 'https://example.com/chair.jpg',
        rating: 4.0,
        reviewCount: 50,
        inStock: true,
        category: 'office',
        material: 'mesh',
        color: 'black',
        dimensions: ChairDimensions(
          width: 60,
          height: 120,
          depth: 55,
          weight: 15,
        ),
      );

      expect(chairWithoutDiscount.hasDiscount, false);
    });

    test('discountPercentage should calculate correctly', () {
      // Original: 249.99, Price: 199.99
      // Discount: (249.99 - 199.99) / 249.99 * 100 = 20%
      expect(testChair.discountPercentage, 20);
    });

    test('discountPercentage should return 0 when no discount', () {
      const chairWithoutDiscount = Chair(
        id: 'test-002',
        name: 'Test Chair 2',
        description: 'A test chair without discount',
        price: 199.99,
        imageUrl: 'https://example.com/chair.jpg',
        rating: 4.0,
        reviewCount: 50,
        inStock: true,
        category: 'office',
        material: 'mesh',
        color: 'black',
        dimensions: ChairDimensions(
          width: 60,
          height: 120,
          depth: 55,
          weight: 15,
        ),
      );

      expect(chairWithoutDiscount.discountPercentage, 0);
    });
  });

  group('ChairDimensions', () {
    test('formatted should return correct string', () {
      const dimensions = ChairDimensions(
        width: 60,
        height: 120,
        depth: 55,
        weight: 15,
      );

      expect(dimensions.formatted, '60.0W x 120.0H x 55.0D cm, 15.0kg');
    });
  });
}
