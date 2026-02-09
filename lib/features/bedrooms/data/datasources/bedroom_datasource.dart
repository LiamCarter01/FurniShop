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
      name: 'Classic Bed Frame',
      description: 'A timeless wooden bed frame with a sturdy design.',
      price: 499.99,
      originalPrice: 599.99,
      imageUrl: 'https://images.unsplash.com/photo-1601933479930-6af89a8741a3?w=400',
      rating: 4.6,
      reviewCount: 85,
      inStock: true,
      category: 'bed_frame',
      material: 'wood',
      color: 'brown',
      dimensions: BedroomDimensionsModel(width: 160, height: 50, depth: 210, weight: 30),
      isFeatured: true,
      tags: ['wood', 'classic', 'sturdy'],
    ),
    const BedroomModel(
      id: 'bedroom-002',
      name: 'Comfort Foam Mattress',
      description: 'High-density foam mattress for a perfect night’s rest.',
      price: 299.99,
      originalPrice: 349.99,
      imageUrl: 'https://images.unsplash.com/photo-1587502536263-3d5cc6d55cd6?w=400',
      rating: 4.8,
      reviewCount: 120,
      inStock: true,
      category: 'mattress',
      material: 'foam',
      color: 'white',
      dimensions: BedroomDimensionsModel(width: 160, height: 25, depth: 200, weight: 25),
      isFeatured: true,
      tags: ['foam', 'comfort', 'sleep'],
    ),
    const BedroomModel(
      id: 'bedroom-003',
      name: 'Modern Nightstand',
      description: 'Sleek nightstand with two drawers and minimalist metal legs.',
      price: 149.99,
      originalPrice: 179.99,
      imageUrl: 'https://images.unsplash.com/photo-1598300058732-033ca9044b09?w=400',
      rating: 4.5,
      reviewCount: 66,
      inStock: true,
      category: 'nightstand',
      material: 'metal',
      color: 'black',
      dimensions: BedroomDimensionsModel(width: 50, height: 60, depth: 40, weight: 12),
      isFeatured: false,
      tags: ['metal', 'drawers', 'bedside'],
    ),
    const BedroomModel(
      id: 'bedroom-004',
      name: 'Elegant Dresser',
      description: 'Wooden dresser with six spacious drawers for bedroom storage.',
      price: 399.99,
      originalPrice: 449.99,
      imageUrl: 'https://images.unsplash.com/photo-1582582494700-045d1e9ef8bc?w=400',
      rating: 4.7,
      reviewCount: 78,
      inStock: true,
      category: 'dresser',
      material: 'wood',
      color: 'oak',
      dimensions: BedroomDimensionsModel(width: 120, height: 85, depth: 45, weight: 40),
      isFeatured: true,
      tags: ['storage', 'wood', 'bedroom'],
    ),
    const BedroomModel(
      id: 'bedroom-005',
      name: 'Spacious Wardrobe',
      description: 'Three-door wardrobe with hanging rod and shelves.',
      price: 599.99,
      originalPrice: 649.99,
      imageUrl: 'https://images.unsplash.com/photo-1616627561336-e834ca6baa64?w=400',
      rating: 4.6,
      reviewCount: 63,
      inStock: false,
      category: 'wardrobe',
      material: 'engineered wood',
      color: 'white',
      dimensions: BedroomDimensionsModel(width: 150, height: 200, depth: 60, weight: 70),
      isFeatured: false,
      tags: ['storage', 'capsule'],
    ),
    const BedroomModel(
      id: 'bedroom-006',
      name: 'Cozy Throw Blanket',
      description: 'Soft knit blanket perfect for chilly evenings.',
      price: 59.99,
      imageUrl: 'https://images.unsplash.com/photo-1616621581520-6cd5a332a645?w=400',
      rating: 4.9,
      reviewCount: 125,
      inStock: true,
      category: 'textile',
      material: 'knit',
      color: 'gray',
      dimensions: BedroomDimensionsModel(width: 200, height: 2, depth: 150, weight: 1.5),
      isFeatured: false,
      tags: ['blanket', 'cozy'],
    ),
    const BedroomModel(
      id: 'bedroom-007',
      name: 'Nightstand Lamp',
      description: 'LED lamp with adjustable brightness settings.',
      price: 39.99,
      originalPrice: 49.99,
      imageUrl: 'https://images.unsplash.com/photo-1582582494701-abc123efg456?w=400',
      rating: 4.4,
      reviewCount: 50,
      inStock: true,
      category: 'lighting',
      material: 'metal',
      color: 'black',
      dimensions: BedroomDimensionsModel(width: 15, height: 40, depth: 15, weight: 2),
      isFeatured: false,
      tags: ['lamp', 'led'],
    ),
    const BedroomModel(
      id: 'bedroom-008',
      name: 'Soft Area Rug',
      description: 'Plush rug to add warmth underfoot.',
      price: 89.99,
      imageUrl: 'https://images.unsplash.com/photo-1582582494702-xyz789hij012?w=400',
      rating: 4.5,
      reviewCount: 72,
      inStock: true,
      category: 'rug',
      material: 'wool',
      color: 'beige',
      dimensions: BedroomDimensionsModel(width: 180, height: 1, depth: 120, weight: 5),
      isFeatured: false,
      tags: ['rug', 'soft'],
    ),
    const BedroomModel(
      id: 'bedroom-009',
      name: 'Full-Length Mirror',
      description: 'Frameless mirror for your wardrobe and dressing area.',
      price: 129.99,
      originalPrice: 159.99,
      imageUrl: 'https://images.unsplash.com/photo-1582582494703-lmn345opq678?w=400',
      rating: 4.3,
      reviewCount: 40,
      inStock: true,
      category: 'accessory',
      material: 'glass',
      color: 'clear',
      dimensions: BedroomDimensionsModel(width: 50, height: 160, depth: 2, weight: 10),
      isFeatured: false,
      tags: ['mirror', 'decor'],
    ),
    const BedroomModel(
      id: 'bedroom-010',
      name: 'Upholstered Bench',
      description: 'Stylish bench with padded seat for bedroom seating.',
      price: 179.99,
      imageUrl: 'https://images.unsplash.com/photo-1582582494704-uvw901rst234?w=400',
      rating: 4.7,
      reviewCount: 58,
      inStock: true,
      category: 'bench',
      material: 'fabric',
      color: 'blue',
      dimensions: BedroomDimensionsModel(width: 120, height: 45, depth: 40, weight: 15),
      isFeatured: true,
      tags: ['bench', 'upholstered'],
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
