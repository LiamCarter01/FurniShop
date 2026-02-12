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
      name: 'Elegant Canopy Bed',
      description: 'Luxurious canopy bed with solid mahogany frame and velvet drapes.',
      price: 1299.99,
      originalPrice: 1499.99,
      imageUrl: 'https://images.unsplash.com/photo-1616627981536-wxyz?w=400',
      rating: 4.8,
      reviewCount: 85,
      inStock: true,
      category: 'bed',
      material: 'mahogany',
      color: 'dark brown',
      dimensions: BedroomDimensionsModel(width: 200, height: 250, depth: 210, weight: 75),
      isFeatured: true,
      tags: ['canopy', 'luxury', 'mahogany'],
    ),
    const BedroomModel(
      id: 'bedroom-002',
      name: 'Modern Platform Bed',
      description: 'Sleek low-profile platform bed with engineered wood and upholstered headboard.',
      price: 899.99,
      imageUrl: 'https://images.unsplash.com/photo-1584321526092-abcd?w=400',
      rating: 4.5,
      reviewCount: 64,
      inStock: true,
      category: 'platform',
      material: 'engineered wood',
      color: 'white',
      dimensions: BedroomDimensionsModel(width: 190, height: 90, depth: 200, weight: 55),
      isFeatured: false,
      tags: ['platform', 'modern'],
    ),
    const BedroomModel(
      id: 'bedroom-003',
      name: 'Upholstered Bed Frame',
      description: 'Elegant upholstered bed frame with tufted headboard and velvet fabric.',
      price: 1099.99,
      originalPrice: 1199.99,
      imageUrl: 'https://images.unsplash.com/photo-1600585154340-efgh?w=400',
      rating: 4.6,
      reviewCount: 90,
      inStock: true,
      category: 'upholstered',
      material: 'velvet',
      color: 'blue',
      dimensions: BedroomDimensionsModel(width: 195, height: 110, depth: 205, weight: 60),
      isFeatured: true,
      tags: ['upholstered', 'tufted'],
    ),
    const BedroomModel(
      id: 'bedroom-004',
      name: 'Rustic Wooden Bed',
      description: 'Charming rustic bed made from reclaimed pine with natural finish.',
      price: 799.99,
      imageUrl: 'https://images.unsplash.com/photo-1598300058732-ijkl?w=400',
      rating: 4.4,
      reviewCount: 48,
      inStock: false,
      category: 'wood',
      material: 'pine',
      color: 'natural',
      dimensions: BedroomDimensionsModel(width: 200, height: 100, depth: 210, weight: 70),
      isFeatured: false,
      tags: ['rustic', 'reclaimed'],
    ),
    const BedroomModel(
      id: 'bedroom-005',
      name: 'Storage Bed with Drawers',
      description: 'Functional storage bed with built-in drawers, perfect for small spaces.',
      price: 950.00,
      imageUrl: 'https://images.unsplash.com/photo-1578894387440-mnop?w=400',
      rating: 4.7,
      reviewCount: 112,
      inStock: true,
      category: 'storage',
      material: 'wood',
      color: 'grey',
      dimensions: BedroomDimensionsModel(width: 200, height: 100, depth: 210, weight: 80),
      isFeatured: true,
      tags: ['storage', 'space-saving'],
    ),
    const BedroomModel(
      id: 'bedroom-006',
      name: 'King Size Bed Frame',
      description: 'Sturdy king size bed frame with metal support and headboard.',
      price: 1199.00,
      originalPrice: 1299.00,
      imageUrl: 'https://images.unsplash.com/photo-1575320181287-qrst?w=400',
      rating: 4.3,
      reviewCount: 77,
      inStock: true,
      category: 'king',
      material: 'metal',
      color: 'black',
      dimensions: BedroomDimensionsModel(width: 210, height: 110, depth: 220, weight: 85),
      isFeatured: false,
      tags: ['king', 'metal'],
    ),
    const BedroomModel(
      id: 'bedroom-007',
      name: 'Kids Bunk Bed',
      description: 'Durable bunk bed designed for kids with safety rails and ladder.',
      price: 549.99,
      imageUrl: 'https://images.unsplash.com/photo-1582362344393-uvwx?w=400',
      rating: 4.5,
      reviewCount: 53,
      inStock: true,
      category: 'kids',
      material: 'wood',
      color: 'white',
      dimensions: BedroomDimensionsModel(width: 200, height: 180, depth: 95, weight: 65),
      isFeatured: false,
      tags: ['kids', 'bunk'],
    ),
    const BedroomModel(
      id: 'bedroom-008',
      name: 'Adjustable Bed Frame',
      description: 'Electric adjustable bed frame with remote control for head tilt.',
      price: 1399.50,
      imageUrl: 'https://images.unsplash.com/photo-1589966833180-yzab?w=400',
      rating: 4.6,
      reviewCount: 68,
      inStock: true,
      category: 'adjustable',
      material: 'metal',
      color: 'silver',
      dimensions: BedroomDimensionsModel(width: 190, height: 110, depth: 200, weight: 95),
      isFeatured: true,
      tags: ['adjustable', 'electric'],
    ),
    const BedroomModel(
      id: 'bedroom-009',
      name: 'Platform Daybed',
      description: 'Versatile daybed with platform design, doubles as seating.',
      price: 799.99,
      imageUrl: 'https://images.unsplash.com/photo-1606971908213-cdef?w=400',
      rating: 4.2,
      reviewCount: 44,
      inStock: false,
      category: 'daybed',
      material: 'wood',
      color: 'oak',
      dimensions: BedroomDimensionsModel(width: 195, height: 90, depth: 95, weight: 60),
      isFeatured: false,
      tags: ['daybed', 'versatile'],
    ),
    const BedroomModel(
      id: 'bedroom-010',
      name: 'Storage Ottoman Bed',
      description: 'Ottoman-style storage bed with hydraulic lift for hidden storage.',
      price: 1050.00,
      imageUrl: 'https://images.unsplash.com/photo-1612915596959-ghij?w=400',
      rating: 4.7,
      reviewCount: 59,
      inStock: true,
      category: 'ottoman',
      material: 'fabric',
      color: 'charcoal',
      dimensions: BedroomDimensionsModel(width: 200, height: 100, depth: 210, weight: 78),
      isFeatured: true,
      tags: ['storage', 'ottoman'],
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
    return _mockBedrooms.where((item) => item.category.toLowerCase() == category.toLowerCase()).toList();
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