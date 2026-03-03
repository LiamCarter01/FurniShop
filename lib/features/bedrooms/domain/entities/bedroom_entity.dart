import 'package:equatable/equatable.dart';

/// Bedroom entity representing a bedroom product.
///
/// Contains business-relevant properties that describe each bedroom set.
class Bedroom extends Equatable {
  /// Unique identifier for the bedroom product.
  final String id;

  /// Display name.
  final String name;

  /// Product description shown to users.
  final String description;

  /// Current price.
  final double price;

  /// Original price when discounted.
  final double? originalPrice;

  /// Image used throughout the catalog.
  final String imageUrl;

  /// Average rating (0-5).
  final double rating;

  /// Number of customer reviews.
  final int reviewCount;

  /// Whether the item is currently in stock.
  final bool inStock;

  /// Product category (e.g., 'beds', 'storage', 'lighting').
  final String category;

  /// Primary material (e.g., 'solid wood', 'metal', 'upholstered').
  final String material;

  /// Dominant color description.
  final String color;

  /// Set dimensions and weight details.
  final BedroomDimensions dimensions;

  /// Whether this item should be highlighted to customers.
  final bool isFeatured;

  /// Metadata tags for filtering/searching.
  final List<String> tags;

  /// Supported bed size (e.g., 'queen', 'king', 'twin').
  final String bedSize;

  /// Design style keyword (e.g., 'modern', 'mid-century').
  final String designStyle;

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
    required this.bedSize,
    required this.designStyle,
  });

  /// Indicates if the bedroom item currently has a discount.
  bool get hasDiscount => originalPrice != null && originalPrice! > price;

  /// Computed discount percentage.
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
        bedSize,
        designStyle,
      ];
}

/// Dimensions data for a bedroom product.
class BedroomDimensions extends Equatable {
  /// Width in centimeters.
  final double width;

  /// Height in centimeters.
  final double height;

  /// Depth in centimeters.
  final double depth;

  /// Weight in kilograms.
  final double weight;

  const BedroomDimensions({
    required this.width,
    required this.height,
    required this.depth,
    required this.weight,
  });

  /// Prettified dimensions string for display.
  String get formatted =>
      '${width}W x ${height}H x ${depth}D cm • ${weight}kg';

  @override
  List<Object> get props => [width, height, depth, weight];
}
