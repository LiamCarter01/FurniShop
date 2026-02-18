import '../models/bedroom_model.dart';

/// Data source contract for bedroom data operations.
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

/// Mock implementation of [BedroomDataSource].
class MockBedroomDataSource implements BedroomDataSource {
  static const Duration _delay = Duration(milliseconds: 800);

  final List<BedroomModel> _mockBedrooms = [
    const BedroomModel(
      id: 'bedroom-001',
      name: 'Scandinavian Platform Bed',
      description:
          'Warm oak platform bed with floating headboard and integrated LED backlighting for a serene sleep space.',
      price: 1299.99,
      originalPrice: 1499.99,
      imageUrl:
          'https://images.unsplash.com/photo-1505691938895-1758d7feb511?w=400',
      rating: 4.8,
      reviewCount: 210,
      inStock: true,
      category: 'beds',
      material: 'oak',
      color: 'natural',
      dimensions: BedroomDimensionsModel(
        width: 210,
        height: 40,
        depth: 190,
        weight: 75,
      ),
      isFeatured: true,
      tags: ['platform', 'lighted', 'minimalist', 'bedroom'],
    ),
    const BedroomModel(
      id: 'bedroom-002',
      name: 'Mid-Century Nightstand',
      description:
          'Compact sober walnut nightstand with two soft-close drawers and brass hardware.',
      price: 249.99,
      originalPrice: 299.99,
      imageUrl:
          'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=400',
      rating: 4.6,
      reviewCount: 138,
      inStock: true,
      category: 'storage',
      material: 'walnut',
      color: 'walnut',
      dimensions: BedroomDimensionsModel(
        width: 60,
        height: 60,
        depth: 45,
        weight: 18,
      ),
      tags: ['nightstand', 'storage', 'mid-century'],
    ),
    const BedroomModel(
      id: 'bedroom-003',
      name: 'Convertible Dressing Table',
      description:
          'Dual-purpose dressing table that transforms into a minimalist desk with adjustable mirror.',
      price: 399.99,
      imageUrl:
          'https://images.unsplash.com/photo-1493666438817-866a91353ca9?w=400',
      rating: 4.4,
      reviewCount: 87,
      inStock: true,
      category: 'vanities',
      material: 'maple',
      color: 'white',
      dimensions: BedroomDimensionsModel(
        width: 140,
        height: 75,
        depth: 45,
        weight: 35,
      ),
      tags: ['vanity', 'desk', 'convertible'],
    ),
    const BedroomModel(
      id: 'bedroom-004',
      name: 'Tufted Upholstered Bench',
      description:
          'Chic velvet bench with brass legs and tufted cushion to style the foot of the bed.',
      price: 379.99,
      imageUrl:
          'https://images.unsplash.com/photo-1549187774-b4e9b0445b69?w=400',
      rating: 4.5,
      reviewCount: 94,
      inStock: true,
      category: 'seating',
      material: 'velvet',
      color: 'smoke',
      dimensions: BedroomDimensionsModel(
        width: 140,
        height: 48,
        depth: 40,
        weight: 22,
      ),
      tags: ['bench', 'accent', 'upholstered'],
    ),
    const BedroomModel(
      id: 'bedroom-005',
      name: 'LED Floating Shelves Set',
      description:
          'Set of three floating shelves with integrated LED strip for styling and ambient storage.',
      price: 159.99,
      imageUrl:
          'https://images.unsplash.com/photo-1493666438817-866a91353ca9?w=400',
      rating: 4.3,
      reviewCount: 62,
      inStock: false,
      category: 'storage',
      material: 'engineered_wood',
      color: 'white',
      dimensions: BedroomDimensionsModel(
        width: 120,
        height: 6,
        depth: 25,
        weight: 12,
      ),
      tags: ['led', 'shelves', 'storage'],
    ),
    const BedroomModel(
      id: 'bedroom-006',
      name: 'Directional Floor Lamp',
      description:
          'Brass floor lamp with adjustable head and fabric shade for task lighting.',
      price: 189.99,
      imageUrl:
          'https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=400',
      rating: 4.2,
      reviewCount: 73,
      inStock: true,
      category: 'lighting',
      material: 'brass',
      color: 'brass',
      dimensions: BedroomDimensionsModel(
        width: 45,
        height: 160,
        depth: 45,
        weight: 10,
      ),
      tags: ['lighting', 'floor lamp', 'task'],
    ),
    const BedroomModel(
      id: 'bedroom-007',
      name: 'Down-Alternative Comforter',
      description:
          'Hypoallergenic comforter with breathable cotton shell and lofty fill for year-round comfort.',
      price: 129.99,
      imageUrl:
          'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=400',
      rating: 4.6,
      reviewCount: 156,
      inStock: true,
      category: 'textiles',
      material: 'cotton',
      color: 'ivory',
      dimensions: BedroomDimensionsModel(
        width: 230,
        height: 25,
        depth: 200,
        weight: 4,
      ),
      tags: ['comforter', 'textiles'],
    ),
    const BedroomModel(
      id: 'bedroom-008',
      name: 'Modular Wardrobe System',
      description:
          'Customizable wardrobe system with matte doors, open shelves, and automated lighting.',
      price: 2499.99,
      originalPrice: 2799.99,
      imageUrl:
          'https://images.unsplash.com/photo-1505691938895-1758d7feb511?w=400',
      rating: 4.9,
      reviewCount: 48,
      inStock: true,
      category: 'storage',
      material: 'lacquered_wood',
      color: 'charcoal',
      dimensions: BedroomDimensionsModel(
        width: 300,
        height: 230,
        depth: 60,
        weight: 220,
      ),
      isFeatured: true,
      tags: ['wardrobe', 'custom', 'modular'],
    ),
    const BedroomModel(
      id: 'bedroom-009',
      name: 'Artisan Area Rug',
      description:
          'Handwoven wool rug with geometric print to ground the bedroom layout.',
      price: 349.99,
      imageUrl:
          'https://images.unsplash.com/photo-1549187774-b4e9b0445b69?w=400',
      rating: 4.7,
      reviewCount: 129,
      inStock: true,
      category: 'textiles',
      material: 'wool',
      color: 'rust',
      dimensions: BedroomDimensionsModel(
        width: 240,
        height: 2,
        depth: 170,
        weight: 12,
      ),
      tags: ['rug', 'textiles', 'artisan'],
    ),
    const BedroomModel(
      id: 'bedroom-010',
      name: 'Decorative Accent Mirror',
      description:
          'Oversized arched mirror with brushed brass frame to brighten the space.',
      price: 219.99,
      imageUrl:
          'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=400',
      rating: 4.4,
      reviewCount: 57,
      inStock: true,
      category: 'accessories',
      material: 'brass',
      color: 'brass',
      dimensions: BedroomDimensionsModel(
        width: 90,
        height: 150,
        depth: 8,
        weight: 18,
      ),
      tags: ['mirror', 'accent', 'decor'],
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
