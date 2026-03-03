import '../models/bedroom_model.dart';

/// Data source contract for bedroom operations.
abstract class BedroomDataSource {
  /// Fetches every bedroom product.
  Future<List<BedroomModel>> getBedrooms();

  /// Fetches a bedroom by its identifier.
  Future<BedroomModel> getBedroomById(String id);

  /// Fetches bedrooms filtered by [category].
  Future<List<BedroomModel>> getBedroomsByCategory(String category);

  /// Fetches bedrooms marked as featured.
  Future<List<BedroomModel>> getFeaturedBedrooms();

  /// Searches bedrooms matching [query].
  Future<List<BedroomModel>> searchBedrooms(String query);
}

/// Mock implementation returning in-memory bedroom data.
class MockBedroomDataSource implements BedroomDataSource {
  static const Duration _delay = Duration(milliseconds: 800);

  final List<BedroomModel> _mockBedrooms = const [
    BedroomModel(
      id: 'bedroom-001',
      name: 'Urban Loft Queen Bed',
      description:
          'Charcoal upholstered queen platform bed with integrated ambient lighting and hidden USB outlets.',
      price: 1299.00,
      originalPrice: 1499.00,
      imageUrl: 'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=600',
      rating: 4.9,
      reviewCount: 412,
      inStock: true,
      category: 'beds',
      material: 'upholstered wood',
      color: 'charcoal',
      dimensions: BedroomDimensionsModel(
        width: 220,
        height: 120,
        depth: 210,
        weight: 65,
      ),
      isFeatured: true,
      tags: ['queen', 'modern', 'ambient', 'smart'],
      bedSize: 'queen',
      designStyle: 'industrial',
    ),
    BedroomModel(
      id: 'bedroom-002',
      name: 'Coastal Retreat King Bed',
      description:
          'Whitewashed solid wood king frame with floating nightstands and breezy linen canopy.',
      price: 1899.50,
      imageUrl: 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=600',
      rating: 4.7,
      reviewCount: 321,
      inStock: true,
      category: 'beds',
      material: 'solid wood',
      color: 'white',
      dimensions: BedroomDimensionsModel(
        width: 240,
        height: 150,
        depth: 220,
        weight: 80,
      ),
      isFeatured: true,
      tags: ['king', 'coastal', 'canopy', 'linen'],
      bedSize: 'king',
      designStyle: 'coastal',
    ),
    BedroomModel(
      id: 'bedroom-003',
      name: 'Mid-Century Storage Bed',
      description:
          'Walnut veneer bed with integrated drawers and retro brass hardware for studio living.',
      price: 1149.99,
      originalPrice: 1299.99,
      imageUrl: 'https://images.unsplash.com/photo-1493666438817-866a91353ca9?w=600',
      rating: 4.6,
      reviewCount: 287,
      inStock: true,
      category: 'storage',
      material: 'veneer',
      color: 'walnut',
      dimensions: BedroomDimensionsModel(
        width: 210,
        height: 110,
        depth: 205,
        weight: 58,
      ),
      isFeatured: false,
      tags: ['storage', 'mid-century', 'drawers'],
      bedSize: 'queen',
      designStyle: 'mid-century',
    ),
    BedroomModel(
      id: 'bedroom-004',
      name: 'Scandinavian Platform Ensemble',
      description:
          'Minimalist platform bed, floating dresser, and matte pendant lighting curated for calm mornings.',
      price: 999.00,
      imageUrl: 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=600',
      rating: 4.5,
      reviewCount: 198,
      inStock: true,
      category: 'sets',
      material: 'ash wood',
      color: 'natural',
      dimensions: BedroomDimensionsModel(
        width: 205,
        height: 95,
        depth: 200,
        weight: 52,
      ),
      isFeatured: false,
      tags: ['scandinavian', 'platform', 'ensemble'],
      bedSize: 'queen',
      designStyle: 'scandinavian',
    ),
    BedroomModel(
      id: 'bedroom-005',
      name: 'Classic Canopy Bed',
      description:
          'Ornate metal canopy with velvet drapes, suitable for luxury bedrooms or boutique hotels.',
      price: 1599.00,
      originalPrice: 1799.00,
      imageUrl: 'https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=600',
      rating: 4.8,
      reviewCount: 247,
      inStock: true,
      category: 'beds',
      material: 'wrought iron',
      color: 'midnight',
      dimensions: BedroomDimensionsModel(
        width: 230,
        height: 210,
        depth: 220,
        weight: 72,
      ),
      isFeatured: true,
      tags: ['canopy', 'luxury', 'velvet'],
      bedSize: 'king',
      designStyle: 'classic',
    ),
    BedroomModel(
      id: 'bedroom-006',
      name: 'Minimalist Daybed',
      description:
          'Convertible daybed with hidden trundle, perfect for compact guest rooms or studios.',
      price: 849.99,
      imageUrl: 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=600',
      rating: 4.4,
      reviewCount: 166,
      inStock: true,
      category: 'multi-use',
      material: 'metal',
      color: 'matte black',
      dimensions: BedroomDimensionsModel(
        width: 180,
        height: 90,
        depth: 115,
        weight: 36,
      ),
      isFeatured: false,
      tags: ['daybed', 'guest', 'trundle'],
      bedSize: 'twin',
      designStyle: 'minimalist',
    ),
    BedroomModel(
      id: 'bedroom-007',
      name: 'Kids Adventure Bunk Bed',
      description:
          'Playful bunk bed with slide, built-in storage, and glow-in-the-dark decals to spark creativity.',
      price: 1299.99,
      imageUrl: 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=600',
      rating: 4.3,
      reviewCount: 412,
      inStock: true,
      category: 'kids',
      material: 'painted pine',
      color: 'blue',
      dimensions: BedroomDimensionsModel(
        width: 210,
        height: 180,
        depth: 140,
        weight: 58,
      ),
      isFeatured: false,
      tags: ['bunk', 'kids', 'slide'],
      bedSize: 'twin',
      designStyle: 'playful',
    ),
    BedroomModel(
      id: 'bedroom-008',
      name: 'Luxury Upholstered Haven',
      description:
          'Plush tufted headboard, silk-blend bedding, and LED reading lights for upscale bedrooms.',
      price: 2199.00,
      originalPrice: 2499.00,
      imageUrl: 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=600',
      rating: 4.9,
      reviewCount: 512,
      inStock: true,
      category: 'luxury',
      material: 'velvet',
      color: 'emerald',
      dimensions: BedroomDimensionsModel(
        width: 230,
        height: 160,
        depth: 220,
        weight: 74,
      ),
      isFeatured: true,
      tags: ['upholstered', 'luxury', 'tufted'],
      bedSize: 'king',
      designStyle: 'glam',
    ),
    BedroomModel(
      id: 'bedroom-009',
      name: 'Modern Storage Suite',
      description:
          'Platform bed with wireless charging nightstands and modular shelving for contemporary lofts.',
      price: 1650.00,
      imageUrl: 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=600',
      rating: 4.7,
      reviewCount: 289,
      inStock: true,
      category: 'storage',
      material: 'laminate',
      color: 'ash gray',
      dimensions: BedroomDimensionsModel(
        width: 220,
        height: 120,
        depth: 215,
        weight: 68,
      ),
      isFeatured: true,
      tags: ['storage', 'modern', 'wireless'],
      bedSize: 'king',
      designStyle: 'modern',
    ),
    BedroomModel(
      id: 'bedroom-010',
      name: 'Boho Rattan Bed',
      description:
          'Handwoven rattan bed frame paired with macramé shelving and matte brass accents for eclectic interiors.',
      price: 1099.00,
      imageUrl: 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=600',
      rating: 4.6,
      reviewCount: 202,
      inStock: true,
      category: 'accent',
      material: 'rattan',
      color: 'honey',
      dimensions: BedroomDimensionsModel(
        width: 210,
        height: 140,
        depth: 205,
        weight: 54,
      ),
      isFeatured: false,
      tags: ['boho', 'rattan', 'handmade'],
      bedSize: 'queen',
      designStyle: 'boho',
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
