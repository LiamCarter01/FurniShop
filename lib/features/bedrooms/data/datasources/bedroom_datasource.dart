import '../models/bedroom_model.dart';

/// Data source interface for bedroom API operations.
abstract class BedroomDataSource {
  Future<List<BedroomModel>> getBedrooms();
  Future<BedroomModel> getBedroomById(String id);
  Future<List<BedroomModel>> getBedroomsByCategory(String category);
  Future<List<BedroomModel>> getFeaturedBedrooms();
  Future<List<BedroomModel>> searchBedrooms(String query);
}

/// Mock implementation that returns preset bedroom data.
class MockBedroomDataSource implements BedroomDataSource {
  static const Duration _delay = Duration(milliseconds: 700);

  final List<BedroomModel> _mockBedrooms = [
    const BedroomModel(
      id: 'bedroom-001',
      name: 'Modern Platform Bed',
      description:
          'Low-profile platform bed with built-in storage and warm walnut finish.',
      price: 1199.00,
      originalPrice: 1399.00,
      imageUrl:
          'https://images.unsplash.com/photo-1519710164239-da123dc03ef4?w=400',
      rating: 4.8,
      reviewCount: 210,
      inStock: true,
      category: 'bed',
      material: 'walnut',
      color: 'walnut',
      style: 'Modern',
      dimensions: BedroomDimensionsModel(
        width: 210,
        height: 120,
        depth: 180,
        weight: 80,
      ),
      isFeatured: true,
      tags: ['bed', 'storage', 'modern'],
    ),
    const BedroomModel(
      id: 'bedroom-002',
      name: 'Alpine Nightstand',
      description:
          'Compact nightstand with USB charging and soft-close drawers.',
      price: 249.00,
      imageUrl:
          'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=400',
      rating: 4.6,
      reviewCount: 89,
      inStock: true,
      category: 'nightstand',
      material: 'birch',
      color: 'white',
      style: 'Scandinavian',
      dimensions: BedroomDimensionsModel(
        width: 60,
        height: 60,
        depth: 40,
        weight: 12,
      ),
      isFeatured: true,
      tags: ['nightstand', 'scandinavian', 'charging'],
    ),
    const BedroomModel(
      id: 'bedroom-003',
      name: 'Nordic Dresser',
      description:
          'Spacious dresser with sculpted handles and matte lacquer finish.',
      price: 899.00,
      originalPrice: 999.00,
      imageUrl:
          'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=400',
      rating: 4.7,
      reviewCount: 132,
      inStock: true,
      category: 'dresser',
      material: 'beech',
      color: 'natural',
      style: 'Scandinavian',
      dimensions: BedroomDimensionsModel(
        width: 160,
        height: 100,
        depth: 50,
        weight: 45,
      ),
      tags: ['dresser', 'storage', 'modern'],
    ),
    const BedroomModel(
      id: 'bedroom-004',
      name: 'Midnight Upholstered Headboard',
      description:
          'Luxurious velvet headboard with channel tufting and steel frame.',
      price: 499.00,
      imageUrl:
          'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=400',
      rating: 4.9,
      reviewCount: 78,
      inStock: true,
      category: 'headboard',
      material: 'velvet',
      color: 'navy',
      style: 'Glam',
      dimensions: BedroomDimensionsModel(
        width: 180,
        height: 90,
        depth: 8,
        weight: 18,
      ),
      tags: ['headboard', 'velvet', 'glam'],
    ),
    const BedroomModel(
      id: 'bedroom-005',
      name: 'Eclipse Storage Bench',
      description:
          'Upholstered bench with hidden storage perfect for foot of bed seating.',
      price: 349.00,
      imageUrl:
          'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=400',
      rating: 4.5,
      reviewCount: 43,
      inStock: true,
      category: 'storage',
      material: 'fabric',
      color: 'charcoal',
      style: 'Industrial',
      dimensions: BedroomDimensionsModel(
        width: 150,
        height: 45,
        depth: 50,
        weight: 24,
      ),
      tags: ['storage', 'bench', 'industrial'],
    ),
    const BedroomModel(
      id: 'bedroom-006',
      name: 'Luminous Task Lamp',
      description:
          'Adjustable bedside lamp with touch dimming and USB outlet.',
      price: 129.00,
      imageUrl:
          'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=400',
      rating: 4.3,
      reviewCount: 64,
      inStock: true,
      category: 'lighting',
      material: 'aluminum',
      color: 'matte black',
      style: 'Minimal',
      dimensions: BedroomDimensionsModel(
        width: 25,
        height: 55,
        depth: 25,
        weight: 6,
      ),
      tags: ['lighting', 'lamp', 'touch'],
    ),
    const BedroomModel(
      id: 'bedroom-007',
      name: 'Plush Memory Foam Mattress',
      description:
          'CertiPUR-US certified mattress with adaptive cooling gel layers.',
      price: 1299.00,
      originalPrice: 1499.00,
      imageUrl:
          'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=400',
      rating: 4.8,
      reviewCount: 287,
      inStock: true,
      category: 'mattress',
      material: 'memory foam',
      color: 'white',
      style: 'Contemporary',
      dimensions: BedroomDimensionsModel(
        width: 200,
        height: 30,
        depth: 180,
        weight: 50,
      ),
      tags: ['mattress', 'memory foam', 'cooling'],
    ),
    const BedroomModel(
      id: 'bedroom-008',
      name: 'Velvet Accent Chair',
      description:
          'Curved accent chair with gold base for sitting areas or dressing rooms.',
      price: 329.00,
      imageUrl:
          'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=400',
      rating: 4.4,
      reviewCount: 99,
      inStock: true,
      category: 'accent',
      material: 'velvet',
      color: 'emerald',
      style: 'Glam',
      dimensions: BedroomDimensionsModel(
        width: 75,
        height: 85,
        depth: 75,
        weight: 19,
      ),
      tags: ['accent chair', 'luxury', 'glam'],
    ),
    const BedroomModel(
      id: 'bedroom-009',
      name: 'Serene Bedding Set',
      description:
          'Hyper-soft duvet cover set with breathable cotton sateen weave.',
      price: 229.00,
      imageUrl:
          'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=400',
      rating: 4.2,
      reviewCount: 176,
      inStock: true,
      category: 'bedding',
      material: 'cotton',
      color: 'mist',
      style: 'Modern',
      dimensions: BedroomDimensionsModel(
        width: 0,
        height: 0,
        depth: 0,
        weight: 3,
      ),
      tags: ['bedding', 'duvet', 'cotton'],
    ),
    const BedroomModel(
      id: 'bedroom-010',
      name: 'Aurelia Mirror',
      description:
          'Full-length mirror with beveled frame and integrated LED glow.',
      price: 459.00,
      imageUrl:
          'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=400',
      rating: 4.6,
      reviewCount: 89,
      inStock: true,
      category: 'mirror',
      material: 'glass',
      color: 'silver',
      style: 'Art Deco',
      dimensions: BedroomDimensionsModel(
        width: 70,
        height: 170,
        depth: 5,
        weight: 22,
      ),
      tags: ['mirror', 'led', 'art deco'],
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
        .where((bedroom) => bedroom.category.toLowerCase() ==
            category.toLowerCase())
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
