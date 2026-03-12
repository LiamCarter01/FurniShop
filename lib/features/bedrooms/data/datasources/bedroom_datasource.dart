import '../models/bedroom_model.dart';

/// Data source interface for bedroom product operations.
abstract class BedroomDataSource {
  /// Fetch all bedrooms.
  Future<List<BedroomModel>> getBedrooms();

  /// Fetch a single bedroom by ID.
  Future<BedroomModel> getBedroomById(String id);

  /// Fetch bedrooms filtered by category.
  Future<List<BedroomModel>> getBedroomsByCategory(String category);

  /// Fetch featured bedroom products.
  Future<List<BedroomModel>> getFeaturedBedrooms();

  /// Search bedrooms by query string.
  Future<List<BedroomModel>> searchBedrooms(String query);
}

/// Mock implementation of [BedroomDataSource] for local development.
class MockBedroomDataSource implements BedroomDataSource {
  /// Simulated network delay to mimic remote requests.
  static const Duration _delay = Duration(milliseconds: 800);

  /// Mock bedroom data using the approved product images.
  final List<BedroomModel> _mockBedrooms = const [
    BedroomModel(
      id: 'bedroom-001',
      name: 'Modern Bedroom Set',
      description:
          'Complete modern bedroom furniture set with platform bed, dresser, and nightstands for a cohesive look.',
      price: 2499.99,
      originalPrice: 2999.99,
      imageUrl:
          'https://images.unsplash.com/photo-1505693314120-0d443867891c?w=800&q=80',
      rating: 4.8,
      reviewCount: 205,
      inStock: true,
      category: 'set',
      material: 'engineered wood',
      color: 'white ash',
      dimensions: BedroomDimensionsModel(
        width: 200,
        height: 120,
        depth: 220,
        weight: 150,
      ),
      isFeatured: true,
      tags: ['set', 'modern', 'bedroom'],
    ),
    BedroomModel(
      id: 'bedroom-002',
      name: 'Platform Bed',
      description:
          'Low-profile platform bed with a floating frame and hidden storage drawers underneath.',
      price: 1099.99,
      originalPrice: 1299.99,
      imageUrl:
          'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=800&q=80',
      rating: 4.6,
      reviewCount: 142,
      inStock: true,
      category: 'bed_frame',
      material: 'solid pine',
      color: 'oak',
      dimensions: BedroomDimensionsModel(
        width: 190,
        height: 110,
        depth: 210,
        weight: 80,
      ),
      isFeatured: true,
      tags: ['platform', 'storage', 'bed frame'],
    ),
    BedroomModel(
      id: 'bedroom-003',
      name: 'Nightstand Duo',
      description:
          'Two-piece nightstand set with soft-close drawers and integrated charging station for bedside essentials.',
      price: 279.99,
      imageUrl:
          'https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=800&q=80',
      rating: 4.4,
      reviewCount: 87,
      inStock: true,
      category: 'storage',
      material: 'fiberboard',
      color: 'charcoal',
      dimensions: BedroomDimensionsModel(
        width: 60,
        height: 70,
        depth: 45,
        weight: 25,
      ),
      tags: ['nightstand', 'charging', 'storage'],
    ),
    BedroomModel(
      id: 'bedroom-004',
      name: 'Six-Drawer Dresser',
      description:
          'Spacious six-drawer dresser with beveled drawer fronts and brass handles to elevate bedroom storage.',
      price: 499.99,
      imageUrl:
          'https://images.unsplash.com/photo-1588046130717-0eb0ccf312f2?w=800&q=80',
      rating: 4.5,
      reviewCount: 120,
      inStock: true,
      category: 'storage',
      material: 'maple wood',
      color: 'honey',
      dimensions: BedroomDimensionsModel(
        width: 150,
        height: 110,
        depth: 55,
        weight: 80,
      ),
      tags: ['dresser', 'storage', 'classic'],
    ),
    BedroomModel(
      id: 'bedroom-005',
      name: 'Sliding Door Wardrobe',
      description:
          'Minimalist wardrobe with mirrored sliding doors and adjustable shelving for customized storage.',
      price: 1199.99,
      imageUrl:
          'https://images.unsplash.com/photo-1595428773083-1e42a8219dbc?w=800&q=80',
      rating: 4.7,
      reviewCount: 95,
      inStock: true,
      category: 'storage',
      material: 'laminated MDF',
      color: 'white',
      dimensions: BedroomDimensionsModel(
        width: 170,
        height: 220,
        depth: 60,
        weight: 180,
      ),
      isFeatured: true,
      tags: ['wardrobe', 'sliding', 'mirrored'],
    ),
    BedroomModel(
      id: 'bedroom-006',
      name: 'Luxury Bedding Kit',
      description:
          'Four-piece bedding kit with sateen sheets, duvet cover, and matching pillow shams for a luxe retreat.',
      price: 349.99,
      imageUrl:
          'https://images.unsplash.com/photo-1505693314120-0d443867891c?w=800&q=80',
      rating: 4.9,
      reviewCount: 312,
      inStock: true,
      category: 'bedding',
      material: 'Egyptian cotton',
      color: 'cloud gray',
      dimensions: BedroomDimensionsModel(
        width: 40,
        height: 10,
        depth: 40,
        weight: 5,
      ),
      tags: ['bedding', 'luxury', 'sateen'],
    ),
    BedroomModel(
      id: 'bedroom-007',
      name: 'Accent Mirror',
      description:
          'Full-length accent mirror with sculpted metal frame for reflecting light and opening up the room.',
      price: 299.99,
      imageUrl:
          'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=800&q=80',
      rating: 4.5,
      reviewCount: 76,
      inStock: true,
      category: 'accessory',
      material: 'brushed steel',
      color: 'brass',
      dimensions: BedroomDimensionsModel(
        width: 80,
        height: 180,
        depth: 10,
        weight: 30,
      ),
      tags: ['mirror', 'lighting', 'accessory'],
    ),
    BedroomModel(
      id: 'bedroom-008',
      name: 'Decorative Storage Bench',
      description:
          'Upholstered bench with hidden storage for linens and a tufted cushion for seating at the foot of the bed.',
      price: 429.99,
      imageUrl:
          'https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=800&q=80',
      rating: 4.3,
      reviewCount: 64,
      inStock: true,
      category: 'seating',
      material: 'velvet',
      color: 'sage',
      dimensions: BedroomDimensionsModel(
        width: 160,
        height: 45,
        depth: 50,
        weight: 22,
      ),
      tags: ['bench', 'storage', 'decor'],
    ),
    BedroomModel(
      id: 'bedroom-009',
      name: 'Bedside Lamp Duo',
      description:
          'Set of two adjustable bedside lamps with matte black finish and warm LED bulbs for layered lighting.',
      price: 149.99,
      imageUrl:
          'https://images.unsplash.com/photo-1588046130717-0eb0ccf312f2?w=800&q=80',
      rating: 4.6,
      reviewCount: 157,
      inStock: true,
      category: 'lighting',
      material: 'metal',
      color: 'black',
      dimensions: BedroomDimensionsModel(
        width: 15,
        height: 45,
        depth: 15,
        weight: 10,
      ),
      tags: ['lighting', 'lamp', 'set'],
    ),
    BedroomModel(
      id: 'bedroom-010',
      name: 'Storage Ottoman',
      description:
          'Textured storage ottoman that doubles as seating and a place to stash blankets or throw pillows.',
      price: 229.99,
      imageUrl:
          'https://images.unsplash.com/photo-1595428773083-1e42a8219dbc?w=800&q=80',
      rating: 4.4,
      reviewCount: 118,
      inStock: true,
      category: 'storage',
      material: 'linen blend',
      color: 'mist',
      dimensions: BedroomDimensionsModel(
        width: 120,
        height: 45,
        depth: 50,
        weight: 35,
      ),
      tags: ['ottoman', 'storage', 'seating'],
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
