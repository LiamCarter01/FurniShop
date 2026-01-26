import '../models/chair_model.dart';

/// Data source interface for chair API operations.
///
/// This defines the contract for remote data access.
abstract class ChairDataSource {
  /// Fetch all chairs from API.
  Future<List<ChairModel>> getChairs();

  /// Fetch a single chair by ID.
  Future<ChairModel> getChairById(String id);

  /// Fetch chairs by category.
  Future<List<ChairModel>> getChairsByCategory(String category);

  /// Fetch featured chairs.
  Future<List<ChairModel>> getFeaturedChairs();

  /// Search chairs by query.
  Future<List<ChairModel>> searchChairs(String query);
}

/// Mock implementation of [ChairDataSource] for development.
///
/// Returns mock data instead of making real API calls.
/// Replace with real API implementation in production.
class MockChairDataSource implements ChairDataSource {
  /// Simulated network delay.
  static const Duration _delay = Duration(milliseconds: 800);

  /// Mock chair data.
  final List<ChairModel> _mockChairs = [
    const ChairModel(
      id: 'chair-001',
      name: 'Ergonomic Office Chair',
      description:
          'Premium ergonomic office chair with lumbar support, adjustable armrests, and breathable mesh back. Perfect for long work sessions.',
      price: 299.99,
      originalPrice: 399.99,
      imageUrl: 'https://images.unsplash.com/photo-1580480055273-228ff5388ef8?w=400',
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
      tags: ['ergonomic', 'office', 'adjustable', 'mesh'],
    ),
    const ChairModel(
      id: 'chair-002',
      name: 'Modern Dining Chair',
      description:
          'Sleek modern dining chair with solid oak legs and comfortable cushioned seat. Set of 2 available.',
      price: 149.99,
      imageUrl: 'https://images.unsplash.com/photo-1506439773649-6e0eb8cfb237?w=400',
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
      isFeatured: true,
      tags: ['dining', 'modern', 'fabric'],
    ),
    const ChairModel(
      id: 'chair-003',
      name: 'Executive Leather Chair',
      description:
          'Luxurious executive chair with genuine leather upholstery, high back support, and chrome base. Make a statement in your office.',
      price: 549.99,
      originalPrice: 699.99,
      imageUrl: 'https://images.unsplash.com/photo-1541558869434-2840d308329a?w=400',
      rating: 4.9,
      reviewCount: 89,
      inStock: true,
      category: 'office',
      material: 'leather',
      color: 'brown',
      dimensions: ChairDimensionsModel(
        width: 70,
        height: 130,
        depth: 75,
        weight: 25,
      ),
      isFeatured: true,
      tags: ['executive', 'leather', 'luxury', 'office'],
    ),
    const ChairModel(
      id: 'chair-004',
      name: 'Scandinavian Lounge Chair',
      description:
          'Minimalist Scandinavian design lounge chair with natural wood frame and premium fabric cushions. Perfect for reading corners.',
      price: 399.99,
      imageUrl: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400',
      rating: 4.7,
      reviewCount: 156,
      inStock: true,
      category: 'lounge',
      material: 'fabric',
      color: 'beige',
      dimensions: ChairDimensionsModel(
        width: 75,
        height: 90,
        depth: 80,
        weight: 18,
      ),
      isFeatured: false,
      tags: ['scandinavian', 'lounge', 'minimalist'],
    ),
    const ChairModel(
      id: 'chair-005',
      name: 'Gaming Chair Pro',
      description:
          'Ultimate gaming chair with RGB lighting, 4D armrests, reclining function, and memory foam cushions. Level up your gaming setup.',
      price: 449.99,
      originalPrice: 549.99,
      imageUrl: 'https://images.unsplash.com/photo-1598550476439-6847785fcea6?w=400',
      rating: 4.6,
      reviewCount: 312,
      inStock: true,
      category: 'gaming',
      material: 'leather',
      color: 'black',
      dimensions: ChairDimensionsModel(
        width: 68,
        height: 135,
        depth: 70,
        weight: 28,
      ),
      isFeatured: true,
      tags: ['gaming', 'rgb', 'reclining', 'premium'],
    ),
    const ChairModel(
      id: 'chair-006',
      name: 'Outdoor Patio Chair',
      description:
          'Weather-resistant outdoor chair with aluminum frame and quick-dry cushions. Built to withstand the elements.',
      price: 199.99,
      imageUrl: 'https://images.unsplash.com/photo-1519947486511-46149fa0a254?w=400',
      rating: 4.3,
      reviewCount: 78,
      inStock: false,
      category: 'outdoor',
      material: 'aluminum',
      color: 'white',
      dimensions: ChairDimensionsModel(
        width: 60,
        height: 95,
        depth: 65,
        weight: 12,
      ),
      isFeatured: false,
      tags: ['outdoor', 'patio', 'weather-resistant'],
    ),
    const ChairModel(
      id: 'chair-007',
      name: 'Kids Study Chair',
      description:
          'Adjustable study chair designed for children. Grows with your child with height-adjustable seat and back.',
      price: 89.99,
      imageUrl: 'https://images.unsplash.com/photo-1503602642458-232111445657?w=400',
      rating: 4.4,
      reviewCount: 203,
      inStock: true,
      category: 'kids',
      material: 'plastic',
      color: 'blue',
      dimensions: ChairDimensionsModel(
        width: 40,
        height: 70,
        depth: 40,
        weight: 5,
      ),
      isFeatured: false,
      tags: ['kids', 'study', 'adjustable'],
    ),
    const ChairModel(
      id: 'chair-008',
      name: 'Accent Velvet Chair',
      description:
          'Stunning velvet accent chair with gold-finished legs. Adds a touch of elegance to any living space.',
      price: 329.99,
      originalPrice: 429.99,
      imageUrl: 'https://images.unsplash.com/photo-1506439773649-6e0eb8cfb237?w=400',
      rating: 4.8,
      reviewCount: 145,
      inStock: true,
      category: 'accent',
      material: 'velvet',
      color: 'green',
      dimensions: ChairDimensionsModel(
        width: 70,
        height: 85,
        depth: 65,
        weight: 14,
      ),
      isFeatured: true,
      tags: ['accent', 'velvet', 'elegant', 'living room'],
    ),
  ];

  @override
  Future<List<ChairModel>> getChairs() async {
    await Future.delayed(_delay);
    return _mockChairs;
  }

  @override
  Future<ChairModel> getChairById(String id) async {
    await Future.delayed(_delay);
    return _mockChairs.firstWhere(
      (chair) => chair.id == id,
      orElse: () => throw Exception('Chair not found'),
    );
  }

  @override
  Future<List<ChairModel>> getChairsByCategory(String category) async {
    await Future.delayed(_delay);
    return _mockChairs
        .where(
            (chair) => chair.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  @override
  Future<List<ChairModel>> getFeaturedChairs() async {
    await Future.delayed(_delay);
    return _mockChairs.where((chair) => chair.isFeatured).toList();
  }

  @override
  Future<List<ChairModel>> searchChairs(String query) async {
    await Future.delayed(_delay);
    final lowerQuery = query.toLowerCase();
    return _mockChairs.where((chair) {
      return chair.name.toLowerCase().contains(lowerQuery) ||
          chair.description.toLowerCase().contains(lowerQuery) ||
          chair.category.toLowerCase().contains(lowerQuery) ||
          chair.tags.any((tag) => tag.toLowerCase().contains(lowerQuery));
    }).toList();
  }
}
