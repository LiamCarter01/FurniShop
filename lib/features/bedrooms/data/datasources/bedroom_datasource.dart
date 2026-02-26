import '../models/bedroom_model.dart';

/// Data source interface for bedroom API operations.
///
/// This defines the contract for remote data access.
abstract class BedroomDataSource {
  /// Fetch all bedrooms from API.
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
/// Replace with real API implementation in production.
class MockBedroomDataSource implements BedroomDataSource {
  /// Simulated network delay.
  static const Duration _delay = Duration(milliseconds: 800);

  /// Mock bedroom data with at least 10 entries.
  final List<BedroomModel> _mockBedrooms = [
    const BedroomModel(
      id: 'bedroom-001',
      name: 'Coastal Retreat Suite',
      description:
          'Soft blue tones, linen textures, and natural oak accents create a calm coastal retreat.',
      price: 1299.99,
      originalPrice: 1499.99,
      imageUrl:
          'https://images.unsplash.com/photo-1505692794400-14394a8ef7c4?w=400',
      rating: 4.9,
      reviewCount: 198,
      inStock: true,
      category: 'coastal',
      material: 'wood',
      color: 'blue',
      dimensions: BedroomDimensionsModel(
        width: 220,
        height: 165,
        depth: 210,
        weight: 85,
      ),
      isFeatured: true,
      tags: ['coastal', 'relaxing', 'linen'],
    ),
    const BedroomModel(
      id: 'bedroom-002',
      name: 'Modern Minimalist Suite',
      description:
          'Sleek platform bed with matte black finish and integrated LED nightstands.',
      price: 1599.99,
      imageUrl:
          'https://images.unsplash.com/photo-1493666438817-866a91353ca9?w=400',
      rating: 4.8,
      reviewCount: 142,
      inStock: true,
      category: 'modern',
      material: 'metal',
      color: 'black',
      dimensions: BedroomDimensionsModel(
        width: 210,
        height: 150,
        depth: 205,
        weight: 95,
      ),
      isFeatured: true,
      tags: ['modern', 'platform', 'LED'],
    ),
    const BedroomModel(
      id: 'bedroom-003',
      name: 'Bohemian Luxe Retreat',
      description:
          'Layered textiles, rattan accents, and artisan details for a boho inspired bedroom.',
      price: 1399.99,
      imageUrl:
          'https://images.unsplash.com/photo-1505691938895-1758d7feb511?w=400',
      rating: 4.7,
      reviewCount: 103,
      inStock: true,
      category: 'boho',
      material: 'upholstery',
      color: 'earth',
      dimensions: BedroomDimensionsModel(
        width: 230,
        height: 160,
        depth: 215,
        weight: 90,
      ),
      isFeatured: false,
      tags: ['boho', 'textured', 'artisan'],
    ),
    const BedroomModel(
      id: 'bedroom-004',
      name: 'Scandinavian Haven',
      description:
          'Light wood, soft fabrics, and clean lines converge in this Scandinavian inspired suite.',
      price: 1249.99,
      imageUrl:
          'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=400',
      rating: 4.6,
      reviewCount: 87,
      inStock: true,
      category: 'scandinavian',
      material: 'wood',
      color: 'white',
      dimensions: BedroomDimensionsModel(
        width: 215,
        height: 155,
        depth: 210,
        weight: 80,
      ),
      isFeatured: false,
      tags: ['scandi', 'minimal', 'light'],
    ),
    const BedroomModel(
      id: 'bedroom-005',
      name: 'Urban Loft Master',
      description:
          'Industrial metal bed frame with leather headboard and concrete-inspired surfaces.',
      price: 1499.99,
      originalPrice: 1699.99,
      imageUrl:
          'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=400',
      rating: 4.5,
      reviewCount: 113,
      inStock: true,
      category: 'industrial',
      material: 'metal',
      color: 'gray',
      dimensions: BedroomDimensionsModel(
        width: 225,
        height: 170,
        depth: 220,
        weight: 100,
      ),
      isFeatured: true,
      tags: ['industrial', 'loft', 'leather'],
    ),
    const BedroomModel(
      id: 'bedroom-006',
      name: 'Cozy Cottage Collection',
      description:
          'Soft pastels, vintage mirrors, and turned wood details transport you to a countryside cottage.',
      price: 1149.99,
      imageUrl:
          'https://images.unsplash.com/photo-1519710164239-da123dc03ef4?w=400',
      rating: 4.4,
      reviewCount: 64,
      inStock: true,
      category: 'cottage',
      material: 'wood',
      color: 'blush',
      dimensions: BedroomDimensionsModel(
        width: 205,
        height: 150,
        depth: 200,
        weight: 75,
      ),
      isFeatured: false,
      tags: ['cottage', 'vintage', 'pastel'],
    ),
    const BedroomModel(
      id: 'bedroom-007',
      name: 'Luxury Velvet Sanctuary',
      description:
          'Sumptuous velvet headboard, mirrored nightstands, and crystal lighting for a glamorous bedroom.',
      price: 1799.99,
      imageUrl:
          'https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0?w=400',
      rating: 4.9,
      reviewCount: 223,
      inStock: true,
      category: 'luxury',
      material: 'velvet',
      color: 'emerald',
      dimensions: BedroomDimensionsModel(
        width: 240,
        height: 175,
        depth: 230,
        weight: 110,
      ),
      isFeatured: true,
      tags: ['velvet', 'glam', 'luxury'],
    ),
    const BedroomModel(
      id: 'bedroom-008',
      name: 'Tropical Escape Set',
      description:
          'rattan accents paired with botanical fabrics to create a tropical getaway right at home.',
      price: 1349.99,
      imageUrl:
          'https://images.unsplash.com/photo-1505693416388-5922c52f3cd3?w=400',
      rating: 4.6,
      reviewCount: 90,
      inStock: true,
      category: 'tropical',
      material: 'rattan',
      color: 'beige',
      dimensions: BedroomDimensionsModel(
        width: 220,
        height: 165,
        depth: 225,
        weight: 88,
      ),
      isFeatured: false,
      tags: ['tropical', 'rattan', 'botanical'],
    ),
    const BedroomModel(
      id: 'bedroom-009',
      name: 'Zen Retreat Ensemble',
      description:
          'Calming neutrals, tatami-inspired platform bed, and natural stone details for mindfulness spaces.',
      price: 1249.99,
      imageUrl:
          'https://images.unsplash.com/photo-1485827404703-89b55fcc595e?w=400',
      rating: 4.7,
      reviewCount: 110,
      inStock: false,
      category: 'zen',
      material: 'bamboo',
      color: 'sand',
      dimensions: BedroomDimensionsModel(
        width: 210,
        height: 155,
        depth: 205,
        weight: 82,
      ),
      isFeatured: false,
      tags: ['zen', 'mindful', 'calm'],
    ),
    const BedroomModel(
      id: 'bedroom-010',
      name: 'Urban Studio Loft',
      description:
          'Compact, modular pieces optimized for studio living with mixed metal and warm wood tones.',
      price: 1199.99,
      imageUrl:
          'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=400',
      rating: 4.5,
      reviewCount: 76,
      inStock: true,
      category: 'studio',
      material: 'mixed',
      color: 'taupe',
      dimensions: BedroomDimensionsModel(
        width: 200,
        height: 150,
        depth: 195,
        weight: 78,
      ),
      isFeatured: false,
      tags: ['studio', 'compact', 'modular'],
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
      (bedroom) => bedroom.id == id,
      orElse: () => throw Exception('Bedroom not found'),
    );
  }

  @override
  Future<List<BedroomModel>> getBedroomsByCategory(String category) async {
    await Future.delayed(_delay);
    return _mockBedrooms
        .where((bedroom) => bedroom.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  @override
  Future<List<BedroomModel>> getFeaturedBedrooms() async {
    await Future.delayed(_delay);
    return _mockBedrooms.where((bedroom) => bedroom.isFeatured).toList();
  }

  @override
  Future<List<BedroomModel>> searchBedrooms(String query) async {
    await Future.delayed(_delay);
    final lowerQuery = query.toLowerCase();
    return _mockBedrooms.where((bedroom) {
      return bedroom.name.toLowerCase().contains(lowerQuery) ||
          bedroom.description.toLowerCase().contains(lowerQuery) ||
          bedroom.category.toLowerCase().contains(lowerQuery) ||
          bedroom.tags.any((tag) => tag.toLowerCase().contains(lowerQuery));
    }).toList();
  }
}
