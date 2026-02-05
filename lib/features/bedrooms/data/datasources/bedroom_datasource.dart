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
      name: 'Modern Master Bedroom',
      description: 'Spacious master bedroom set with king size bed, two nightstands, and dresser.',
      price: 799.99,
      originalPrice: 999.99,
      imageUrl: 'https://images.unsplash.com/photo-1553693438-7c6f2a8a71c7?w=400',
      rating: 4.8,
      reviewCount: 102,
      inStock: true,
      category: 'master',
      material: 'wood',
      color: 'white',
      dimensions: BedroomDimensionsModel(width: 240, height: 120, depth: 200, weight: 150),
      isFeatured: true,
      tags: ['luxury', 'spacious', 'modern'],
    ),
    const BedroomModel(
      id: 'bedroom-002',
      name: 'Cozy Guest Bedroom',
      description: 'Comfortable guest bedroom with full size bed and bedside table.',
      price: 499.99,
      imageUrl: 'https://images.unsplash.com/photo-1586023492122-0a62426fbf15?w=400',
      rating: 4.5,
      reviewCount: 78,
      inStock: true,
      category: 'guest',
      material: 'fabric',
      color: 'beige',
      dimensions: BedroomDimensionsModel(width: 200, height: 100, depth: 180, weight: 120),
      isFeatured: false,
      tags: ['cozy', 'guest', 'comfortable'],
    ),
    const BedroomModel(
      id: 'bedroom-003',
      name: 'Kids Bedroom',
      description: 'Fun and colorful kids bedroom set with twin bed and study desk.',
      price: 299.99,
      originalPrice: 349.99,
      imageUrl: 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?w=400',
      rating: 4.6,
      reviewCount: 89,
      inStock: true,
      category: 'kids',
      material: 'wood',
      color: 'blue',
      dimensions: BedroomDimensionsModel(width: 180, height: 90, depth: 160, weight: 80),
      isFeatured: true,
      tags: ['kids', 'playful', 'study'],
    ),
    const BedroomModel(
      id: 'bedroom-004',
      name: 'Minimalist Studio Bedroom',
      description: 'Sleek studio bedroom design with platform bed and floating shelves.',
      price: 699.99,
      imageUrl: 'https://images.unsplash.com/photo-1588854337113-639f1cc59905?w=400',
      rating: 4.7,
      reviewCount: 56,
      inStock: true,
      category: 'studio',
      material: 'metal',
      color: 'gray',
      dimensions: BedroomDimensionsModel(width: 220, height: 110, depth: 190, weight: 130),
      isFeatured: false,
      tags: ['minimalist', 'studio', 'modern'],
    ),
    const BedroomModel(
      id: 'bedroom-005',
      name: 'Rustic Cabin Bedroom',
      description: 'Warm rustic bedroom with log bed frame and natural finishes.',
      price: 649.99,
      imageUrl: 'https://images.unsplash.com/photo-1560448070-c1e3e6a6c9c4?w=400',
      rating: 4.4,
      reviewCount: 45,
      inStock: false,
      category: 'rustic',
      material: 'wood',
      color: 'brown',
      dimensions: BedroomDimensionsModel(width: 230, height: 115, depth: 195, weight: 140),
      isFeatured: false,
      tags: ['rustic', 'cabin', 'natural'],
    ),
    const BedroomModel(
      id: 'bedroom-006',
      name: 'Luxury Hotel Style Bedroom',
      description: 'High-end hotel bedroom experience with plush bedding and mood lighting.',
      price: 1199.99,
      originalPrice: 1399.99,
      imageUrl: 'https://images.unsplash.com/photo-1600585154024-02cffa6e40d7?w=400',
      rating: 4.9,
      reviewCount: 132,
      inStock: true,
      category: 'hotel',
      material: 'fabric',
      color: 'white',
      dimensions: BedroomDimensionsModel(width: 250, height: 130, depth: 200, weight: 160),
      isFeatured: true,
      tags: ['luxury', 'hotel', 'plush'],
    ),
    const BedroomModel(
      id: 'bedroom-007',
      name: 'Vintage Victorian Bedroom',
      description: 'Classic Victorian bedroom set with ornate bedframe and antique dresser.',
      price: 899.99,
      imageUrl: 'https://images.unsplash.com/photo-1589652717521-29c16fe2f6a3?w=400',
      rating: 4.3,
      reviewCount: 38,
      inStock: true,
      category: 'vintage',
      material: 'wood',
      color: 'dark wood',
      dimensions: BedroomDimensionsModel(width: 240, height: 125, depth: 200, weight: 155),
      isFeatured: false,
      tags: ['vintage', 'classic', 'antique'],
    ),
    const BedroomModel(
      id: 'bedroom-008',
      name: 'Industrial Loft Bedroom',
      description: 'Edgy loft bedroom design with metal frame bed and exposed brick accents.',
      price: 749.99,
      imageUrl: 'https://images.unsplash.com/photo-1560448204-e02fdcd58b33?w=400',
      rating: 4.6,
      reviewCount: 64,
      inStock: true,
      category: 'loft',
      material: 'metal',
      color: 'black',
      dimensions: BedroomDimensionsModel(width: 225, height: 115, depth: 185, weight: 145),
      isFeatured: true,
      tags: ['industrial', 'loft', 'urban'],
    ),
    const BedroomModel(
      id: 'bedroom-009',
      name: 'Scandinavian Bedroom',
      description: 'Clean Scandinavian style bedroom with light wood and neutral textiles.',
      price: 799.99,
      imageUrl: 'https://images.unsplash.com/photo-1582719478250-4c6876fa1f47?w=400',
      rating: 4.8,
      reviewCount: 78,
      inStock: true,
      category: 'scandinavian',
      material: 'wood',
      color: 'light wood',
      dimensions: BedroomDimensionsModel(width: 230, height: 120, depth: 190, weight: 150),
      isFeatured: false,
      tags: ['scandinavian', 'minimalist', 'bright'],
    ),
    const BedroomModel(
      id: 'bedroom-010',
      name: 'Contemporary Guest Bedroom',
      description: 'Contemporary guest bedroom with neutral palette and simple lines.',
      price: 549.99,
      imageUrl: 'https://images.unsplash.com/photo-1562072373-4b9ca2de5f1b?w=400',
      rating: 4.5,
      reviewCount: 52,
      inStock: true,
      category: 'guest',
      material: 'fabric',
      color: 'gray',
      dimensions: BedroomDimensionsModel(width: 205, height: 105, depth: 175, weight: 115),
      isFeatured: false,
      tags: ['contemporary', 'guest', 'simple'],
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
      (b) => b.id == id,
      orElse: () => throw Exception('Bedroom not found'),
    );
  }

  @override
  Future<List<BedroomModel>> getBedroomsByCategory(String category) async {
    await Future.delayed(_delay);
    return _mockBedrooms
        .where((b) => b.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  @override
  Future<List<BedroomModel>> getFeaturedBedrooms() async {
    await Future.delayed(_delay);
    return _mockBedrooms.where((b) => b.isFeatured).toList();
  }

  @override
  Future<List<BedroomModel>> searchBedrooms(String query) async {
    await Future.delayed(_delay);
    final lowerQuery = query.toLowerCase();
    return _mockBedrooms.where((b) {
      return b.name.toLowerCase().contains(lowerQuery) ||
          b.description.toLowerCase().contains(lowerQuery) ||
          b.category.toLowerCase().contains(lowerQuery) ||
          b.tags.any((tag) => tag.toLowerCase().contains(lowerQuery));
    }).toList();
  }
}
