import '../models/bedroom_model.dart';

/// Data source contract for bedroom API operations.
abstract class BedroomDataSource {
  /// Fetches all bedrooms.
  Future<List<BedroomModel>> getBedrooms();

  /// Retrieves a single bedroom by ID.
  Future<BedroomModel> getBedroomById(String id);

  /// Retrieves bedrooms filtered by category.
  Future<List<BedroomModel>> getBedroomsByCategory(String category);

  /// Retrieves bedrooms flagged as featured.
  Future<List<BedroomModel>> getFeaturedBedrooms();

  /// Searches bedrooms by query string.
  Future<List<BedroomModel>> searchBedrooms(String query);
}

/// Mock data source implementation used for development.
class MockBedroomDataSource implements BedroomDataSource {
  /// Simulated network latency.
  static const Duration _delay = Duration(milliseconds: 800);

  /// Mock bedrooms catalog (10 entries) used for the bedrooms feature.
  final List<BedroomModel> _mockBedrooms = [
    const BedroomModel(
      id: 'bedroom-001',
      name: 'Harlow Platform Bed',
      description:
          'Low-profile platform bed with tufted headboard and integrated under-bed storage, crafted from solid oak.',
      price: 1299.99,
      originalPrice: 1499.99,
      imageUrl:
          'https://images.unsplash.com/photo-1505691938895-1758d7feb511?w=400',
      rating: 4.8,
      reviewCount: 214,
      inStock: true,
      category: 'bed',
      material: 'oak',
      color: 'smoked_oak',
      dimensions: BedroomDimensionsModel(
        width: 210,
        height: 130,
        depth: 195,
        weight: 95,
      ),
      isFeatured: true,
      tags: ['bed', 'platform', 'storage'],
    ),
    const BedroomModel(
      id: 'bedroom-002',
      name: 'Eden Upholstered Bed',
      description:
          'Luxe velvet bed frame with high headboard and brass-tipped legs for a boutique hotel ambiance.',
      price: 1099.99,
      originalPrice: 1199.99,
      imageUrl:
          'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=400',
      rating: 4.7,
      reviewCount: 187,
      inStock: true,
      category: 'bed',
      material: 'velvet',
      color: 'emerald',
      dimensions: BedroomDimensionsModel(
        width: 205,
        height: 125,
        depth: 190,
        weight: 88,
      ),
      isFeatured: true,
      tags: ['bed', 'velvet', 'luxury'],
    ),
    const BedroomModel(
      id: 'bedroom-003',
      name: 'Sierra Nightstand',
      description: 'Compact walnut nightstand with two soft-close drawers and USB A+C charging.',
      price: 249.99,
      imageUrl:
          'https://images.unsplash.com/photo-1493666438817-866a91353ca9?w=400',
      rating: 4.4,
      reviewCount: 102,
      inStock: true,
      category: 'nightstand',
      material: 'walnut',
      color: 'walnut',
      dimensions: BedroomDimensionsModel(
        width: 60,
        height: 55,
        depth: 45,
        weight: 18,
      ),
      isFeatured: false,
      tags: ['nightstand', 'walnut', 'storage'],
    ),
    const BedroomModel(
      id: 'bedroom-004',
      name: 'Alderwood Dresser',
      description:
          'Spacious dresser featuring six dovetail drawers, satin brass pulls, and a walnut veneer finish.',
      price: 649.99,
      originalPrice: 749.99,
      imageUrl:
          'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=400',
      rating: 4.6,
      reviewCount: 133,
      inStock: true,
      category: 'dresser',
      material: 'alderwood',
      color: 'natural',
      dimensions: BedroomDimensionsModel(
        width: 180,
        height: 100,
        depth: 55,
        weight: 75,
      ),
      isFeatured: true,
      tags: ['dresser', 'storage', 'alderwood'],
    ),
    const BedroomModel(
      id: 'bedroom-005',
      name: 'Nova Bedroom Bench',
      description: 'Upholstered bench with brushed brass frame perfect for soft layering and seating.',
      price: 199.99,
      imageUrl:
          'https://images.unsplash.com/photo-1616593223412-e53e46d7e5e6?w=400',
      rating: 4.3,
      reviewCount: 58,
      inStock: true,
      category: 'bench',
      material: 'linen',
      color: 'mist',
      dimensions: BedroomDimensionsModel(
        width: 140,
        height: 45,
        depth: 40,
        weight: 12,
      ),
      isFeatured: false,
      tags: ['bench', 'seating', 'linen'],
    ),
    const BedroomModel(
      id: 'bedroom-006',
      name: 'Luna Vanity Set',
      description:
          'Marble-topped vanity table with adjustable mirror and felt-lined drawers for beauty essentials.',
      price: 899.99,
      originalPrice: 999.99,
      imageUrl:
          'https://images.unsplash.com/photo-1505692794400-5ec924f0d6c1?w=400',
      rating: 4.7,
      reviewCount: 110,
      inStock: false,
      category: 'vanity',
      material: 'marble',
      color: 'blush',
      dimensions: BedroomDimensionsModel(
        width: 140,
        height: 80,
        depth: 45,
        weight: 35,
      ),
      isFeatured: true,
      tags: ['vanity', 'mirror', 'marble'],
    ),
    const BedroomModel(
      id: 'bedroom-007',
      name: 'Aurora Wardrobe',
      description:
          'Freestanding wardrobe with mirrored doors, adjustable shelving, and integrated LED strip lighting.',
      price: 1299.99,
      originalPrice: 1499.99,
      imageUrl:
          'https://images.unsplash.com/photo-1519710164239-da123dc03ef4?w=400',
      rating: 4.5,
      reviewCount: 95,
      inStock: true,
      category: 'wardrobe',
      material: 'birch',
      color: 'white',
      dimensions: BedroomDimensionsModel(
        width: 220,
        height: 220,
        depth: 60,
        weight: 110,
      ),
      isFeatured: true,
      tags: ['wardrobe', 'storage', 'mirrored'],
    ),
    const BedroomModel(
      id: 'bedroom-008',
      name: 'Oasis Storage Bed',
      description:
          'King storage bed with six drawers, integrated lighting, and breathable slatted base for airflow.',
      price: 1399.99,
      imageUrl:
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400',
      rating: 4.9,
      reviewCount: 198,
      inStock: true,
      category: 'storage',
      material: 'maple',
      color: 'driftwood',
      dimensions: BedroomDimensionsModel(
        width: 220,
        height: 130,
        depth: 200,
        weight: 110,
      ),
      isFeatured: true,
      tags: ['bed', 'storage', 'drawers'],
    ),
    const BedroomModel(
      id: 'bedroom-009',
      name: 'Nimbus Memory Foam Mattress',
      description: 'Hybrid memory foam mattress with cooling gel layer and zoned support.',
      price: 799.99,
      imageUrl:
          'https://images.unsplash.com/photo-1505693416388-7cbd29ab8d3e?w=400',
      rating: 4.8,
      reviewCount: 241,
      inStock: true,
      category: 'mattress',
      material: 'memory_foam',
      color: 'white',
      dimensions: BedroomDimensionsModel(
        width: 200,
        height: 35,
        depth: 150,
        weight: 35,
      ),
      isFeatured: false,
      tags: ['mattress', 'foam', 'comfort'],
    ),
    const BedroomModel(
      id: 'bedroom-010',
      name: 'Celeste Bedside Lamp',
      description: 'Smoked glass bedside lamp with dimmable LED and marble base.',
      price: 129.99,
      imageUrl:
          'https://images.unsplash.com/photo-1524758631624-e2822e304c36?w=400',
      rating: 4.2,
      reviewCount: 67,
      inStock: true,
      category: 'lighting',
      material: 'glass',
      color: 'smoke',
      dimensions: BedroomDimensionsModel(
        width: 35,
        height: 55,
        depth: 35,
        weight: 6,
      ),
      isFeatured: false,
      tags: ['lighting', 'lamp', 'bedside'],
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
        .where(
          (bedroom) => bedroom.category.toLowerCase() == category.toLowerCase(),
        )
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
