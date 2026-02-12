import 'package:equatable/equatable.dart';

/// Bedroom entity representing a bedroom product.
///
/// This is the domain layer representation of a bedroom product.
/// It contains only business-relevant properties.
class Bedroom extends Equatable {
  /// Unique identifier for the bedroom.
  final String id;

  /// Bedroom name/title.
  final String name;

  /// Detailed description.
  final String description;

  /// Price in dollars.
  final double price;

  /// Original price before discount (if any).
  final double? originalPrice;

  /// Image URL for the bedroom.
  final String imageUrl;

  /// Product rating (0-5).
  final double rating;

  /// Number of customer reviews.
  final int reviewCount;

  /// Whether the product is in stock.
  final bool inStock;

  /// Bedroom product category (e.g., 'platform', 'kids').
  final String category;

  /// Bedroom material (e.g., 'wood', 'fabric').
  final String material;

  /// Bedroom color.
  final String color;

  /// Bedroom dimensions.
  final BedroomDimensions dimensions;

  /// Whether the product is featured.
  final bool isFeatured;

  /// Product tags for filtering.
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

  /// Check if product has a discount.
  bool get hasDiscount => originalPrice != null && originalPrice! > price;

  /// Calculate discount percentage.
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

/// Bedroom dimensions model representing product dimensions.
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

  /// Formatted dimensions string.
  String get formatted =>
      '${width}W x ${height}H x ${depth}D cm, ${weight}kg';

  @override
  List<Object> get props => [width, height, depth, weight];
}
