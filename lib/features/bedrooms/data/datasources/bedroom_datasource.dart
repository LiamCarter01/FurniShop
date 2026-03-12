import '../models/bedroom_model.dart';

/// Data source contract for bedroom operations.
///
/// Provides a consistent surface for fetching bedroom data.
abstract class BedroomDataSource {
  Future<List<BedroomModel>> getBedrooms();
  Future<BedroomModel> getBedroomById(String id);
  Future<List<BedroomModel>> getBedroomsByCategory(String category);
  Future<List<BedroomModel>> getFeaturedBedrooms();
  Future<List<BedroomModel>> searchBedrooms(String query);
}

/// Mock implementation returning in-memory bedroom data.
///
/// Helps bootstrap the feature before integrating real APIs.
class MockBedroomDataSource implements BedroomDataSource {
  static const Duration _delay = Duration(milliseconds: 800);

  final List<BedroomModel> _mockBedrooms = [
    const BedroomModel(
      id: 'bedroom-001',
      name: 'Scandinavian Oak Bedframe',
      description:
          'A sculpted oak profile with hidden storage drawers and clean angles for Nordic-inspired bedrooms.',
      price: 1299.00,
      originalPrice: 1499.00,
      imageUrl:
          'https://images.unsplash.com/photo-1487014679447-9f8336841d58?w=400',
      rating: 4.8,
      reviewCount: 87,
      inStock: true,
      category: 'bed',
      material: 'oak',
      color: 'natural',
      dimensions: BedroomDimensionsModel(
        width: 210,
        height: 120,
        depth: 220,
        weight: 95,
      ),
      isFeatured: true,
      tags: ['bed', 'storage', 'oak'],
    ),
    const BedroomModel(
      id: 'bedroom-002',
      name: 'Luxe Upholstered Headboard',
      description:
          'Padded velvet headboard with channel stitching and built-in ambient lighting.',
      price: 749.99,
      originalPrice: 899.99,
      imageUrl:
          'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=400',
      rating: 4.6,
      reviewCount: 64,
      inStock: true,
      category: 'bed',
      material: 'velvet',
      color: 'charcoal',
      dimensions: BedroomDimensionsModel(
        width: 190,
        height: 140,
        depth: 20,
        weight: 40,
      ),
      isFeatured: true,
      tags: ['bed', 'headboard', 'velvet'],
    ),
    const BedroomModel(
      id: 'bedroom-003',
      name: 'Nordic Nightstand',
      description:
          'Compact nightstand in ash veneer with dual drawers and soft-close hardware.',
      price: 259.50,
      imageUrl:
          'https://images.unsplash.com/photo-1519710164239-da123dc03ef4?w=400',
      rating: 4.5,
      reviewCount: 52,
      inStock: true,
      category: 'nightstand',
      material: 'ash',
      color: 'white',
      dimensions: BedroomDimensionsModel(
        width: 60,
        height: 55,
        depth: 45,
        weight: 24,
      ),
      tags: ['nightstand', 'storage'],
    ),
    const BedroomModel(
      id: 'bedroom-004',
      name: 'Luxe Mirrored Dresser',
      description:
          'Refined mirrored dresser with six drawers, ideal for glamorous master suites.',
      price: 1199.90,
      originalPrice: 1399.90,
      imageUrl:
          'https://images.unsplash.com/photo-1487014679447-9f8336841d58?w=401',
      rating: 4.4,
      reviewCount: 41,
      inStock: true,
      category: 'dresser',
      material: 'glass',
      color: 'silver',
      dimensions: BedroomDimensionsModel(
        width: 180,
        height: 90,
        depth: 50,
        weight: 80,
      ),
      tags: ['dresser', 'mirrored', 'glam'],
    ),
    const BedroomModel(
      id: 'bedroom-005',
      name: 'Aero 3-Door Wardrobe',
      description:
          'Steel-framed wardrobe with beveled doors, integrated LED light, and adjustable shelves.',
      price: 1575.00,
      imageUrl:
          'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=400',
      rating: 4.3,
      reviewCount: 68,
      inStock: false,
      category: 'wardrobe',
      material: 'steel',
      color: 'matte black',
      dimensions: BedroomDimensionsModel(
        width: 220,
        height: 210,
        depth: 65,
        weight: 110,
      ),
      tags: ['wardrobe', 'storage', 'modern'],
    ),
    const BedroomModel(
      id: 'bedroom-006',
      name: 'Serenity Platform Bed',
      description:
          'All-natural platform bed with tapered legs, low frame, and visible grain detail.',
      price: 1049.00,
      originalPrice: 1249.00,
      imageUrl:
          'https://images.unsplash.com/photo-1505693416388-ac5ce068fe86?w=400',
      rating: 4.7,
      reviewCount: 93,
      inStock: true,
      category: 'bed',
      material: 'hickory',
      color: 'espresso',
      dimensions: BedroomDimensionsModel(
        width: 210,
        height: 65,
        depth: 220,
        weight: 105,
      ),
      tags: ['bed', 'platform', 'hickory'],
    ),
    const BedroomModel(
      id: 'bedroom-007',
      name: 'Echo Floating Vanity',
      description:
          'Wall-mounted vanity with soft-touch drawers, circular mirror, and touch lighting.',
      price: 549.95,
      imageUrl:
          'https://images.unsplash.com/photo-1481277542470-605612bd2d61?w=400',
      rating: 4.2,
      reviewCount: 34,
      inStock: true,
      category: 'vanity',
      material: 'plywood',
      color: 'sage',
      dimensions: BedroomDimensionsModel(
        width: 120,
        height: 70,
        depth: 45,
        weight: 35,
      ),
      tags: ['vanity', 'floating'],
    ),
    const BedroomModel(
      id: 'bedroom-008',
      name: 'Harbor Storage Bench',
      description:
          'Tufted bench with hidden compartment and tapered brass leg caps.',
      price: 379.00,
      imageUrl:
          'https://images.unsplash.com/photo-1505691938895-1758d7feb511?w=400',
      rating: 4.5,
      reviewCount: 29,
      inStock: true,
      category: 'bench',
      material: 'linen',
      color: 'sand',
      dimensions: BedroomDimensionsModel(
        width: 140,
        height: 45,
        depth: 40,
        weight: 28,
      ),
      tags: ['bench', 'storage'],
    ),
    const BedroomModel(
      id: 'bedroom-009',
      name: 'Atlas 6-Drawer Dresser',
      description:
          'Solid walnut dresser with flush drawers and architectural base.',
      price: 995.50,
      imageUrl:
          'https://images.unsplash.com/photo-1487014679447-9f8336841d58?w=402',
      rating: 4.6,
      reviewCount: 55,
      inStock: true,
      category: 'dresser',
      material: 'walnut',
      color: 'chocolate',
      dimensions: BedroomDimensionsModel(
        width: 170,
        height: 95,
        depth: 55,
        weight: 92,
      ),
      tags: ['dresser', 'walnut'],
    ),
    const BedroomModel(
      id: 'bedroom-010',
      name: 'Zen Bedding Ensemble',
      description:
          'Layered bedding set with breathable linen, textured throw pillow set, and plush duvet.',
      price: 289.99,
      imageUrl:
          'https://images.unsplash.com/photo-1449844908441-8829872d2607?w=400',
      rating: 4.9,
      reviewCount: 148,
      inStock: true,
      category: 'bedding',
      material: 'linen',
      color: 'oatmeal',
      dimensions: BedroomDimensionsModel(
        width: 260,
        height: 40,
        depth: 260,
        weight: 12,
      ),
      tags: ['bedding', 'linen', 'ensemble'],
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
    final normalized = category.toLowerCase();
    return _mockBedrooms
        .where((bedroom) => bedroom.category.toLowerCase() == normalized)
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
