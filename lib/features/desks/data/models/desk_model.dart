import '../../domain/entities/desk_entity.dart';

/// Desk data model for API communication.
///
/// This extends the domain entity with JSON serialization.
/// Used for parsing API responses.
class DeskModel extends Desk {
  const DeskModel({
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

  /// Create a DeskModel from JSON map.
  factory DeskModel.fromJson(Map<String, dynamic> json) {
    return DeskModel(
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
      dimensions: DeskDimensionsModel.fromJson(
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

  /// Create a Desk entity from this model.
  Desk toEntity() => this;

  /// Create a DeskModel from a Desk entity.
  factory DeskModel.fromEntity(Desk desk) {
    return DeskModel(
      id: desk.id,
      name: desk.name,
      description: desk.description,
      price: desk.price,
      originalPrice: desk.originalPrice,
      imageUrl: desk.imageUrl,
      rating: desk.rating,
      reviewCount: desk.reviewCount,
      inStock: desk.inStock,
      category: desk.category,
      material: desk.material,
      color: desk.color,
      dimensions: desk.dimensions,
      isFeatured: desk.isFeatured,
      tags: desk.tags,
    );
  }
}

/// Desk dimensions model with JSON serialization.
class DeskDimensionsModel extends DeskDimensions {
  const DeskDimensionsModel({
    required super.width,
    required super.height,
    required super.depth,
    required super.weight,
  });

  factory DeskDimensionsModel.fromJson(Map<String, dynamic> json) {
    return DeskDimensionsModel(
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      depth: (json['depth'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
      'depth': depth,
      'weight': weight,
    };
  }
}
