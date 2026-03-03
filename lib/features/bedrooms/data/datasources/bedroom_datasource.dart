import '../models/bedroom_model.dart';

/// Contract for bedroom remote/local data operations.
abstract class BedroomDataSource {
  /// Fetch all bedrooms.
  Future<List<BedroomModel>> getBedrooms();

  /// Fetch a bedroom by ID.
  Future<BedroomModel> getBedroomById(String id);

  /// Fetch bedrooms filtered by category.
  Future<List<BedroomModel>> getBedroomsByCategory(String category);

  /// Fetch featured bedrooms.
  Future<List<BedroomModel>> getFeaturedBedrooms();

  /// Search bedrooms by query string.
  Future<List<BedroomModel>> searchBedrooms(String query);
}

/// Mock implementation of [BedroomDataSource] for development.
class MockBedroomDataSource implements BedroomDataSource {
  static const Duration _delay = Duration(milliseconds: 700);

  final List<BedroomModel> _mockBedrooms = [
    const BedroomModel(
      id: 'bedroom-001',
      name: 'Solstice Loft Bed',
      description:
          'Single loft bed with integrated desk and storage, crafted for modern apartments.',
      price: 1199.00,
      originalPrice: 1399.00,
      imageUrl:
          'https://images.unsplash.com/photo-1505691938895-1758d7feb511?w=800',
      rating: 4.9,
      reviewCount: 312,
      inStock: true,
      category: 'beds',
      style: 'modern',
      material: 'metal',
      color: 'matte black',
      dimensions: BedroomDimensionsModel(
        width: 210,
        height: 190,
        depth: 110,
        weight: 70,
      ),
      isFeatured: true,
      tags: ['loft', 'storage', 'multi-functional', 'study'],
    ),
    const BedroomModel(
      id: 'bedroom-002',
      name: 'Alder Heritage Platform Bed',
      description:
          'Solid alder wood platform bed with floating nightstands and soft-touch finish.',
      price: 1899.99,
      imageUrl:
          'https://images.unsplash.com/photo-1524758631624-e2822e304c36?w=800',
      rating: 4.7,
      reviewCount: 188,
      inStock: true,
      category: 'beds',
      style: 'classic',
      material: 'wood',
      color: 'honey oak',
      dimensions: BedroomDimensionsModel(
        width: 210,
        height: 95,
        depth: 220,
        weight: 110,
      ),
      isFeatured: true,
      tags: ['platform', 'wood', 'nightstand'],
    ),
    const BedroomModel(
      id: 'bedroom-003',
      name: 'Cloud Nine Upholstered Bed',
      description:
          'Wingback upholstered bed with tufted headboard, perfect for luxury retreats.',
      price: 1749.00,
      originalPrice: 1949.00,
      imageUrl:
          'https://images.unsplash.com/photo-1483473055090-c402f143b8dd?w=800',
      rating: 4.8,
      reviewCount: 204,
      inStock: true,
      category: 'beds',
      style: 'luxury',
      material: 'fabric',
      color: 'stone',
      dimensions: BedroomDimensionsModel(
        width: 220,
        height: 140,
        depth: 220,
        weight: 95,
      ),
      isFeatured: false,
      tags: ['upholstered', 'tufted', 'headboard'],
    ),
    const BedroomModel(
      id: 'bedroom-004',
      name: 'Granite Mirrored Dresser',
      description:
          'Six-drawer mirrored dresser with soft-close glides and integrated lighting.',
      price: 999.99,
      imageUrl:
          'https://images.unsplash.com/photo-1493666438817-866a91353ca9?w=800',
      rating: 4.5,
      reviewCount: 142,
      inStock: true,
      category: 'storage',
      style: 'glam',
      material: 'glass',
      color: 'silver',
      dimensions: BedroomDimensionsModel(
        width: 160,
        height: 90,
        depth: 50,
        weight: 60,
      ),
      tags: ['dresser', 'mirrored', 'lighting'],
    ),
    const BedroomModel(
      id: 'bedroom-005',
      name: 'Maple Wardrobe Armoire',
      description:
          'Full-height wardrobe with adjustable shelves, hanging rod, and sleek hardware.',
      price: 1299.00,
      originalPrice: 1499.00,
      imageUrl:
          'https://images.unsplash.com/photo-1519710164239-da123dc03ef4?w=800',
      rating: 4.6,
      reviewCount: 157,
      inStock: true,
      category: 'storage',
      style: 'scandinavian',
      material: 'wood',
      color: 'natural maple',
      dimensions: BedroomDimensionsModel(
        width: 180,
        height: 210,
        depth: 65,
        weight: 140,
      ),
      tags: ['wardrobe', 'armoire', 'storage'],
    ),
    const BedroomModel(
      id: 'bedroom-006',
      name: 'Luna Floating Nightstand',
      description:
          'Floating nightstand with matte surface and hidden drawer for minimalist bedrooms.',
      price: 249.99,
      imageUrl:
          'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=800',
      rating: 4.4,
      reviewCount: 103,
      inStock: true,
      category: 'storage',
      style: 'minimalist',
      material: 'metal',
      color: 'cloud white',
      dimensions: BedroomDimensionsModel(
        width: 65,
        height: 45,
        depth: 40,
        weight: 12,
      ),
      tags: ['floating', 'nightstand', 'hidden drawer'],
    ),
    const BedroomModel(
      id: 'bedroom-007',
      name: 'Aura Glass Pendant',
      description:
          'Glass pendant lighting with adjustable height and soft amber glow for bedside ambiance.',
      price: 189.99,
      imageUrl:
          'https://images.unsplash.com/photo-1493666438817-866a91353ca9?w=800',
      rating: 4.9,
      reviewCount: 78,
      inStock: true,
      category: 'lighting',
      style: 'contemporary',
      material: 'glass',
      color: 'amber',
      dimensions: BedroomDimensionsModel(
        width: 25,
        height: 100,
        depth: 25,
        weight: 5,
      ),
      tags: ['lighting', 'pendant', 'ambiance'],
    ),
    const BedroomModel(
      id: 'bedroom-008',
      name: 'Sierra Accent Bench',
      description:
          'Upholstered bench with walnut legs designed for the foot of your bed.',
      price: 399.00,
      imageUrl:
          'https://images.unsplash.com/photo-1449844908441-8829872d2607?w=800',
      rating: 4.6,
      reviewCount: 90,
      inStock: true,
      category: 'decor',
      style: 'modern',
      material: 'fabric',
      color: 'charcoal',
      dimensions: BedroomDimensionsModel(
        width: 160,
        height: 45,
        depth: 45,
        weight: 22,
      ),
      tags: ['bench', 'accent', 'fabric'],
    ),
    const BedroomModel(
      id: 'bedroom-009',
      name: 'Nobu Textured Rug',
      description:
          'Handwoven rug with tonal pattern that anchors the bedroom and feels soft underfoot.',
      price: 229.00,
      imageUrl:
          'https://images.unsplash.com/photo-1505691635128-9f52bec2db8c?w=800',
      rating: 4.5,
      reviewCount: 65,
      inStock: true,
      category: 'decor',
      style: 'bohemian',
      material: 'wool',
      color: 'sand',
      dimensions: BedroomDimensionsModel(
        width: 200,
        height: 0.5,
        depth: 140,
        weight: 10,
      ),
      tags: ['rug', 'handwoven', 'textured'],
    ),
    const BedroomModel(
      id: 'bedroom-010',
      name: 'Verdant Green Planter',
      description: 'Ceramic planter set with greenery already planted.',
      price: 119.00,
      imageUrl:
          'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=800',
      rating: 4.7,
      reviewCount: 54,
      inStock: true,
      category: 'decor',
      style: 'biophilic',
      material: 'ceramic',
      color: 'sage',
      dimensions: BedroomDimensionsModel(
        width: 30,
        height: 45,
        depth: 30,
        weight: 8,
      ),
      tags: ['planter', 'greenery', 'decor'],
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
        .where((bedroom) =>
            bedroom.category.toLowerCase() == category.toLowerCase())
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
          bedroom.style.toLowerCase().contains(lowerQuery) ||
          bedroom.tags.any((tag) => tag.toLowerCase().contains(lowerQuery));
    }).toList();
  }
}