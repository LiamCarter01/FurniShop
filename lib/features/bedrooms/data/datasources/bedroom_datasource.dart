import '../models/bedroom_model.dart';

/// Data source interface for bedroom API operations.
///
/// This defines the contract for remote data access.
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
/// Replace with real API implementation in production.
class MockBedroomDataSource implements BedroomDataSource {
  /// Simulated network delay.
  static const Duration _delay = Duration(milliseconds: 800);

  /// Mock bedroom data.
  final List<BedroomModel> _mockBedrooms = [
    const BedroomModel(
      id: 'bedroom-001',
      name: 'Modern Platform Bed',
      description: 'Sleek modern platform bed with minimalist design and durable hardwood frame.',
      price: 499.99,
      originalPrice: 599.99,
      imageUrl: 'https://images.unsplash.com/photo-1567016432779-1f0a8d3a4598?w=400',
      rating: 4.5,
      reviewCount: 85,
      inStock: true,
      category: 'bed',
      material: 'wood',
      color: 'natural',
      dimensions: BedroomDimensionsModel(
        width: 210,
        height: 100,
        depth: 150,
        weight: 60,
      ),
      isFeatured: true,
      tags: ['modern', 'platform', 'wood'],
    ),
    const BedroomModel(
      id: 'bedroom-002',
      name: 'Storage Bed Frame',
      description: 'Space-saving storage bed with built-in drawers, perfect for small bedrooms.',
      price: 649.99,
      imageUrl: 'https://images.unsplash.com/photo-1578894380422-8b1024c6a97b?w=400',
      rating: 4.2,
      reviewCount: 47,
      inStock: true,
      category: 'storage',
      material: 'engineered wood',
      color: 'white',
      dimensions: BedroomDimensionsModel(
        width: 200,
        height: 110,
        depth: 140,
        weight: 70,
      ),
      isFeatured: false,
      tags: ['storage', 'functional', 'white'],
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
    return _mockBedrooms.firstWhere((b) => b.id == id);
  }

  @override
  Future<List<BedroomModel>> getBedroomsByCategory(String category) async {
    await Future.delayed(_delay);
    return _mockBedrooms
        .where((b) => b.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  @override
  Future<List<BedroomModel>> getFeaturedBedrooms() async {
    await Future.delayed(_delay);
    return _mockBedrooms.where((b) => b.isFeatured).toList();
  }

  @override
  Future<List<BedroomModel>> searchBedrooms(String query) async {
    await Future.delayed(_delay);
    final lower = query.toLowerCase();
    return _mockBedrooms.where((b) {
      return b.name.toLowerCase().contains(lower) ||
          b.description.toLowerCase().contains(lower) ||
          b.category.toLowerCase().contains(lower) ||
          b.tags.any((tag) => tag.toLowerCase().contains(lower));
    }).toList();
  }
}