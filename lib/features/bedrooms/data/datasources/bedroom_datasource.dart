import '../../../../core/errors/exceptions.dart';
import '../models/bedroom_model.dart';

/// Data source interface for bedroom API operations.
///
/// This defines the contract for remote data access.
abstract class BedroomDataSource {
  /// Fetch all bedrooms.
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
  static const Duration _delay = Duration(milliseconds: 800);

  final List<BedroomModel> _mockBedrooms = [
    const BedroomModel(
      id: 'bedroom-001',
      name: 'Midnight Sanctuary Bed',
      description:
          'Platform bed with upholstered headboard and integrated lighting, crafted for restful evenings.',
      price: 1099.99,
      originalPrice: 1299.99,
      imageUrl: 'https://images.unsplash.com/photo-1505691938895-1758d7feb511?w=400',
      rating: 4.9,
      reviewCount: 214,
      inStock: true,
      category: 'beds',
      material: 'velvet',
      color: 'navy',
      dimensions: BedroomDimensionsModel(
        width: 200,
        height: 110,
        depth: 220,
        weight: 80,
      ),
      isFeatured: true,
      tags: ['luxury', 'platform', 'lighting'],
    ),
    const BedroomModel(
      id: 'bedroom-002',
      name: 'Oak Haven Dresser',
      description:
          'Solid oak dresser with soft-close drawers and matte black hardware for modern storage needs.',
      price: 749.99,
      imageUrl: 'https://images.unsplash.com/photo-1585559606519-7bb9c4417f24?w=400',
      rating: 4.6,
      reviewCount: 156,
      inStock: true,
      category: 'dressers',
      material: 'wood',
      color: 'oak',
      dimensions: BedroomDimensionsModel(
        width: 160,
        height: 95,
        depth: 50,
        weight: 65,
      ),
      isFeatured: true,
      tags: ['storage', 'modern', 'oak'],
    ),
    const BedroomModel(
      id: 'bedroom-003',
      name: 'Luxe Linen Canopy',
      description:
          'Four-poster canopy bed draped in breathable linen, perfect for romantic retreats.',
      price: 1399.99,
      originalPrice: 1599.99,
      imageUrl: 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=400',
      rating: 4.8,
      reviewCount: 112,
      inStock: true,
      category: 'beds',
      material: 'linen',
      color: 'sand',
      dimensions: BedroomDimensionsModel(
        width: 210,
        height: 220,
        depth: 230,
        weight: 95,
      ),
      isFeatured: true,
      tags: ['canopy', 'bedroom', 'linen'],
    ),
    const BedroomModel(
      id: 'bedroom-004',
      name: 'Crestview Nightstand',
      description:
          'Cedar nightstand with wireless charging compartment and integrated drawer organizer.',
      price: 279.99,
      imageUrl: 'https://images.unsplash.com/photo-1504247680197-cb14b4a73b95?w=400',
      rating: 4.5,
      reviewCount: 98,
      inStock: true,
      category: 'nightstands',
      material: 'cedar',
      color: 'taupe',
      dimensions: BedroomDimensionsModel(
        width: 60,
        height: 70,
        depth: 45,
        weight: 18,
      ),
      isFeatured: false,
      tags: ['storage', 'charging', 'organizer'],
    ),
    const BedroomModel(
      id: 'bedroom-005',
      name: 'Aviary Wardrobe',
      description:
          'Spacious wardrobe with mirrored doors, adjustable shelving, and brass hardware.',
      price: 1299.99,
      imageUrl: 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=400',
      rating: 4.7,
      reviewCount: 134,
      inStock: false,
      category: 'storage',
      material: 'wood',
      color: 'espresso',
      dimensions: BedroomDimensionsModel(
        width: 180,
        height: 210,
        depth: 65,
        weight: 120,
      ),
      isFeatured: false,
      tags: ['wardrobe', 'mirrored', 'bridal'],
    ),
    const BedroomModel(
      id: 'bedroom-006',
      name: 'Modern Loft Bed',
      description:
          'Loft bed with integrated desk, steps, and under-bed lounge area for multi-purpose spaces.',
      price: 899.99,
      imageUrl: 'https://images.unsplash.com/photo-1470246973918-29a93221c455?w=400',
      rating: 4.4,
      reviewCount: 78,
      inStock: true,
      category: 'kids',
      material: 'metal',
      color: 'matte_black',
      dimensions: BedroomDimensionsModel(
        width: 220,
        height: 190,
        depth: 120,
        weight: 75,
      ),
      isFeatured: false,
      tags: ['loft', 'studio', 'kids'],
    ),
    const BedroomModel(
      id: 'bedroom-007',
      name: 'Serene Upholstered Bench',
      description:
          'Tufted bench with storage compartment, ideal for seating at the foot of the bed.',
      price: 249.99,
      imageUrl: 'https://images.unsplash.com/photo-1519710164239-da123dc03ef4?w=400',
      rating: 4.3,
      reviewCount: 64,
      inStock: true,
      category: 'accessories',
      material: 'velvet',
      color: 'sage',
      dimensions: BedroomDimensionsModel(
        width: 140,
        height: 45,
        depth: 45,
        weight: 22,
      ),
      isFeatured: false,
      tags: ['bench', 'storage', 'accent'],
    ),
    const BedroomModel(
      id: 'bedroom-008',
      name: 'Atlas Floating Shelves',
      description:
          'Set of three floating shelves with matte black brackets and hidden anchors.',
      price: 189.99,
      imageUrl: 'https://images.unsplash.com/photo-1470246973918-29a93221c455?w=400',
      rating: 4.6,
      reviewCount: 89,
      inStock: true,
      category: 'storage',
      material: 'wood',
      color: 'ash',
      dimensions: BedroomDimensionsModel(
        width: 100,
        height: 5,
        depth: 25,
        weight: 12,
      ),
      isFeatured: true,
      tags: ['shelves', 'floating', 'storage'],
    ),
    const BedroomModel(
      id: 'bedroom-009',
      name: 'Velvet Vanity Chair',
      description:
          'Compact vanity chair with brass legs and plush velvet upholstery.',
      price: 189.99,
      imageUrl: 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=400',
      rating: 4.2,
      reviewCount: 47,
      inStock: true,
      category: 'seating',
      material: 'velvet',
      color: 'rose',
      dimensions: BedroomDimensionsModel(
        width: 50,
        height: 75,
        depth: 50,
        weight: 10,
      ),
      isFeatured: false,
      tags: ['vanity', 'luxury', 'powder_room'],
    ),
    const BedroomModel(
      id: 'bedroom-010',
      name: 'Nimbus Adjustable Headboard',
      description:
          'Headboard with adjustable angles, built-in USB ports, and acoustic fabric panels.',
      price: 599.99,
      imageUrl: 'https://images.unsplash.com/photo-1505691938895-1758d7feb511?w=400',
      rating: 4.7,
      reviewCount: 101,
      inStock: true,
      category: 'beds',
      material: 'fabric',
      color: 'charcoal',
      dimensions: BedroomDimensionsModel(
        width: 180,
        height: 120,
        depth: 10,
        weight: 35,
      ),
      isFeatured: true,
      tags: ['headboard', 'adjustable', 'tech'],
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
      orElse: () => throw const NotFoundException(message: 'Bedroom not found'),
    );
  }

  @override
  Future<List<BedroomModel>> getBedroomsByCategory(String category) async {
    await Future.delayed(_delay);
    return _mockBedrooms
        .where(
            (bedroom) => bedroom.category.toLowerCase() == category.toLowerCase())
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
