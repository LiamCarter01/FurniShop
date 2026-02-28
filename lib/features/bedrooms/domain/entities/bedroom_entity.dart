import 'package:equatable/equatable.dart';

/// Bedroom entity representing a bedroom product in the catalog.
///
/// This class keeps only business-critical properties for bedrooms.
class Bedroom extends Equatable {
  /// Unique identifier for the bedroom product.
  final String id;

  /// Product name/title.
  final String name;

  /// Detailed description.
  final String description;

  /// Current price in USD.
  final double price;

  /// Original price for discount calculation.
  final double? originalPrice;

  /// Image URL used on the bedroom grid.
  final String imageUrl;

  /// Average rating (0-5).
  final double rating;

  /// Number of reviews.
  final int reviewCount;

  /// Availability flag.
  final bool inStock;

  /// Product category (e.g., "bed", "nightstand").
  final String category;

  /// Material description (e.g., "walnut", "upholstered").
  final String material;

  /// Product color.
  final String color;

  /// Product dimensions.
  final BedroomDimensions dimensions;

  /// Whether the product is featured.
  final bool isFeatured;

  /// Tags for search and filtering.
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

  /// Whether the bedroom product is currently discounted.
  bool get hasDiscount => originalPrice != null && originalPrice! > price;

  /// Discount percentage rounded to the nearest whole number.
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

/// Dimensions for bedroom furniture items.
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
