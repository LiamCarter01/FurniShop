import '../models/models.dart';

/// Data source interface for desk API operations.
///
/// This defines the contract for remote data access.
abstract class DeskDataSource {
  /// Fetch all desks from API.
  Future<List<DeskModel>> getDesks();

  /// Fetch a single desk by ID.
  Future<DeskModel> getDeskById(String id);

  /// Fetch desks by category.
  Future<List<DeskModel>> getDesksByCategory(String category);

  /// Fetch featured desks.
  Future<List<DeskModel>> getFeaturedDesks();

  /// Search desks by query.
  Future<List<DeskModel>> searchDesks(String query);
}

/// Mock implementation of [DeskDataSource] for development.
///
/// Returns mock data instead of making real API calls.
/// Replace with real API implementation in production.
class MockDeskDataSource implements DeskDataSource {
  /// Simulated network delay.
  static const Duration _delay = Duration(milliseconds: 800);

  /// Mock desk data.
  final List<DeskModel> _mockDesks = [
    const DeskModel(
      id: 'desk-001',
      name: 'Modern Office Desk',
      description: 'Sleek modern office desk with cable management and spacious surface.',
      price: 349.99,
      originalPrice: 449.99,
      imageUrl: 'https://images.unsplash.com/photo-1582582494700-045d1e9ef8bc?w=400',
      rating: 4.7,
      reviewCount: 112,
      inStock: true,
      category: 'office',
      material: 'wood',
      color: 'white',
      dimensions: DeskDimensionsModel(
        width: 140,
        height: 75,
        depth: 60,
        weight: 20,
      ),
      isFeatured: true,
      tags: ['modern', 'office', 'spacious'],
    ),
    const DeskModel(
      id: 'desk-002',
      name: 'Standing Desk',
      description: 'Height-adjustable standing desk for ergonomic work setup.',
      price: 499.99,
      imageUrl: 'https://images.unsplash.com/photo-1603415526960-f9e7a9507b52?w=400',
      rating: 4.8,
      reviewCount: 94,
      inStock: true,
      category: 'standing',
      material: 'metal',
      color: 'black',
      dimensions: DeskDimensionsModel(
        width: 120,
        height: 110,
        depth: 65,
        weight: 30,
      ),
      isFeatured: true,
      tags: ['standing', 'ergonomic', 'adjustable'],
    ),
    const DeskModel(
      id: 'desk-003',
      name: 'Corner Desk',
      description: 'Space-saving corner desk perfect for home offices.',
      price: 259.99,
      originalPrice: 299.99,
      imageUrl: 'https://images.unsplash.com/photo-1582571342959-e2067d08c35f?w=400',
      rating: 4.5,
      reviewCount: 68,
      inStock: true,
      category: 'corner',
      material: 'glass',
      color: 'black',
      dimensions: DeskDimensionsModel(
        width: 100,
        height: 75,
        depth: 100,
        weight: 18,
      ),
      isFeatured: false,
      tags: ['corner', 'compact', 'home office'],
    ),
  ];

  @override
  Future<List<DeskModel>> getDesks() async {
    await Future.delayed(_delay);
    return _mockDesks;
  }

  @override
  Future<DeskModel> getDeskById(String id) async {
    await Future.delayed(_delay);
    return _mockDesks.firstWhere(
      (desk) => desk.id == id,
      orElse: () => throw Exception('Desk not found'),
    );
  }

  @override
  Future<List<DeskModel>> getDesksByCategory(String category) async {
    await Future.delayed(_delay);
    return _mockDesks
        .where((desk) => desk.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  @override
  Future<List<DeskModel>> getFeaturedDesks() async {
    await Future.delayed(_delay);
    return _mockDesks.where((desk) => desk.isFeatured).toList();
  }

  @override
  Future<List<DeskModel>> searchDesks(String query) async {
    await Future.delayed(_delay);
    final lowerQuery = query.toLowerCase();
    return _mockDesks.where((desk) {
      return desk.name.toLowerCase().contains(lowerQuery) ||
          desk.description.toLowerCase().contains(lowerQuery) ||
          desk.category.toLowerCase().contains(lowerQuery) ||
          desk.tags.any((tag) => tag.toLowerCase().contains(lowerQuery));
    }).toList();
  }
}
