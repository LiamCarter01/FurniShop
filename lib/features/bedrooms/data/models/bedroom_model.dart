import '../../domain/entities/bedroom_entity.dart';

/// Data model representing a bedroom product.
class BedroomModel extends Bedroom {
  const BedroomModel({
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

  /// Create [BedroomModel] from JSON map.
  factory BedroomModel.fromJson(Map<String, dynamic> json) {
    return BedroomModel(
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
      dimensions: BedroomDimensionsModel.fromJson(
        json['dimensions'] as Map<String, dynamic>,
      ),
      isFeatured: json['is_featured'] as bool? ?? false,
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );
  }

  /// Convert this model to JSON map.
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

  /// Map this model back to the domain entity.
  Bedroom toEntity() => this;

  /// Create a model from a domain entity.
  factory BedroomModel.fromEntity(Bedroom bedroom) {
    return BedroomModel(
      id: bedroom.id,
      name: bedroom.name,
      description: bedroom.description,
      price: bedroom.price,
      originalPrice: bedroom.originalPrice,
      imageUrl: bedroom.imageUrl,
      rating: bedroom.rating,
      reviewCount: bedroom.reviewCount,
      inStock: bedroom.inStock,
      category: bedroom.category,
      material: bedroom.material,
      color: bedroom.color,
      dimensions: bedroom.dimensions,
      isFeatured: bedroom.isFeatured,
      tags: bedroom.tags,
    );
  }
}

/// Bedroom dimensions model supporting JSON serialization.
class BedroomDimensionsModel extends BedroomDimensions {
  const BedroomDimensionsModel({
    required super.width,
    required super.height,
    required super.depth,
    required super.weight,
  });

  /// Deserialize from JSON.
  factory BedroomDimensionsModel.fromJson(Map<String, dynamic> json) {
    return BedroomDimensionsModel(
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      depth: (json['depth'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
    );
  }

  /// Serialize to JSON.
  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
      'depth': depth,
      'weight': weight,
    };
  }
}
