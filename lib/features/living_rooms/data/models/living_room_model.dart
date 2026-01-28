import '../../domain/entities/living_room_entity.dart';

/// LivingRoom data model for API communication.
///
/// This extends the domain entity with JSON serialization.
/// Used for parsing API responses.
class LivingRoomModel extends LivingRoom {
  const LivingRoomModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    super.originalPrice,
    required super.imageUrl,
    required super.rating,
    required super.reviewCount,
    required super.inStock,
    required super.category,
    required super.material,
    required super.color,
    required super.dimensions,
    super.isFeatured,
    super.tags,
  });

  /// Create a LivingRoomModel from JSON map.
  factory LivingRoomModel.fromJson(Map<String, dynamic> json) {
    return LivingRoomModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      originalPrice: json['original_price'] != null
          ? (json['original_price'] as num).toDouble()
          : null,
      imageUrl: json['image_url'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['review_count'] as int,
      inStock: json['in_stock'] as bool,
      category: json['category'] as String,
      material: json['material'] as String,
      color: json['color'] as String,
      dimensions: LivingRoomDimensionsModel.fromJson(
        json['dimensions'] as Map<String, dynamic>,
      ),
      isFeatured: json['is_featured'] as bool? ?? false,
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );
  }

  /// Convert to JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'original_price': originalPrice,
      'image_url': imageUrl,
      'rating': rating,
      'review_count': reviewCount,
      'in_stock': inStock,
      'category': category,
      'material': material,
      'color': color,
      'dimensions': {
        'width': dimensions.width,
        'height': dimensions.height,
        'depth': dimensions.depth,
        'weight': dimensions.weight,
      },
      'is_featured': isFeatured,
      'tags': tags,
    };
  }

  /// Convert this model to its domain entity.
  LivingRoom toEntity() => this;

  /// Create a LivingRoomModel from a LivingRoom entity.
  factory LivingRoomModel.fromEntity(LivingRoom livingRoom) {
    return LivingRoomModel(
      id: livingRoom.id,
      name: livingRoom.name,
      description: livingRoom.description,
      price: livingRoom.price,
      originalPrice: livingRoom.originalPrice,
      imageUrl: livingRoom.imageUrl,
      rating: livingRoom.rating,
      reviewCount: livingRoom.reviewCount,
      inStock: livingRoom.inStock,
      category: livingRoom.category,
      material: livingRoom.material,
      color: livingRoom.color,
      dimensions: livingRoom.dimensions,
      isFeatured: livingRoom.isFeatured,
      tags: livingRoom.tags,
    );
  }
}

/// Living room dimensions model with JSON serialization.
class LivingRoomDimensionsModel extends LivingRoomDimensions {
  const LivingRoomDimensionsModel({
    required super.width,
    required super.height,
    required super.depth,
    required super.weight,
  });

  /// Create from JSON map.
  factory LivingRoomDimensionsModel.fromJson(Map<String, dynamic> json) {
    return LivingRoomDimensionsModel(
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      depth: (json['depth'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
    );
  }

  /// Convert to JSON map.
  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
      'depth': depth,
      'weight': weight,
    };
  }
}
