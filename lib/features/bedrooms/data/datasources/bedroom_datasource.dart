import '../models/bedroom_model.dart';

/// Data source interface for bedroom API operations.
///
/// Defines the contract for remote data access.
abstract class BedroomDataSource {
  /// Fetch all bedrooms from API.
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

/// Mock implementation of [BedroomDataSource] for development.
///
/// Returns mock data instead of making real API calls.
class MockBedroomDataSource implements BedroomDataSource {
  /// Simulated network delay.
  static const Duration _delay = Duration(milliseconds: 600);

  /// Mock bedroom product data.
  final List<BedroomModel> _mockBedrooms = const [
    BedroomModel(
      id: 'bedroom-001',
      name: 'Cloud Nine Platform Bed',
      description:
          'Minimalist platform bed with hidden storage compartments and floating profile, crafted from solid oak.',
      price: 1299.99,
      originalPrice: 1599.99,
      imageUrl: 'https://images.unsplash.com/photo-1616628184073-b4e5c0b4e0b4?w=400',
      rating: 4.8,
      reviewCount: 214,
      inStock: true,
      category: 'beds',
      material: 'oak',
      color: 'white',
      dimensions: BedroomDimensionsModel(
        width: 180,
        height: 120,
        depth: 210,
        weight: 85,
      ),
      isFeatured: true,
      tags: ['platform', 'storage', 'floating'],
    ),
    BedroomModel(
      id: 'bedroom-002',
      name: 'Midnight Sculpted Bed',
      description:
          'Charcoal linen upholstered bed with pillowy headboard and brushed brass detailing for a dramatic focal point.',
      price: 1499.0,
      imageUrl: 'https://images.unsplash.com/photo-1616627579185-98280a3db94f?w=400',
      rating: 4.7,
      reviewCount: 188,
      inStock: true,
      category: 'beds',
      material: 'upholstered',
      color: 'charcoal',
      dimensions: BedroomDimensionsModel(
        width: 190,
        height: 135,
        depth: 220,
        weight: 92,
      ),
      isFeatured: true,
      tags: ['upholstered', 'brass', 'luxury'],
    ),
    BedroomModel(
      id: 'bedroom-003',
      name: 'Willow Nightstand',
      description:
          'Two-drawer nightstand with hand-finished walnut veneer and soft-close glides for restless sleepers.',
      price: 299.0,
      imageUrl: 'https://images.unsplash.com/photo-1616627675752-6d2f1ebb0c6b?w=400',
      rating: 4.5,
      reviewCount: 76,
      inStock: true,
      category: 'nightstands',
      material: 'walnut',
      color: 'espresso',
      dimensions: BedroomDimensionsModel(
        width: 60,
        height: 70,
        depth: 40,
        weight: 23,
      ),
      tags: ['nightstand', 'walnut', 'two-drawer'],
    ),
    BedroomModel(
      id: 'bedroom-004',
      name: 'Aurora Dresser',
      description:
          'Dresser with gently curved drawer fronts, smoked glass handles, and concealed jewelry tray for elevated organization.',
      price: 999.0,
      originalPrice: 1199.0,
      imageUrl: 'https://images.unsplash.com/photo-1505691938895-1758d7feb511?w=400',
      rating: 4.6,
      reviewCount: 154,
      inStock: true,
      category: 'dressers',
      material: 'maple',
      color: 'mist',
      dimensions: BedroomDimensionsModel(
        width: 160,
        height: 100,
        depth: 50,
        weight: 68,
      ),
      isFeatured: true,
      tags: ['curved', 'glass', 'jewelry'],
    ),
    BedroomModel(
      id: 'bedroom-005',
      name: 'Cedar Multi-Drawer Dresser',
      description:
          'Nine-drawer cedar dresser with integrated dividers and UV-resistant finish for heirloom storage.',
      price: 1249.0,
      imageUrl: 'https://images.unsplash.com/photo-1616627542484-9c31a6c10d7d?w=400',
      rating: 4.4,
      reviewCount: 64,
      inStock: false,
      category: 'dressers',
      material: 'cedar',
      color: 'natural',
      dimensions: BedroomDimensionsModel(
        width: 170,
        height: 110,
        depth: 55,
        weight: 74,
      ),
      tags: ['cedar', 'storage', 'dividers'],
    ),
    BedroomModel(
      id: 'bedroom-006',
      name: 'Solace Gel Mattress',
      description:
          'Hybrid gel mattress with zoned support coils and breathable knit cover for cool nights.',
      price: 899.99,
      originalPrice: 1049.99,
      imageUrl: 'https://images.unsplash.com/photo-1616627108645-0b6cf1d9c41a?w=400',
      rating: 4.9,
      reviewCount: 360,
      inStock: true,
      category: 'mattresses',
      material: 'foam',
      color: 'white',
      dimensions: BedroomDimensionsModel(
        width: 160,
        height: 28,
        depth: 200,
        weight: 48,
      ),
      isFeatured: true,
      tags: ['gel', 'hybrid', 'cooling'],
    ),
    BedroomModel(
      id: 'bedroom-007',
      name: 'Horizon Storage Bench',
      description:
          'Bench with lift-top storage, upholstered seat, and powder-coated steel legs to anchor the foot of the bed.',
      price: 349.0,
      imageUrl: 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=400',
      rating: 4.3,
      reviewCount: 52,
      inStock: true,
      category: 'storage',
      material: 'fabric',
      color: 'sand',
      dimensions: BedroomDimensionsModel(
        width: 140,
        height: 48,
        depth: 48,
        weight: 30,
      ),
      tags: ['bench', 'storage', 'lift-top'],
    ),
    BedroomModel(
      id: 'bedroom-008',
      name: 'Nova Wardrobe System',
      description:
          'Modular wardrobe with adjustable shelving, mirrored doors, and integrated LED lighting for closet-style organization.',
      price: 1899.0,
      imageUrl: 'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=400',
      rating: 4.5,
      reviewCount: 102,
      inStock: true,
      category: 'wardrobes',
      material: 'laminate',
      color: 'graphite',
      dimensions: BedroomDimensionsModel(
        width: 220,
        height: 220,
        depth: 60,
        weight: 110,
      ),
      isFeatured: true,
      tags: ['modular', 'wardrobe', 'led'],
    ),
    BedroomModel(
      id: 'bedroom-009',
      name: 'Lumen Floor Lamp',
      description:
          'Arched floor lamp with dimmable LED and ceramic base for soft ambient lighting beside the bed.',
      price: 189.0,
      imageUrl: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc83b?w=400',
      rating: 4.7,
      reviewCount: 84,
      inStock: true,
      category: 'lighting',
      material: 'metal',
      color: 'cream',
      dimensions: BedroomDimensionsModel(
        width: 45,
        height: 175,
        depth: 45,
        weight: 12,
      ),
      tags: ['lamp', 'lighting', 'led'],
    ),
    BedroomModel(
      id: 'bedroom-010',
      name: 'Ember Accent Rug',
      description:
          'Hand-woven wool rug with tactile texture and warm terracotta hues to anchor the sleeping area.',
      price: 249.0,
      imageUrl: 'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=400',
      rating: 4.6,
      reviewCount: 67,
      inStock: true,
      category: 'accessories',
      material: 'wool',
      color: 'terracotta',
      dimensions: BedroomDimensionsModel(
        width: 200,
        height: 1,
        depth: 300,
        weight: 15,
      ),
      tags: ['rug', 'wool', 'accent'],
    ),
    BedroomModel(
      id: 'bedroom-011',
      name: 'Prism Mirror',
      description:
          'Full-length mirror with fluted wood frame and integrated shelving, perfect for dressing rituals.',
      price: 499.0,
      imageUrl: 'https://images.unsplash.com/photo-1549187774-b4e9b0445b2a?w=400',
      rating: 4.4,
      reviewCount: 38,
      inStock: true,
      category: 'mirrors',
      material: 'wood',
      color: 'white',
      dimensions: BedroomDimensionsModel(
        width: 80,
        height: 200,
        depth: 10,
        weight: 32,
      ),
      tags: ['mirror', 'fluted', 'full-length'],
    ),
    BedroomModel(
      id: 'bedroom-012',
      name: 'Oasis Bedding Set',
      description:
          'Seven-piece bedding set with breathable cotton, sateen weave, and calming blue tones to finish the look.',
      price: 219.0,
      imageUrl: 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=400',
      rating: 4.9,
      reviewCount: 189,
      inStock: true,
      category: 'bedding',
      material: 'cotton',
      color: 'blue',
      dimensions: BedroomDimensionsModel(
        width: 0,
        height: 0,
        depth: 0,
        weight: 4,
      ),
      tags: ['bedding', 'cotton', 'set'],
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