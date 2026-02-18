import 'package:equatable/equatable.dart';

/// Bedroom entity representing a bedroom product.
///
/// Contains only the business logic properties used across the feature.
class Bedroom extends Equatable {
  /// Unique identifier for the bedroom product.
  final String id;

  /// Product name/title.
  final String name;

  /// Detailed description shown on the product page.
  final String description;

  /// Current price in USD.
  final double price;

  /// Original price before discount (if any).
  final double? originalPrice;

  /// Image URL to display the product.
  final String imageUrl;

  /// Average rating (0-5 scale).
  final double rating;

  /// Number of customer reviews.
  final int reviewCount;

  /// Availability indicator.
  final bool inStock;

  /// Product category (e.g., beds, storage, textiles).
  final String category;

  /// Primary material of the product.
  final String material;

  /// Color name.
  final String color;

  /// Product dimensions.
  final BedroomDimensions dimensions;

  /// Whether the product is featured.
  final bool isFeatured;

  /// Optional tags for filtering and search.
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

  /// Check if the product currently has a discount.
  bool get hasDiscount => originalPrice != null && originalPrice! > price;

  /// Calculate the discount percentage.
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

/// Bedroom product dimensions.
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

  /// Friendly formatted string for UI display.
  String get formatted =>
      '${width}W x ${height}H x ${depth}D cm, ${weight}kg';

  @override
  List<Object> get props => [width, height, depth, weight];
}
