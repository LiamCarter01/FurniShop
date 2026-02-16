import '../models/bedroom_model.dart';

/// Data source contract for bedroom operations.
abstract class BedroomDataSource {
  Future<List<BedroomModel>> getBedrooms();
  Future<BedroomModel> getBedroomById(String id);
  Future<List<BedroomModel>> getBedroomsByCategory(String category);
  Future<List<BedroomModel>> getFeaturedBedrooms();
  Future<List<BedroomModel>> searchBedrooms(String query);
}

/// Mock implementation that returns hardcoded bedroom data.
class MockBedroomDataSource implements BedroomDataSource {
  static const Duration _delay = Duration(milliseconds: 700);

  final List<BedroomModel> _mockBedrooms = [
    const BedroomModel(
      id: 'bedroom-001',
      name: 'Aurora Platform Bed',
      description:
          'Sleek low-profile platform bed with integrated storage drawers and a linen upholstered headboard.',
      price: 1299.99,
      originalPrice: 1499.99,
      imageUrl:
          'https://images.unsplash.com/photo-1505692794400-52a4651c2b38?w=800',
      rating: 4.9,
      reviewCount: 214,
      inStock: true,
      category: 'beds',
      material: 'solid oak',
      color: 'white',
      dimensions: BedroomDimensionsModel(
        width: 210,
        height: 110,
        depth: 215,
        weight: 82,
      ),
      bedSize: 'King',
      isFeatured: true,
      tags: ['storage', 'modern', 'platform'],
    ),
    const BedroomModel(
      id: 'bedroom-002',
      name: 'Luna Upholstered Bed',
      description:
          'Plush velvet bed frame with button-tufted headboard and ambient LED base lighting.',
      price: 1099.99,
      imageUrl:
          'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=800',
      rating: 4.7,
      reviewCount: 178,
      inStock: true,
      category: 'beds',
      material: 'velvet',
      color: 'slate blue',
      dimensions: BedroomDimensionsModel(
        width: 200,
        height: 120,
        depth: 210,
        weight: 68,
      ),
      bedSize: 'Queen',
      isFeatured: true,
      tags: ['upholstered', 'luxury', 'lighting'],
    ),
    const BedroomModel(
      id: 'bedroom-003',
      name: 'Marisol Storage Bed',
      description:
          'Metal frame with hidden drawers beneath the mattress deck for seasonal bedding and linens.',
      price: 1499.99,
      originalPrice: 1699.99,
      imageUrl:
          'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800',
      rating: 4.8,
      reviewCount: 203,
      inStock: true,
      category: 'storage',
      material: 'powder-coated steel',
      color: 'graphite',
      dimensions: BedroomDimensionsModel(
        width: 220,
        height: 115,
        depth: 230,
        weight: 90,
      ),
      bedSize: 'King',
      isFeatured: true,
      tags: ['storage', 'durable', 'high capacity'],
    ),
    const BedroomModel(
      id: 'bedroom-004',
      name: 'Sierra Nightstand Set',
      description:
          'Set of two floating nightstands with soft-close drawers and integrated wireless charging.',
      price: 499.99,
      imageUrl:
          'https://images.unsplash.com/photo-1600587606212-3c3f1d8d183d?w=800',
      rating: 4.6,
      reviewCount: 142,
      inStock: true,
      category: 'accessories',
      material: 'walnut veneer',
      color: 'espresso',
      dimensions: BedroomDimensionsModel(
        width: 45,
        height: 50,
        depth: 40,
        weight: 18,
      ),
      bedSize: 'N/A',
      isFeatured: false,
      tags: ['nightstand', 'wireless charge', 'floating'],
    ),
    const BedroomModel(
      id: 'bedroom-005',
      name: 'Solstice Dresser',
      description:
          'Wide six-drawer dresser with matte hardware and a floating base for a contemporary look.',
      price: 999.99,
      imageUrl:
          'https://images.unsplash.com/photo-1493666438817-866a91353ca9?w=800',
      rating: 4.5,
      reviewCount: 129,
      inStock: true,
      category: 'storage',
      material: 'veneer',
      color: 'natural oak',
      dimensions: BedroomDimensionsModel(
        width: 170,
        height: 100,
        depth: 50,
        weight: 74,
      ),
      bedSize: 'N/A',
      isFeatured: false,
      tags: ['dresser', 'scandinavian', 'spacious'],
    ),
    const BedroomModel(
      id: 'bedroom-006',
      name: 'Nimbus Mattress',
      description:
          'Hybrid mattress with gel memory foam, breathable coil system, and pressure relief zones.',
      price: 899.99,
      originalPrice: 1099.99,
      imageUrl:
          'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?w=800',
      rating: 4.9,
      reviewCount: 311,
      inStock: true,
      category: 'mattresses',
      material: 'foam & coils',
      color: 'white',
      dimensions: BedroomDimensionsModel(
        width: 200,
        height: 40,
        depth: 210,
        weight: 55,
      ),
      bedSize: 'Queen',
      isFeatured: true,
      tags: ['mattress', 'hybrid', 'cooling'],
    ),
    const BedroomModel(
      id: 'bedroom-007',
      name: 'Harbor Bedroom Bench',
      description:
          'Bench with storage shelf, upholstered seat, and brass alloy legs ideal for reading corners.',
      price: 299.99,
      imageUrl:
          'https://images.unsplash.com/photo-1470246973918-29a93221c455?w=800',
      rating: 4.4,
      reviewCount: 87,
      inStock: true,
      category: 'accessories',
      material: 'linen & brass',
      color: 'sand',
      dimensions: BedroomDimensionsModel(
        width: 160,
        height: 50,
        depth: 45,
        weight: 23,
      ),
      bedSize: 'N/A',
      isFeatured: false,
      tags: ['bench', 'entryway', 'storage'],
    ),
    const BedroomModel(
      id: 'bedroom-008',
      name: 'Cala Vanity',
      description:
          'Oval mirror vanity with LED lighting, tempered glass top, and minimalist drawer storage.',
      price: 749.99,
      imageUrl:
          'https://images.unsplash.com/photo-1493666438817-866a91353ca9?w=800',
      rating: 4.6,
      reviewCount: 102,
      inStock: true,
      category: 'decor',
      material: 'glass',
      color: 'rose gold',
      dimensions: BedroomDimensionsModel(
        width: 120,
        height: 180,
        depth: 45,
        weight: 37,
      ),
      bedSize: 'N/A',
      isFeatured: false,
      tags: ['vanity', 'lighting', 'mirror'],
    ),
    const BedroomModel(
      id: 'bedroom-009',
      name: 'Willow Accent Mirror',
      description:
          'Full-length arched mirror with rattan frame that instantly enlarges smaller bedrooms.',
      price: 289.99,
      imageUrl:
          'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800',
      rating: 4.3,
      reviewCount: 64,
      inStock: true,
      category: 'decor',
      material: 'rattan',
      color: 'natural',
      dimensions: BedroomDimensionsModel(
        width: 80,
        height: 180,
        depth: 5,
        weight: 21,
      ),
      bedSize: 'N/A',
      isFeatured: false,
      tags: ['mirror', 'boho', 'full-length'],
    ),
    const BedroomModel(
      id: 'bedroom-010',
      name: 'Orion Canopy Bed',
      description:
          'Tall canopy bed with sheer drapes, matte black frame, and integrated reading lamps.',
      price: 1899.99,
      imageUrl:
          'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=800',
      rating: 4.8,
      reviewCount: 260,
      inStock: false,
      category: 'beds',
      material: 'iron',
      color: 'black',
      dimensions: BedroomDimensionsModel(
        width: 220,
        height: 220,
        depth: 230,
        weight: 120,
      ),
      bedSize: 'King',
      isFeatured: true,
      tags: ['canopy', 'dramatic', 'luxury'],
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
          (item) => item.category.toLowerCase() == category.toLowerCase(),
        )
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

    return _mockBedrooms.where((bedroom) {
      return bedroom.name.toLowerCase().contains(lowerQuery) ||
          bedroom.description.toLowerCase().contains(lowerQuery) ||
          bedroom.category.toLowerCase().contains(lowerQuery) ||
          bedroom.tags.any((tag) => tag.toLowerCase().contains(lowerQuery));
    }).toList();
  }
}
