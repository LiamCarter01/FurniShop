import '../models/living_room_model.dart';

/// Data source interface for living room API operations.
///
/// This defines the contract for remote data access.
abstract class LivingRoomDataSource {
  /// Fetch all living rooms.
  Future<List<LivingRoomModel>> getLivingRooms();

  /// Fetch a single living room by ID.
  Future<LivingRoomModel> getLivingRoomById(String id);

  /// Fetch living rooms by category.
  Future<List<LivingRoomModel>> getLivingRoomsByCategory(String category);

  /// Fetch featured living rooms.
  Future<List<LivingRoomModel>> getFeaturedLivingRooms();

  /// Search living rooms by query.
  Future<List<LivingRoomModel>> searchLivingRooms(String query);
}

/// Mock implementation of [LivingRoomDataSource] for development.
///
/// Returns mock data instead of making real API calls.
class MockLivingRoomDataSource implements LivingRoomDataSource {
  /// Simulated network delay.
  static const Duration _delay = Duration(milliseconds: 800);

  /// Mock living room data.
  final List<LivingRoomModel> _mockLivingRooms = [
    const LivingRoomModel(
      id: 'livingroom-001',
      name: 'Contemporary Sofa',
      description:
          'A stylish, comfortable sofa perfect for modern living rooms. Soft fabric upholstery and solid wood frame.',
      price: 799.99,
      originalPrice: 999.99,
      imageUrl:
          'https://images.unsplash.com/photo-1586105251261-72dab2f3c17e?w=400',
      rating: 4.7,
      reviewCount: 142,
      inStock: true,
      category: 'sofa',
      material: 'fabric',
      color: 'gray',
      dimensions: LivingRoomDimensionsModel(
        width: 200,
        height: 90,
        depth: 100,
        weight: 60,
      ),
      isFeatured: true,
      tags: ['sofa', 'living room', 'fabric'],
    ),
    const LivingRoomModel(
      id: 'livingroom-002',
      name: 'Modern Coffee Table',
      description:
          'Sleek coffee table with tempered glass top and minimalist metal legs, ideal for contemporary settings.',
      price: 249.99,
      imageUrl:
          'https://images.unsplash.com/photo-1598300058732-033ca9044b09?w=400',
      rating: 4.5,
      reviewCount: 98,
      inStock: true,
      category: 'coffee_table',
      material: 'glass',
      color: 'black',
      dimensions: LivingRoomDimensionsModel(
        width: 120,
        height: 45,
        depth: 60,
        weight: 20,
      ),
      isFeatured: false,
      tags: ['coffee table', 'modern'],
    ),
  ];

  @override
  Future<List<LivingRoomModel>> getLivingRooms() async {
    await Future.delayed(_delay);
    return _mockLivingRooms;
  }

  @override
  Future<LivingRoomModel> getLivingRoomById(String id) async {
    await Future.delayed(_delay);
    return _mockLivingRooms.firstWhere(
      (item) => item.id == id,
      orElse: () => throw Exception('Living room not found'),
    );
  }

  @override
  Future<List<LivingRoomModel>> getLivingRoomsByCategory(String category) async {
    await Future.delayed(_delay);
    return _mockLivingRooms
        .where(
          (item) => item.category.toLowerCase() == category.toLowerCase(),
        )
        .toList();
  }

  @override
  Future<List<LivingRoomModel>> getFeaturedLivingRooms() async {
    await Future.delayed(_delay);
    return _mockLivingRooms.where((item) => item.isFeatured).toList();
  }

  @override
  Future<List<LivingRoomModel>> searchLivingRooms(String query) async {
    await Future.delayed(_delay);
    final lowerQuery = query.toLowerCase();
    return _mockLivingRooms.where((item) {
      return item.name.toLowerCase().contains(lowerQuery) ||
          item.description.toLowerCase().contains(lowerQuery) ||
          item.category.toLowerCase().contains(lowerQuery) ||
          item.tags.any((tag) => tag.toLowerCase().contains(lowerQuery));
    }).toList();
  }
}