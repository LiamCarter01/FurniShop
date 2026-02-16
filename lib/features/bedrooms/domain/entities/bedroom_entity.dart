import 'package:equatable/equatable.dart';

/// Bedroom entity representing a bedroom product.
///
/// Contains only the business-relevant properties for a bedroom product.
class Bedroom extends Equatable {
  /// Unique identifier for the bedroom product.
  final String id;

  /// Product name.
  final String name;

  /// Detailed description of the product.
  final String description;

  /// Current price of the product.
  final double price;

  /// Original price before discount, if available.
  final double? originalPrice;

  /// Image URL for the product.
  final String imageUrl;

  /// Product rating (0-5).
  final double rating;

  /// Number of reviews for the product.
  final int reviewCount;

  /// Whether the product is in stock.
  final bool inStock;

  /// Product category (e.g., bedroom, dresser, mattress).
  final String category;

  /// Material of the product (e.g., wood, metal, fabric).
  final String material;

  /// Color of the product.
  final String color;

  /// Product dimensions.
  final BedroomDimensions dimensions;

  /// Whether the product should appear in featured lists.
  final bool isFeatured;

  /// Tags to support filtering/searching.
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

  /// Returns true when the product has a discount.
  bool get hasDiscount => originalPrice != null && originalPrice! > price;

  /// Discount percentage rounded to an integer.
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

/// Bedroom dimensions representation.
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

  /// Returns a formatted string describing the dimensions.
  String get formatted =>
      '${width}W x ${height}H x ${depth}D cm, ${weight}kg';

  @override
  List<Object> get props => [width, height, depth, weight];
}
