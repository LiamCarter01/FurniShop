import '../models/bedroom_model.dart';

/// Data source interface for bedroom API operations.
///
/// This defines the contract for remote data access.
abstract class BedroomDataSource {
  /// Fetch all bedroom products.
  Future<List<BedroomModel>> getBedrooms();

  /// Fetch a single bedroom product by ID.
  Future<BedroomModel> getBedroomById(String id);

  /// Fetch bedroom products by category.
  Future<List<BedroomModel>> getBedroomsByCategory(String category);

  /// Fetch featured bedroom products.
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

  /// Mock bedroom data derived from the provided assets.
  final List<BedroomModel> _mockBedrooms = [
    const BedroomModel(
      id: 'bedroom-001',
      name: 'Modern Bedroom Set',
      description:
          'Complete modern bedroom set with upholstered bed, matching nightstand, and streamlined dresser.',
      price: 2499.00,
      originalPrice: 2899.00,
      imageUrl: 'https://images.unsplash.com/photo-1505693314120-0d443867891c?w=400',
      rating: 4.9,
      reviewCount: 214,
      inStock: true,
      category: 'bed',
      material: 'leather',
      color: 'ivory',
      dimensions: BedroomDimensionsModel(
        width: 220,
        height: 130,
        depth: 210,
        weight: 120,
      ),
      isFeatured: true,
      tags: ['set', 'modern', 'luxury'],
    ),
    const BedroomModel(
      id: 'bedroom-002',
      name: 'Platform Bed',
      description:
          'Low-profile platform bed frame with natural wood finish that complements minimalist interiors.',
      price: 899.00,
      imageUrl: 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=400',
      rating: 4.6,
      reviewCount: 182,
      inStock: true,
      category: 'bed',
      material: 'wood',
      color: 'oak',
      dimensions: BedroomDimensionsModel(
        width: 190,
        height: 45,
        depth: 210,
        weight: 80,
      ),
      isFeatured: false,
      tags: ['platform', 'wooden', 'minimalist'],
    ),
    const BedroomModel(
      id: 'bedroom-003',
      name: 'Nightstand',
      description:
          'Compact nightstand with two soft-close drawers and integrated ambient lighting strip.',
      price: 249.00,
      imageUrl: 'https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=400',
      rating: 4.4,
      reviewCount: 96,
      inStock: true,
      category: 'storage',
      material: 'mdf',
      color: 'off-white',
      dimensions: BedroomDimensionsModel(
        width: 60,
        height: 65,
        depth: 45,
        weight: 18,
      ),
      isFeatured: false,
      tags: ['nightstand', 'storage', 'ambient'],
    ),
    const BedroomModel(
      id: 'bedroom-004',
      name: 'Dresser',
      description:
          'Six-drawer wooden dresser with brushed metal handles and spacious interior compartments.',
      price: 1299.00,
      originalPrice: 1499.00,
      imageUrl: 'https://images.unsplash.com/photo-1588046130717-0eb0ccf312f2?w=400',
      rating: 4.8,
      reviewCount: 127,
      inStock: true,
      category: 'storage',
      material: 'solid wood',
      color: 'chestnut',
      dimensions: BedroomDimensionsModel(
        width: 160,
        height: 110,
        depth: 55,
        weight: 70,
      ),
      isFeatured: true,
      tags: ['dresser', 'storage', 'classic'],
    ),
    const BedroomModel(
      id: 'bedroom-005',
      name: 'Wardrobe',
      description:
          'Tall wardrobe with sliding doors, integrated LED strips, and adjustable shelving.',
      price: 1799.00,
      imageUrl: 'https://images.unsplash.com/photo-1595428773083-1e42a8219dbc?w=400',
      rating: 4.7,
      reviewCount: 103,
      inStock: false,
      category: 'storage',
      material: 'laminate',
      color: 'graphite',
      dimensions: BedroomDimensionsModel(
        width: 200,
        height: 220,
        depth: 65,
        weight: 110,
      ),
      isFeatured: false,
      tags: ['wardrobe', 'sliding', 'storage'],
    ),
    const BedroomModel(
      id: 'bedroom-006',
      name: 'Vanity Table',
      description:
          'Elegant vanity table with pivoting mirror, marble top, and velvet upholstered stool.',
      price: 799.00,
      imageUrl: 'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=400',
      rating: 4.5,
      reviewCount: 68,
      inStock: true,
      category: 'accessories',
      material: 'marble',
      color: 'blush',
      dimensions: BedroomDimensionsModel(
        width: 120,
        height: 150,
        depth: 45,
        weight: 40,
      ),
      isFeatured: false,
      tags: ['vanity', 'mirror', 'luxury'],
    ),
    const BedroomModel(
      id: 'bedroom-007',
      name: 'Storage Bench',
      description:
          'Upholstered storage bench with lift-top compartment and brass accent legs.',
      price: 349.00,
      imageUrl: 'https://images.unsplash.com/photo-1558899189-5a8d8e8ec7dc?w=400',
      rating: 4.3,
      reviewCount: 54,
      inStock: true,
      category: 'accessories',
      material: 'fabric',
      color: 'sage',
      dimensions: BedroomDimensionsModel(
        width: 150,
        height: 50,
        depth: 45,
        weight: 25,
      ),
      isFeatured: false,
      tags: ['bench', 'storage', 'seating'],
    ),
    const BedroomModel(
      id: 'bedroom-008',
      name: 'Chest of Drawers',
      description:
          'Tall chest with multiple drawers and gold-finished hardware for a glamorous touch.',
      price: 999.00,
      imageUrl: 'https://images.unsplash.com/photo-1595428774286-4fbb86f6b6ce?w=400',
      rating: 4.6,
      reviewCount: 89,
      inStock: true,
      category: 'storage',
      material: 'lacquered wood',
      color: 'white',
      dimensions: BedroomDimensionsModel(
        width: 100,
        height: 160,
        depth: 50,
        weight: 45,
      ),
      isFeatured: false,
      tags: ['chest', 'drawers', 'glam'],
    ),
    const BedroomModel(
      id: 'bedroom-009',
      name: 'Bedside Table Set',
      description:
          'Matching pair of bedside tables with ceramic hardware and soft-close drawers.',
      price: 549.00,
      imageUrl: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400',
      rating: 4.5,
      reviewCount: 77,
      inStock: true,
      category: 'storage',
      material: 'veneer',
      color: 'charcoal',
      dimensions: BedroomDimensionsModel(
        width: 120,
        height: 70,
        depth: 40,
        weight: 32,
      ),
      isFeatured: false,
      tags: ['bedside', 'set', 'matching'],
    ),
    const BedroomModel(
      id: 'bedroom-010',
      name: 'Upholstered Headboard',
      description:
          'Tufted upholstered headboard with button detailing and padded backing for added comfort.',
      price: 699.00,
      originalPrice: 799.00,
      imageUrl: 'https://images.unsplash.com/photo-1540574163026-643ea20ade25?w=400',
      rating: 4.8,
      reviewCount: 118,
      inStock: true,
      category: 'bed',
      material: 'fabric',
      color: 'midnight',
      dimensions: BedroomDimensionsModel(
        width: 140,
        height: 120,
        depth: 10,
        weight: 22,
      ),
      isFeatured: true,
      tags: ['headboard', 'upholstered', 'luxury'],
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
      orElse: () => throw Exception('Bedroom product not found'),
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
