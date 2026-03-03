import 'package:equatable/equatable.dart';

/// Bedroom entity representing a bedroom product.
///
/// This is the domain layer representation used across the bedrooms feature.
class Bedroom extends Equatable {
  /// Unique identifier for the bedroom product.
  final String id;

  /// Display name for the bedroom.
  final String name;

  /// Detailed description of the product.
  final String description;

  /// Current price in USD.
  final double price;

  /// Original price before any discount.
  final double? originalPrice;

  /// Image URL representing the bedroom.
  final String imageUrl;

  /// Product rating (0-5).
  final double rating;

  /// Number of reviews for the product.
  final int reviewCount;

  /// Whether the product is currently in stock.
  final bool inStock;

  /// Product category (e.g., 'beds', 'storage', 'lighting').
  final String category;

  /// Targeted style (e.g., 'modern', 'minimalist', 'classic').
  final String style;

  /// Material used for the piece (e.g., 'wood', 'metal').
  final String material;

  /// Dominant color of the bedroom set.
  final String color;

  /// Dimensions of the product.
  final BedroomDimensions dimensions;

  /// Whether the bedroom is featured in the catalog.
  final bool isFeatured;

  /// Product tags helpful for filtering/search.
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
    required this.style,
    required this.material,
    required this.color,
    required this.dimensions,
    this.isFeatured = false,
    this.tags = const [],
  });

  /// Whether the bedroom has a discounted price.
  bool get hasDiscount => originalPrice != null && originalPrice! > price;

  /// Calculated discount percentage when applicable.
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
        style,
        material,
        color,
        dimensions,
        isFeatured,
        tags,
      ];
}

/// Bedroom dimensions for a product.
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

  /// Human-readable formatted string for dimensions.
  String get formatted =>
      '${width}W x ${height}H x ${depth}D cm, ${weight}kg';

  @override
  List<Object> get props => [width, height, depth, weight];
}
