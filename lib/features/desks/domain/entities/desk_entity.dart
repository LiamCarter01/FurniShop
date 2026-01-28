import 'package:equatable/equatable.dart';

/// Desk entity representing a desk product.
///
/// This is the domain layer representation of a desk.
/// It contains only business-relevant properties.
class Desk extends Equatable {
  /// Unique identifier for the desk.
  final String id;

  /// Desk name/title.
  final String name;

  /// Detailed description.
  final String description;

  /// Price in dollars.
  final double price;

  /// Original price before discount (if any).
  final double? originalPrice;

  /// Image URL for the desk.
  final String imageUrl;

  /// Product rating (0-5).
  final double rating;

  /// Number of customer reviews.
  final int reviewCount;

  /// Whether the desk is in stock.
  final bool inStock;

  /// Desk category (e.g., 'office', 'writing', 'standing').
  final String category;

  /// Desk material (e.g., 'wood', 'metal', 'glass').
  final String material;

  /// Desk color.
  final String color;

  /// Desk dimensions.
  final DeskDimensions dimensions;

  /// Whether the desk is featured.
  final bool isFeatured;

  /// Product tags for filtering.
  final List<String> tags;

  const Desk({
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

  /// Check if desk has a discount.
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

/// Desk dimensions.
class DeskDimensions extends Equatable {
  final double width;
  final double height;
  final double depth;
  final double weight;

  const DeskDimensions({
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
