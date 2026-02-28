import '../models/bedroom_model.dart';

/// Data source contract for bedroom API operations.
abstract class BedroomDataSource {
  Future<List<BedroomModel>> getBedrooms();

  Future<BedroomModel> getBedroomById(String id);

  Future<List<BedroomModel>> getBedroomsByCategory(String category);

  Future<List<BedroomModel>> getFeaturedBedrooms();

  Future<List<BedroomModel>> searchBedrooms(String query);
}

/// Mock implementation of [BedroomDataSource] for development.
class MockBedroomDataSource implements BedroomDataSource {
  static const Duration _delay = Duration(milliseconds: 600);

  final List<BedroomModel> _mockBedrooms = const [
    BedroomModel(
      id: 'bedroom-001',
      name: 'Haven King Platform Bed',
      description:
          'Floating walnut platform with integrated lighting and a plush upholstered headboard.',
      price: 1899.00,
      originalPrice: 2299.00,
      imageUrl:
          'https://images.unsplash.com/photo-1505691938895-1758d7feb511?w=400',
      rating: 4.8,
      reviewCount: 231,
      inStock: true,
      category: 'bed',
      material: 'walnut',
      color: 'espresso',
      dimensions: BedroomDimensionsModel(
        width: 210,
        height: 120,
        depth: 210,
        weight: 110,
      ),
      isFeatured: true,
      tags: ['platform', 'king', 'lighting'],
    ),
    BedroomModel(
      id: 'bedroom-002',
      name: 'Luna Upholstered Bed',
      description:
          'Cloud-inspired bed with linen upholstery and channel-tufted headboard for cozy retreats.',
      price: 1399.00,
      originalPrice: 1589.00,
      imageUrl:
          'https://images.unsplash.com/photo-1486641318326-93f56face309?w=400',
      rating: 4.7,
      reviewCount: 189,
      inStock: true,
      category: 'bed',
      material: 'linen',
      color: 'sage',
      dimensions: BedroomDimensionsModel(
        width: 190,
        height: 130,
        depth: 210,
        weight: 95,
      ),
      isFeatured: true,
      tags: ['upholstered', 'queen', 'tufted'],
    ),
    BedroomModel(
      id: 'bedroom-003',
      name: 'Astra Storage Nightstand',
      description:
          'Floating nightstand with matte drawer fronts and hidden charging cubby.',
      price: 349.00,
      imageUrl:
          'https://images.unsplash.com/photo-1505691938895-1758d7feb511?w=400',
      rating: 4.6,
      reviewCount: 104,
      inStock: true,
      category: 'nightstand',
      material: 'oak',
      color: 'natural',
      dimensions: BedroomDimensionsModel(
        width: 55,
        height: 60,
        depth: 38,
        weight: 22,
      ),
      isFeatured: false,
      tags: ['floating', 'storage'],
    ),
    BedroomModel(
      id: 'bedroom-004',
      name: 'Nordic 6-Drawer Dresser',
      description:
          'Clean-lined ash dresser with soft-close drawers and beveled edges.',
      price: 999.00,
      originalPrice: 1149.00,
      imageUrl:
          'https://images.unsplash.com/photo-1505691938895-1758d7feb511?w=400',
      rating: 4.5,
      reviewCount: 88,
      inStock: true,
      category: 'dresser',
      material: 'ash',
      color: 'light gray',
      dimensions: BedroomDimensionsModel(
        width: 160,
        height: 100,
        depth: 45,
        weight: 70,
      ),
      isFeatured: true,
      tags: ['drawer', 'scandinavian'],
    ),
    BedroomModel(
      id: 'bedroom-005',
      name: 'Aurora Mirrored Wardrobe',
      description:
          'Three-panel mirrored wardrobe with soft LED lighting and mirrored interior shelving.',
      price: 2149.00,
      imageUrl:
          'https://images.unsplash.com/photo-1505691723518-36a5e01f5b1b?w=400',
      rating: 4.4,
      reviewCount: 176,
      inStock: false,
      category: 'wardrobe',
      material: 'laminate',
      color: 'white',
      dimensions: BedroomDimensionsModel(
        width: 220,
        height: 240,
        depth: 60,
        weight: 140,
      ),
      isFeatured: false,
      tags: ['mirrored', 'wardrobe'],
    ),
    BedroomModel(
      id: 'bedroom-006',
      name: 'Mason Floating Shelf',
      description:
          'Solid wood floating shelf with concealed mounting brackets and a matte finish.',
      price: 179.00,
      imageUrl:
          'https://images.unsplash.com/photo-1505691938895-1758d7feb511?w=400',
      rating: 4.3,
      reviewCount: 67,
      inStock: true,
      category: 'accessory',
      material: 'walnut',
      color: 'brown',
      dimensions: BedroomDimensionsModel(
        width: 120,
        height: 10,
        depth: 20,
        weight: 6,
      ),
      isFeatured: false,
      tags: ['shelf', 'floating', 'walnut'],
    ),
    BedroomModel(
      id: 'bedroom-007',
      name: 'Sierra Tufted Bench',
      description:
          'Hand-stitched velvet bench with brass-finished legs and foam core cushion.',
      price: 449.00,
      originalPrice: 539.00,
      imageUrl:
          'https://images.unsplash.com/photo-1505691723518-36a5e01f5b1b?w=400',
      rating: 4.7,
      reviewCount: 120,
      inStock: true,
      category: 'bench',
      material: 'velvet',
      color: 'blush',
      dimensions: BedroomDimensionsModel(
        width: 140,
        height: 45,
        depth: 50,
        weight: 18,
      ),
      isFeatured: true,
      tags: ['bench', 'accent'],
    ),
    BedroomModel(
      id: 'bedroom-008',
      name: 'Cielo Adjustable Headboard',
      description:
          'Modular headboard with adjustable panels and soft-touch upholstery.',
      price: 649.00,
      imageUrl:
          'https://images.unsplash.com/photo-1505691723518-36a5e01f5b1b?w=400',
      rating: 4.6,
      reviewCount: 98,
      inStock: true,
      category: 'headboard',
      material: 'polyester',
      color: 'charcoal',
      dimensions: BedroomDimensionsModel(
        width: 190,
        height: 120,
        depth: 12,
        weight: 28,
      ),
      isFeatured: false,
      tags: ['headboard', 'adjustable'],
    ),
    BedroomModel(
      id: 'bedroom-009',
      name: 'Solstice Linen Mattress',
      description:
          'Hybrid mattress with cooling gel memory foam and pocketed coils for balanced support.',
      price: 1799.00,
      imageUrl:
          'https://images.unsplash.com/photo-1505691938895-1758d7feb511?w=400',
      rating: 4.9,
      reviewCount: 412,
      inStock: true,
      category: 'mattress',
      material: 'memory foam',
      color: 'ivory',
      dimensions: BedroomDimensionsModel(
        width: 200,
        height: 30,
        depth: 200,
        weight: 65,
      ),
      isFeatured: true,
      tags: ['mattress', 'hybrid', 'cooling'],
    ),
    BedroomModel(
      id: 'bedroom-010',
      name: 'Nova Accent Chest',
      description:
          'Compact accent chest with brass hardware and curved fronts for a gallery-ready look.',
      price: 579.00,
      imageUrl:
          'https://images.unsplash.com/photo-1519710164239-da123dc03ef4?w=400',
      rating: 4.4,
      reviewCount: 77,
      inStock: true,
      category: 'chest',
      material: 'maple',
      color: 'midnight',
      dimensions: BedroomDimensionsModel(
        width: 70,
        height: 100,
        depth: 40,
        weight: 33,
      ),
      isFeatured: false,
      tags: ['accent', 'chest'],
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
          bedroom.tags.any((tag) => tag.toLowerCase().contains(lowerQuery));
    }).toList();
  }
}
