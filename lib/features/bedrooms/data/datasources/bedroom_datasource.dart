import '../models/bedroom_model.dart';

/// Data source interface for bedroom API operations.
///
/// Defines the contract for fetching bedroom data from remote or mock sources.
abstract class BedroomDataSource {
  /// Fetches all bedrooms.
  Future<List<BedroomModel>> getBedrooms();

  /// Fetches a bedroom by [id].
  Future<BedroomModel> getBedroomById(String id);

  /// Fetches bedrooms filtered by [category].
  Future<List<BedroomModel>> getBedroomsByCategory(String category);

  /// Fetches featured bedrooms.
  Future<List<BedroomModel>> getFeaturedBedrooms();

  /// Searches bedrooms matching the [query].
  Future<List<BedroomModel>> searchBedrooms(String query);
}

/// Mock implementation of [BedroomDataSource] returning hard-coded entries.
class MockBedroomDataSource implements BedroomDataSource {
  /// Simulated network delay for mock operations.
  static const Duration _delay = Duration(milliseconds: 900);

  /// Mock bedroom catalog.
  final List<BedroomModel> _mockBedrooms = [
    const BedroomModel(
      id: 'bedroom-001',
      name: 'Aurora Platform Bed',
      description:
          'Low-profile platform bed with integrated storage drawers and upholstered headboard.',
      price: 1099.00,
      originalPrice: 1299.00,
      imageUrl: 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=600',
      rating: 4.8,
      reviewCount: 214,
      inStock: true,
      category: 'bed',
      material: 'oak & fabric',
      color: 'seafoam',
      dimensions: BedroomDimensionsModel(
        width: 210,
        height: 110,
        depth: 210,
        weight: 80,
        headboardHeight: 120,
      ),
      isFeatured: true,
      tags: ['platform', 'storage', 'featured'],
      mattressSize: 'King',
      frameStyle: 'Platform',
    ),
    const BedroomModel(
      id: 'bedroom-002',
      name: 'Canyon Nightstands (Pair)',
      description: 'Solid walnut nightstands with metal legs and soft-close drawers.',
      price: 499.00,
      imageUrl: 'https://images.unsplash.com/photo-1505693416388-8f3cb0c0b2f0?w=600',
      rating: 4.6,
      reviewCount: 78,
      inStock: true,
      category: 'nightstand',
      material: 'walnut',
      color: 'espresso',
      dimensions: BedroomDimensionsModel(
        width: 90,
        height: 55,
        depth: 45,
        weight: 35,
      ),
      isFeatured: false,
      tags: ['walnut', 'nightstand', 'modern'],
      mattressSize: 'Queen',
      frameStyle: 'Nightstand Pair',
    ),
    const BedroomModel(
      id: 'bedroom-003',
      name: 'Harbor Dresser',
      description: 'Six-drawer dresser with matte finish and hidden handles.',
      price: 799.00,
      originalPrice: 899.00,
      imageUrl: 'https://images.unsplash.com/photo-1505691723518-36a5b3d9ad3b?w=600',
      rating: 4.5,
      reviewCount: 132,
      inStock: true,
      category: 'dresser',
      material: 'laminate',
      color: 'linen',
      dimensions: BedroomDimensionsModel(
        width: 150,
        height: 95,
        depth: 48,
        weight: 60,
      ),
      tags: ['dresser', 'storage', 'linen'],
      mattressSize: 'Queen',
      frameStyle: 'Classic',
    ),
    const BedroomModel(
      id: 'bedroom-004',
      name: 'Solstice Wardrobe',
      description: 'Freestanding wardrobe with mirrored doors and adjustable shelving.',
      price: 1249.00,
      imageUrl: 'https://images.unsplash.com/photo-1505693416388-240a42b79885?w=600',
      rating: 4.7,
      reviewCount: 92,
      inStock: true,
      category: 'storage',
      material: 'pine',
      color: 'natural',
      dimensions: BedroomDimensionsModel(
        width: 180,
        height: 210,
        depth: 60,
        weight: 95,
      ),
      isFeatured: true,
      tags: ['wardrobe', 'storage', 'mirrored'],
      mattressSize: 'King',
      frameStyle: 'Freestanding',
    ),
    const BedroomModel(
      id: 'bedroom-005',
      name: 'Luna Upholstered Bed',
      description: 'Tall upholstered headboard with button tufting and LED lighting.',
      price: 1399.00,
      originalPrice: 1499.00,
      imageUrl: 'https://images.unsplash.com/photo-1505691938895-1758d7feb511?w=600',
      rating: 4.9,
      reviewCount: 210,
      inStock: true,
      category: 'bed',
      material: 'fabric',
      color: 'charcoal',
      dimensions: BedroomDimensionsModel(
        width: 220,
        height: 135,
        depth: 220,
        weight: 85,
        headboardHeight: 135,
      ),
      isFeatured: true,
      tags: ['tufted', 'lighting', 'luxury'],
      mattressSize: 'California King',
      frameStyle: 'Upholstered',
    ),
    const BedroomModel(
      id: 'bedroom-006',
      name: 'Atlas Storage Bench',
      description: 'Bench with hidden lift-top storage perfect for foot of bed seating.',
      price: 299.00,
      imageUrl: 'https://images.unsplash.com/photo-1505691938895-45a4c19e2f48?w=600',
      rating: 4.3,
      reviewCount: 41,
      inStock: true,
      category: 'bench',
      material: 'fabric & metal',
      color: 'cream',
      dimensions: BedroomDimensionsModel(
        width: 140,
        height: 45,
        depth: 50,
        weight: 28,
      ),
      tags: ['bench', 'storage', 'multi-use'],
      mattressSize: 'Queen',
      frameStyle: 'Bench',
    ),
    const BedroomModel(
      id: 'bedroom-007',
      name: 'Nimbus Floating Shelves (Set of 3)',
      description: 'Floating shelves with hidden hardware for displaying collectibles.',
      price: 189.00,
      imageUrl: 'https://images.unsplash.com/photo-1505691938895-6ad1b5fb9d20?w=600',
      rating: 4.4,
      reviewCount: 63,
      inStock: true,
      category: 'decor',
      material: 'metal',
      color: 'matte black',
      dimensions: BedroomDimensionsModel(
        width: 120,
        height: 18,
        depth: 20,
        weight: 9,
      ),
      tags: ['shelves', 'decor', 'floating'],
      mattressSize: 'Queen',
      frameStyle: 'Wall Mount',
    ),
    const BedroomModel(
      id: 'bedroom-008',
      name: 'Harbor Mirror',
      description: 'Full-length mirror with brass frame and beveled edges.',
      price: 349.00,
      imageUrl: 'https://images.unsplash.com/photo-1505691938895-8051b94a8d3b?w=600',
      rating: 4.6,
      reviewCount: 51,
      inStock: true,
      category: 'mirror',
      material: 'brass',
      color: 'gold',
      dimensions: BedroomDimensionsModel(
        width: 70,
        height: 185,
        depth: 4,
        weight: 22,
      ),
      tags: ['mirror', 'decor', 'brass'],
      mattressSize: 'Queen',
      frameStyle: 'Standing',
    ),
    const BedroomModel(
      id: 'bedroom-009',
      name: 'Mariner Canopy Bed',
      description: 'Four-post canopy bed with airy drapery rods and solid frame.',
      price: 1699.00,
      originalPrice: 1899.00,
      imageUrl: 'https://images.unsplash.com/photo-1505691938895-5c0f7d4a8b3c?w=600',
      rating: 4.7,
      reviewCount: 149,
      inStock: false,
      category: 'bed',
      material: 'metal',
      color: 'bronze',
      dimensions: BedroomDimensionsModel(
        width: 230,
        height: 220,
        depth: 230,
        weight: 110,
        headboardHeight: 220,
      ),
      tags: ['canopy', 'luxury', 'metal'],
      mattressSize: 'King',
      frameStyle: 'Canopy',
    ),
    const BedroomModel(
      id: 'bedroom-010',
      name: 'Terra Writing Desk',
      description: 'Compact writing desk doubling as vanity with hidden cable management.',
      price: 649.00,
      imageUrl: 'https://images.unsplash.com/photo-1505691938895-7adf4d5b9f52?w=600',
      rating: 4.2,
      reviewCount: 56,
      inStock: true,
      category: 'desk',
      material: 'maple',
      color: 'driftwood',
      dimensions: BedroomDimensionsModel(
        width: 135,
        height: 76,
        depth: 55,
        weight: 32,
      ),
      tags: ['desk', 'multi-use', 'vanity'],
      mattressSize: 'Queen',
      frameStyle: 'Desk',
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
          bedroom.tags.any((tag) => tag.toLowerCase().contains(lowerQuery)) ||
          bedroom.category.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}
