import 'package:equatable/equatable.dart';

/// Bedroom entity representing a bedroom product in the app.
class Bedroom extends Equatable {
  /// Unique identifier for the bedroom product.
  final String id;

  /// Bedroom name/title.
  final String name;

  /// Detailed description of the bedroom product.
  final String description;

  /// Current price for the product.
  final double price;

  /// Original price before any discount (nullable).
  final double? originalPrice;

  /// Image representing the bedroom product.
  final String imageUrl;

  /// Product rating (scale 0-5).
  final double rating;

  /// Number of customer reviews.
  final int reviewCount;

  /// Availability flag.
  final bool inStock;

  /// Product category (e.g., 'bed', 'nightstand', 'storage').
  final String category;

  /// Primary material used in the product.
  final String material;

  /// Dominant color for display.
  final String color;

  /// Styling direction for the product (e.g., 'Scandinavian').
  final String style;

  /// Product dimensions.
  final BedroomDimensions dimensions;

  /// Whether the item is featured.
  final bool isFeatured;

  /// Tags useful for filtering and search.
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
    required this.style,
    required this.dimensions,
    this.isFeatured = false,
    this.tags = const [],
  });

  /// Whether the product is currently discounted.
  bool get hasDiscount =>
      originalPrice != null && originalPrice! > price;

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
        style,
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

  /// Human readable dimensions string.
  String get formatted =>
      '${width}W x ${height}H x ${depth}D cm, ${weight}kg';

  @override
  List<Object> get props => [width, height, depth, weight];
}
