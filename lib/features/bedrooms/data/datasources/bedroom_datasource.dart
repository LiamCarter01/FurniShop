import '../models/bedroom_model.dart';

/// Data source interface for bedroom API operations.
///
/// Define the contract between the data and domain layers.
abstract class BedroomDataSource {
  Future<List<BedroomModel>> getBedrooms();
  Future<BedroomModel> getBedroomById(String id);
  Future<List<BedroomModel>> getBedroomsByCategory(String category);
  Future<List<BedroomModel>> getFeaturedBedrooms();
  Future<List<BedroomModel>> searchBedrooms(String query);
}

/// Mock implementation of [BedroomDataSource] returning hardcoded data.
class MockBedroomDataSource implements BedroomDataSource {
  static const Duration _delay = Duration(milliseconds: 800);

  final List<BedroomModel> _mockBedrooms = [
    const BedroomModel(
      id: 'bedroom-001',
      name: 'Midnight Walnut Bed Frame',
      description:
          'Solid walnut bed frame with a padded headboard and under-bed lighting.',
      price: 1499.99,
      originalPrice: 1899.99,
      imageUrl:
          'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=400',
      rating: 4.8,
      reviewCount: 230,
      inStock: true,
      category: 'bed_frame',
      material: 'wood',
      color: 'walnut',
      dimensions: BedroomDimensionsModel(
        width: 210,
        height: 120,
        depth: 220,
        weight: 85,
      ),
      isFeatured: true,
      tags: ['luxury', 'modern', 'lighting'],
    ),
    const BedroomModel(
      id: 'bedroom-002',
      name: 'Natural Oak Nightstand',
      description:
          'Floating nightstand with oak veneer, soft-close drawer, and wireless charging pad.',
      price: 249.99,
      imageUrl:
          'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=400',
      rating: 4.6,
      reviewCount: 112,
      inStock: true,
      category: 'nightstand',
      material: 'wood',
      color: 'oak',
      dimensions: BedroomDimensionsModel(
        width: 55,
        height: 60,
        depth: 40,
        weight: 18,
      ),
      isFeatured: true,
      tags: ['floating', 'charging', 'oak'],
    ),
    const BedroomModel(
      id: 'bedroom-003',
      name: 'Chalet Dresser',
      description:
          'Wide linen-drawer dresser with bronze hardware and a durable matte finish.',
      price: 899.99,
      originalPrice: 999.99,
      imageUrl:
          'https://images.unsplash.com/photo-1549187774-b4e9b0445b2c?w=400',
      rating: 4.5,
      reviewCount: 89,
      inStock: true,
      category: 'dresser',
      material: 'wood',
      color: 'white',
      dimensions: BedroomDimensionsModel(
        width: 160,
        height: 90,
        depth: 50,
        weight: 65,
      ),
      isFeatured: false,
      tags: ['matte', 'bronze', 'storage'],
    ),
    const BedroomModel(
      id: 'bedroom-004',
      name: 'Luxe Linen Mattress',
      description:
          'Hybrid mattress with responsive coils, gel memory foam, and breathable cover.',
      price: 1299.99,
      originalPrice: 1799.99,
      imageUrl:
          'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=401',
      rating: 4.9,
      reviewCount: 412,
      inStock: true,
      category: 'mattress',
      material: 'foam',
      color: 'beige',
      dimensions: BedroomDimensionsModel(
        width: 180,
        height: 35,
        depth: 200,
        weight: 45,
      ),
      isFeatured: true,
      tags: ['hybrid', 'cooling', 'luxury'],
    ),
    const BedroomModel(
      id: 'bedroom-005',
      name: 'Velvet Tufted Bench',
      description:
          'Plush bench with tufted velvet upholstery and brass legs for bedroom seating.',
      price: 399.99,
      imageUrl:
          'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=401',
      rating: 4.4,
      reviewCount: 68,
      inStock: true,
      category: 'bench',
      material: 'velvet',
      color: 'emerald',
      dimensions: BedroomDimensionsModel(
        width: 140,
        height: 50,
        depth: 45,
        weight: 25,
      ),
      isFeatured: false,
      tags: ['velvet', 'seating', 'brass'],
    ),
    const BedroomModel(
      id: 'bedroom-006',
      name: 'Canvas Storage Ottoman',
      description:
          'Multi-purpose ottoman with hidden storage and water-resistant canvas cover.',
      price: 279.99,
      imageUrl:
          'https://images.unsplash.com/photo-1493666438817-866a91353ca9?w=400',
      rating: 4.3,
      reviewCount: 44,
      inStock: true,
      category: 'ottoman',
      material: 'canvas',
      color: 'sand',
      dimensions: BedroomDimensionsModel(
        width: 120,
        height: 45,
        depth: 50,
        weight: 30,
      ),
      isFeatured: false,
      tags: ['storage', 'canvas', 'versatile'],
    ),
    const BedroomModel(
      id: 'bedroom-007',
      name: 'Nordic Floor Lamp',
      description:
          'Adjustable floor lamp with brass stem and frosted glass shade for ambient lighting.',
      price: 199.99,
      imageUrl:
          'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=402',
      rating: 4.7,
      reviewCount: 149,
      inStock: true,
      category: 'lighting',
      material: 'metal',
      color: 'brass',
      dimensions: BedroomDimensionsModel(
        width: 40,
        height: 180,
        depth: 40,
        weight: 10,
      ),
      isFeatured: true,
      tags: ['ambient', 'brass', 'adjustable'],
    ),
    const BedroomModel(
      id: 'bedroom-008',
      name: 'Serene Wall Mirror',
      description:
          'Oversized round mirror with beveled edge and integrated LED halo.',
      price: 249.99,
      originalPrice: 299.99,
      imageUrl:
          'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=402',
      rating: 4.6,
      reviewCount: 87,
      inStock: true,
      category: 'mirror',
      material: 'glass',
      color: 'silver',
      dimensions: BedroomDimensionsModel(
        width: 110,
        height: 110,
        depth: 5,
        weight: 15,
      ),
      isFeatured: false,
      tags: ['mirror', 'lighting', 'decor'],
    ),
    const BedroomModel(
      id: 'bedroom-009',
      name: 'Breeze Blackout Curtains',
      description:
          'Thermal blackout curtains with magnetic tiebacks engineered for bedrooms.',
      price: 189.99,
      imageUrl:
          'https://images.unsplash.com/photo-1493666438817-866a91353ca9?w=401',
      rating: 4.5,
      reviewCount: 94,
      inStock: true,
      category: 'textiles',
      material: 'polyester',
      color: 'charcoal',
      dimensions: BedroomDimensionsModel(
        width: 250,
        height: 280,
        depth: 0,
        weight: 10,
      ),
      isFeatured: false,
      tags: ['blackout', 'thermal', 'textiles'],
    ),
    const BedroomModel(
      id: 'bedroom-010',
      name: 'Cloud Comfort Bedding Set',
      description:
          '5-piece bedding set with breathable cotton sateen and alpaca throw.',
      price: 259.99,
      originalPrice: 319.99,
      imageUrl:
          'https://images.unsplash.com/photo-1549187774-b4e9b0445b2c?w=401',
      rating: 4.9,
      reviewCount: 240,
      inStock: true,
      category: 'bedding',
      material: 'cotton',
      color: 'white',
      dimensions: BedroomDimensionsModel(
        width: 200,
        height: 20,
        depth: 220,
        weight: 12,
      ),
      isFeatured: true,
      tags: ['bedding', 'cotton', 'luxury'],
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
        .where((bedroom) => bedroom.category == category)
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
          bedroom.tags.any((tag) => tag.toLowerCase().contains(lowerQuery));
    }).toList();
  }
}
