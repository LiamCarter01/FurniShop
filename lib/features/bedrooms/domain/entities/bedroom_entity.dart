import 'package:equatable/equatable.dart';

/// Bedroom entity representing a bedroom product.
///
/// Contains only business-relevant fields used across the application layers.
class Bedroom extends Equatable {
  /// Unique identifier for the bedroom product.
  final String id;

  /// Display name/title for the bedroom set.
  final String name;

  /// Detailed description of the bedroom product.
  final String description;

  /// Current selling price.
  final double price;

  /// Original price, used to calculate discounts when present.
  final double? originalPrice;

  /// URL to the primary product image.
  final String imageUrl;

  /// Average customer rating between 0 and 5.
  final double rating;

  /// Total number of customer reviews.
  final int reviewCount;

  /// Whether the item is available for purchase.
  final bool inStock;

  /// Product category (e.g., 'bed', 'dresser', 'nightstand').
  final String category;

  /// Material used in the product construction.
  final String material;

  /// Dominant color of the product.
  final String color;

  /// Physical dimensions and weight information.
  final BedroomDimensions dimensions;

  /// Whether this product is highlighted in featured sections.
  final bool isFeatured;

  /// Tags used for filtering across the UI.
  final List<String> tags;

  /// Mattress size compatibility (e.g., 'Queen', 'King').
  final String mattressSize;

  /// Frame style/type for the bedroom set.
  final String frameStyle;

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
    this.mattressSize = 'Queen',
    this.frameStyle = 'Platform',
  });

  /// Indicates whether the product currently has a discount.
  bool get hasDiscount =>
      originalPrice != null && originalPrice! > price;

  /// Discount percentage rounded to the nearest integer.
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
        mattressSize,
        frameStyle,
      ];
}

/// Represents physical dimensions for a bedroom product.
class BedroomDimensions extends Equatable {
  /// Width in centimeters.
  final double width;

  /// Height in centimeters.
  final double height;

  /// Depth in centimeters.
  final double depth;

  /// Weight in kilograms.
  final double weight;

  /// Headboard height when applicable.
  final double? headboardHeight;

  const BedroomDimensions({
    required this.width,
    required this.height,
    required this.depth,
    required this.weight,
    this.headboardHeight,
  });

  /// Formatted string for display.
  String get formatted =>
      '${width}W x ${height}H x ${depth}D cm ${headboardHeight != null ? '· Headboard ${headboardHeight}H cm' : ''}';

  @override
  List<Object?> get props => [width, height, depth, weight, headboardHeight];
}
