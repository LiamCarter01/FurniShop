import 'package:equatable/equatable.dart';

/// Chair entity representing a chair product.
///
/// This is the domain layer representation of a chair.
/// It contains only business-relevant properties.
class Chair extends Equatable {
  /// Unique identifier for the chair.
  final String id;

  /// Chair name/title.
  final String name;

  /// Detailed description.
  final String description;

  /// Price in dollars.
  final double price;

  /// Original price before discount (if any).
  final double? originalPrice;

  /// Image URL for the chair.
  final String imageUrl;

  /// Product rating (0-5).
  final double rating;

  /// Number of customer reviews.
  final int reviewCount;

  /// Whether the chair is in stock.
  final bool inStock;

  /// Chair category (e.g., 'office', 'dining', 'lounge').
  final String category;

  /// Chair material (e.g., 'leather', 'fabric', 'mesh').
  final String material;

  /// Chair color.
  final String color;

  /// Chair dimensions.
  final ChairDimensions dimensions;

  /// Whether the chair is featured.
  final bool isFeatured;

  /// Product tags for filtering.
  final List<String> tags;

  const Chair({
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

  /// Check if chair has a discount.
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

/// Chair dimensions.
class ChairDimensions extends Equatable {
  final double width;
  final double height;
  final double depth;
  final double weight;

  const ChairDimensions({
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
