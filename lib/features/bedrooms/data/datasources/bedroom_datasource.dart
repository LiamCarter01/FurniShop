import '../models/bedroom_model.dart';

/// Data source interface for bedroom API operations.
///
/// This defines the contract for remote data access.
abstract class BedroomDataSource {
  /// Fetch all bedrooms.
  Future<List<BedroomModel>> getBedrooms();

  /// Fetch a single bedroom by ID.
  Future<BedroomModel> getBedroomById(String id);

  /// Fetch bedrooms by category.
  Future<List<BedroomModel>> getBedroomsByCategory(String category);

  /// Fetch featured bedrooms.
  Future<List<BedroomModel>> getFeaturedBedrooms();

  /// Search bedrooms by query.
  Future<List<BedroomModel>> searchBedrooms(String query);
}

/// Mock implementation of [BedroomDataSource] for development.
///
/// Returns mock data instead of making real API calls.
class MockBedroomDataSource implements BedroomDataSource {
  /// Simulated network delay.
  static const Duration _delay = Duration(milliseconds: 800);

  /// Mock bedroom data.
  final List<BedroomModel> _mockBedrooms = [
    const BedroomModel(
      id: 'bedroom-001',
      name: 'Modern Bed Frame',
      description: 'A sleek modern bed frame with upholstered headboard.',
      price: 499.99,
      originalPrice: 599.99,
      imageUrl: 'https://images.unsplash.com/photo-1588646955038-41a5f0314c3f?w=400',
      rating: 4.8,
      reviewCount: 120,
      inStock: true,
      category: 'bed_frame',
      material: 'wood',
      color: 'white',
      dimensions: BedroomDimensionsModel(width: 210, height: 100, depth: 150, weight: 45),
      isFeatured: true,
      tags: ['bed', 'bedroom', 'modern'],
    ),
    const BedroomModel(
      id: 'bedroom-002',
      name: 'Classic Nightstand',
      description: 'A timeless nightstand with drawer and shelf for storage.',
      price: 149.99,
      imageUrl: 'https://images.unsplash.com/photo-1600585154340-be6161b20f90?w=400',
      rating: 4.6,
      reviewCount: 85,
      inStock: true,
      category: 'nightstand',
      material: 'wood',
      color: 'brown',
      dimensions: BedroomDimensionsModel(width: 50, height: 60, depth: 40, weight: 10),
      isFeatured: false,
      tags: ['nightstand', 'bedroom', 'storage'],
    ),
    const BedroomModel(
      id: 'bedroom-003',
      name: 'Spacious Dresser',
      description: 'A 6-drawer dresser with elegant finish and ample storage space.',
      price: 799.99,
      originalPrice: 899.99,
      imageUrl: 'https://images.unsplash.com/photo-1582582494704-4f5cd6ac1b6a?w=400',
      rating: 4.9,
      reviewCount: 150,
      inStock: true,
      category: 'dresser',
      material: 'wood',
      color: 'oak',
      dimensions: BedroomDimensionsModel(width: 180, height: 90, depth: 45, weight: 55),
      isFeatured: true,
      tags: ['dresser', 'bedroom', 'storage'],
    ),
    const BedroomModel(
      id: 'bedroom-004',
      name: 'Wardrobe Closet',
      description: 'A spacious wardrobe with hanging rod and shelves.',
      price: 899.99,
      imageUrl: 'https://images.unsplash.com/photo-1581579189550-d26d832c5f9e?w=400',
      rating: 4.7,
      reviewCount: 60,
      inStock: false,
      category: 'wardrobe',
      material: 'metal',
      color: 'black',
      dimensions: BedroomDimensionsModel(width: 120, height: 200, depth: 60, weight: 70),
      isFeatured: false,
      tags: ['wardrobe', 'bedroom', 'closet'],
    ),
    const BedroomModel(
      id: 'bedroom-005',
      name: 'Memory Foam Mattress',
      description: 'Comfortable memory foam mattress with medium firmness.',
      price: 299.99,
      imageUrl: 'https://images.unsplash.com/photo-1592194996308-7b43878e84a6?w=400',
      rating: 4.5,
      reviewCount: 110,
      inStock: true,
      category: 'mattress',
      material: 'foam',
      color: 'white',
      dimensions: BedroomDimensionsModel(width: 160, height: 25, depth: 200, weight: 30),
      isFeatured: false,
      tags: ['mattress', 'bedroom', 'comfort'],
    ),
    const BedroomModel(
      id: 'bedroom-006',
      name: 'Bedside Lamp',
      description: 'A stylish bedside lamp with adjustable brightness.',
      price: 39.99,
      imageUrl: 'https://images.unsplash.com/photo-1505691723518-36a0126b204b?w=400',
      rating: 4.3,
      reviewCount: 45,
      inStock: true,
      category: 'bedside_lamp',
      material: 'metal',
      color: 'gold',
      dimensions: BedroomDimensionsModel(width: 20, height: 50, depth: 20, weight: 2),
      isFeatured: false,
      tags: ['lamp', 'bedside', 'lighting'],
    ),
    const BedroomModel(
      id: 'bedroom-007',
      name: 'Cozy Area Rug',
      description: 'A soft area rug to enhance bedroom comfort.',
      price: 129.99,
      originalPrice: 159.99,
      imageUrl: 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?w=400',
      rating: 4.4,
      reviewCount: 75,
      inStock: true,
      category: 'rug',
      material: 'wool',
      color: 'gray',
      dimensions: BedroomDimensionsModel(width: 200, height: 0.5, depth: 150, weight: 8),
      isFeatured: true,
      tags: ['rug', 'bedroom', 'decor'],
    ),
    const BedroomModel(
      id: 'bedroom-008',
      name: 'Bedroom Bench',
      description: 'A plush bench perfect for seating at the foot of the bed.',
      price: 199.99,
      imageUrl: 'https://images.unsplash.com/photo-1567016432779-c8c621393a17?w=400',
      rating: 4.2,
      reviewCount: 30,
      inStock: true,
      category: 'bed_bench',
      material: 'fabric',
      color: 'blue',
      dimensions: BedroomDimensionsModel(width: 150, height: 45, depth: 40, weight: 15),
      isFeatured: false,
      tags: ['bench', 'bedroom', 'seating'],
    ),
    const BedroomModel(
      id: 'bedroom-009',
      name: 'Makeup Vanity',
      description: 'A vanity table with mirror and drawers for cosmetics.',
      price: 349.99,
      imageUrl: 'https://images.unsplash.com/photo-1519710164239-da123dc03ef4?w=400',
      rating: 4.6,
      reviewCount: 65,
      inStock: true,
      category: 'vanity',
      material: 'wood',
      color: 'white',
      dimensions: BedroomDimensionsModel(width: 120, height: 160, depth: 45, weight: 25),
      isFeatured: false,
      tags: ['vanity', 'bedroom', 'dressing'],
    ),
    const BedroomModel(
      id: 'bedroom-010',
      name: 'Bedroom Bookshelf',
      description: 'A versatile bookshelf for books and decor items.',
      price: 179.99,
      imageUrl: 'https://images.unsplash.com/photo-1517433456452-f9633a875f6f?w=400',
      rating: 4.1,
      reviewCount: 50,
      inStock: true,
      category: 'bookshelf',
      material: 'wood',
      color: 'brown',
      dimensions: BedroomDimensionsModel(width: 80, height: 180, depth: 30, weight: 22),
      isFeatured: false,
      tags: ['bookshelf', 'bedroom', 'storage'],
    ),
  ];

  @override
  Future<List<BedroomModel>> getBedrooms() async {
    await Future.delayed(_delay);
    return _mockBedrooms;
  }

  @override
  Future<BedroomModel> getBedroomById(String id) async {
    await Future.delayed(_delay);
    return _mockBedrooms.firstWhere(
      (item) => item.id == id,
      orElse: () => throw Exception('Bedroom not found'),
    );
  }

  @override
  Future<List<BedroomModel>> getBedroomsByCategory(String category) async {
    await Future.delayed(_delay);
    return _mockBedrooms
        .where((item) => item.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  @override
  Future<List<BedroomModel>> getFeaturedBedrooms() async {
    await Future.delayed(_delay);
    return _mockBedrooms.where((item) => item.isFeatured).toList();
  }

  @override
  Future<List<BedroomModel>> searchBedrooms(String query) async {
    await Future.delayed(_delay);
    final lowerQuery = query.toLowerCase();
    return _mockBedrooms.where((item) {
      return item.name.toLowerCase().contains(lowerQuery) ||
          item.description.toLowerCase().contains(lowerQuery) ||
          item.category.toLowerCase().contains(lowerQuery) ||
          item.tags.any((tag) => tag.toLowerCase().contains(lowerQuery));
    }).toList();
  }
}
