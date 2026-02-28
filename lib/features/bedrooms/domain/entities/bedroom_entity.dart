import 'package:equatable/equatable.dart';

/// Bedroom entity representing a bedrooms product.
///
/// This is the domain layer representation of a bedroom item.
/// Contains only the business-relevant properties.
class Bedroom extends Equatable {
  /// Unique identifier for the bedroom product.
  final String id;

  /// Product name/title.
  final String name;

  /// Detailed product description.
  final String description;

  /// Price in dollars.
  final double price;

  /// Original price before any discount.
  final double? originalPrice;

  /// Image URL for the product.
  final String imageUrl;

  /// Average customer rating (0-5 scale).
  final double rating;

  /// Number of reviews received.
  final int reviewCount;

  /// Whether the product is currently in stock.
  final bool inStock;

  /// Product category (e.g., 'bed', 'nightstand', 'dresser').
  final String category;

  /// Product material (e.g., 'oak', 'velvet', 'metal').
  final String material;

  /// Product color description.
  final String color;

  /// Product dimensions details.
  final BedroomDimensions dimensions;

  /// Whether the product is featured.
  final bool isFeatured;

  /// Tags used for filtering and searching.
  final List<String> tags;

  const Bedroom({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.inStock,
    required this.category,
    required this.material,
    required this.color,
    required this.dimensions,
    this.isFeatured = false,
    this.tags = const [],
  });

  /// Checks whether this product has an active discount.
  bool get hasDiscount => originalPrice != null && originalPrice! > price;

  /// Computes the discount percentage if applicable.
  int get discountPercentage {
    if (!hasDiscount) return 0;
    return ((originalPrice! - price) / originalPrice! * 100).round();
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        originalPrice,
        imageUrl,
        rating,
        reviewCount,
        inStock,
        category,
        material,
        color,
        dimensions,
        isFeatured,
        tags,
      ];
}

/// Dimensions for a bedroom product.
class BedroomDimensions extends Equatable {
  final double width;
  final double height;
  final double depth;
  final double weight;

  const BedroomDimensions({
    required this.width,
    required this.height,
    required this.depth,
    required this.weight,
  });

  /// Formatted dimensions string for display.
  String get formatted =>
      '${width}W x ${height}H x ${depth}D cm, ${weight}kg';

  @override
  List<Object> get props => [width, height, depth, weight];
}
