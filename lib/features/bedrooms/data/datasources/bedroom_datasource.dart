import '../models/bedroom_model.dart';

/// Data source interface for bedroom operations.
///
/// Mirrors the chairs data source contract so the data layer remains
/// consistent across features.
abstract class BedroomDataSource {
  Future<List<BedroomModel>> getBedrooms();
  Future<BedroomModel> getBedroomById(String id);
  Future<List<BedroomModel>> getBedroomsByCategory(String category);
  Future<List<BedroomModel>> getFeaturedBedrooms();
  Future<List<BedroomModel>> searchBedrooms(String query);
}

/// Mock implementation of [BedroomDataSource] for development.
class MockBedroomDataSource implements BedroomDataSource {
  static const Duration _delay = Duration(milliseconds: 800);

  final List<BedroomModel> _mockBedrooms = const [
    BedroomModel(
      id: 'bedroom-001',
      name: 'Sierra Panel Bed',
      description:
          'Solid oak panel bed with contoured headboard and under-bed storage drawers.',
      price: 1299.0,
      originalPrice: 1499.0,
      imageUrl: 'https://images.unsplash.com/photo-1505691938895-1758d7feb511?w=800',
      rating: 4.9,
      reviewCount: 342,
      inStock: true,
      category: 'bed',
      material: 'oak wood',
      color: 'natural',
      dimensions: BedroomDimensionsModel(
        width: 160,
        height: 120,
        depth: 220,
        weight: 92,
      ),
      isFeatured: true,
      tags: ['panel', 'storage', 'natural'],
    ),
    BedroomModel(
      id: 'bedroom-002',
      name: 'Luna Nightstand',
      description:
          'Matte black nightstand with floating drawer and brass hardware.',
      price: 249.0,
      imageUrl: 'https://images.unsplash.com/photo-1595526114035-4b1e3c8893b6?w=800',
      rating: 4.5,
      reviewCount: 187,
      inStock: true,
      category: 'nightstand',
      material: 'veneer and metal',
      color: 'black',
      dimensions: BedroomDimensionsModel(
        width: 45,
        height: 60,
        depth: 40,
        weight: 18,
      ),
      tags: ['minimal', 'floating', 'matte'],
    ),
    BedroomModel(
      id: 'bedroom-003',
      name: 'Harbor Platform Bed',
      description:
          'Low-profile platform bed in smoked walnut with tapered legs.',
      price: 899.0,
      originalPrice: 1049.0,
      imageUrl: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc470?w=800',
      rating: 4.6,
      reviewCount: 198,
      inStock: true,
      category: 'bed',
      material: 'walnut veneer',
      color: 'smoked walnut',
      dimensions: BedroomDimensionsModel(
        width: 155,
        height: 95,
        depth: 210,
        weight: 78,
      ),
      isFeatured: true,
      tags: ['platform', 'walnut', 'modern'],
    ),
    BedroomModel(
      id: 'bedroom-004',
      name: 'Atlas Four-Drawer Dresser',
      description: 'Textured linen-painted dresser with soft-close drawers.',
      price: 749.0,
      imageUrl: 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=800',
      rating: 4.4,
      reviewCount: 93,
      inStock: true,
      category: 'storage',
      material: 'solid wood',
      color: 'linen',
      dimensions: BedroomDimensionsModel(
        width: 140,
        height: 100,
        depth: 50,
        weight: 62,
      ),
      tags: ['dresser', 'storage', 'linen'],
    ),
    BedroomModel(
      id: 'bedroom-005',
      name: 'Aster Canopy Bed',
      description:
          'Brushed bronze canopy bed with sheer drapery rods for ambient lighting.',
      price: 1599.0,
      originalPrice: 1899.0,
      imageUrl: 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=800',
      rating: 4.8,
      reviewCount: 211,
      inStock: true,
      category: 'bed',
      material: 'metal',
      color: 'bronze',
      dimensions: BedroomDimensionsModel(
        width: 170,
        height: 190,
        depth: 230,
        weight: 108,
      ),
      isFeatured: true,
      tags: ['canopy', 'bronze', 'luxury'],
    ),
    BedroomModel(
      id: 'bedroom-006',
      name: 'Soma Tall Mirror',
      description: 'Full-length oak mirror with beveled edge and leather strap.',
      price: 199.0,
      imageUrl: 'https://images.unsplash.com/photo-1505691938895-1758d7feb511?w=800',
      rating: 4.3,
      reviewCount: 88,
      inStock: true,
      category: 'accessories',
      material: 'oak',
      color: 'honey',
      dimensions: BedroomDimensionsModel(
        width: 60,
        height: 180,
        depth: 5,
        weight: 22,
      ),
      tags: ['mirror', 'oak', 'full-length'],
    ),
    BedroomModel(
      id: 'bedroom-007',
      name: 'Minto Upholstered Bed',
      description:
          'Soft gray linen bed with tufted headboard and concealed leg support.',
      price: 1199.0,
      imageUrl: 'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=800',
      rating: 4.7,
      reviewCount: 143,
      inStock: true,
      category: 'bed',
      material: 'linen',
      color: 'stone gray',
      dimensions: BedroomDimensionsModel(
        width: 165,
        height: 115,
        depth: 220,
        weight: 86,
      ),
      isFeatured: true,
      tags: ['upholstered', 'tufted', 'linen'],
    ),
    BedroomModel(
      id: 'bedroom-008',
      name: 'Nordic Storage Bench',
      description:
          'Ash wood bench with woven cane seat and hidden storage compartment.',
      price: 349.0,
      imageUrl: 'https://images.unsplash.com/photo-1455885661661-ffdb87e91f5a?w=800',
      rating: 4.2,
      reviewCount: 67,
      inStock: true,
      category: 'storage',
      material: 'ash wood',
      color: 'ash',
      dimensions: BedroomDimensionsModel(
        width: 120,
        height: 45,
        depth: 40,
        weight: 26,
      ),
      tags: ['bench', 'storage', 'scandi'],
    ),
    BedroomModel(
      id: 'bedroom-009',
      name: 'Aurora Bedside Lamp',
      description:
          'Domed ceramic lamp with frosted glass diffuser and brass base.',
      price: 139.0,
      imageUrl: 'https://images.unsplash.com/photo-1470246973918-29a93221c455?w=800',
      rating: 4.1,
      reviewCount: 57,
      inStock: true,
      category: 'lighting',
      material: 'ceramic',
      color: 'off-white',
      dimensions: BedroomDimensionsModel(
        width: 24,
        height: 46,
        depth: 24,
        weight: 4,
      ),
      tags: ['lamp', 'ceramic', 'ambient'],
    ),
    BedroomModel(
      id: 'bedroom-010',
      name: 'Haven Jewelry Armoire',
      description:
          'Tall walnut armoire with velvet-lined drawers and mirrored interior.',
      price: 429.0,
      imageUrl: 'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=800',
      rating: 4.5,
      reviewCount: 102,
      inStock: true,
      category: 'storage',
      material: 'walnut',
      color: 'walnut',
      dimensions: BedroomDimensionsModel(
        width: 50,
        height: 160,
        depth: 40,
        weight: 34,
      ),
      tags: ['armoire', 'jewelry', 'storage'],
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
    return _mockBedrooms.firstWhere((bedroom) => bedroom.id == id);
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
          bedroom.category.toLowerCase().contains(lowerQuery) ||
          bedroom.tags.any((tag) => tag.toLowerCase().contains(lowerQuery));
    }).toList();
  }
}
