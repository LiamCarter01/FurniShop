import 'package:equatable/equatable.dart';

/// Bedroom entity representing a bedroom product.
///
/// Contains only the business-relevant fields for a bedroom item.
class Bedroom extends Equatable {
  /// Unique identifier for the bedroom item.
  final String id;

  /// Bedroom item name/title.
  final String name;

  /// Detailed description of the bedroom item.
  final String description;

  /// Current price in dollars.
  final double price;

  /// Original price before any discount (optional).
  final double? originalPrice;

  /// Image URL for the bedroom item.
  final String imageUrl;

  /// Product rating (0-5).
  final double rating;

  /// Number of customer reviews.
  final int reviewCount;

  /// Whether the bedroom item is currently in stock.
  final bool inStock;

  /// Bedroom category (e.g., 'set', 'storage', 'bed_frame').
  final String category;

  /// Material description (e.g., 'wood', 'metal').
  final String material;

  /// Color description.
  final String color;

  /// Item dimensions.
  final BedroomDimensions dimensions;

  /// Whether the bedroom item is featured.
  final bool isFeatured;

  /// Tags for filtering.
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

  /// Whether the item has a discount applied.
  bool get hasDiscount => originalPrice != null && originalPrice! > price;

  /// Percentage off from the original price.
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

/// Bedroom dimensions.
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
  String get formatted => '${width}W x ${height}H x ${depth}D cm, ${weight}kg';

  @override
  List<Object> get props => [width, height, depth, weight];
}
