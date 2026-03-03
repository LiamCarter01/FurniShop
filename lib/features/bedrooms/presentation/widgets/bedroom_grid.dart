import 'package:flutter/material.dart';

import '../../../../core/widgets/product_card.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/bedroom_entity.dart';

/// Grid widget for displaying bedrooms.
///
/// Provides responsive layout, empty-state messaging, and action callbacks.
class BedroomGrid extends StatelessWidget {
  /// Bedrooms to display.
  final List<Bedroom> bedrooms;

  /// Tap callback when a bedroom card is pressed.
  final ValueChanged<Bedroom> onBedroomTap;

  /// Optional add-to-cart callback.
  final ValueChanged<Bedroom>? onAddToCart;

  /// Optional wishlist toggle callback.
  final ValueChanged<Bedroom>? onWishlistToggle;

  /// Set of wishlisted IDs for UI state.
  final Set<String>? wishlistedIds;

  /// Padding around the grid.
  final EdgeInsets padding;

  /// Number of columns in the grid.
  final int crossAxisCount;

  /// Aspect ratio for the grid's children.
  final double childAspectRatio;

  const BedroomGrid({
    super.key,
    required this.bedrooms,
    required this.onBedroomTap,
    this.onAddToCart,
    this.onWishlistToggle,
    this.wishlistedIds,
    this.padding = const EdgeInsets.all(16),
    this.crossAxisCount = 2,
    this.childAspectRatio = 0.65,
  });

  @override
  Widget build(BuildContext context) {
    if (bedrooms.isEmpty) {
      return const EmptyWidget(
        message: 'No bedrooms found',
        subtitle: 'Try a different filter or refresh the list.',
        icon: Icons.bed_outlined,
      );
    }

    return GridView.builder(
      padding: padding,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: bedrooms.length,
      itemBuilder: (context, index) {
        final bedroom = bedrooms[index];
        return ProductCard(
          name: bedroom.name,
          description: bedroom.description,
          price: bedroom.price,
          originalPrice: bedroom.originalPrice,
          imageUrl: bedroom.imageUrl,
          rating: bedroom.rating,
          reviewCount: bedroom.reviewCount,
          inStock: bedroom.inStock,
          isWishlisted: wishlistedIds?.contains(bedroom.id) ?? false,
          onTap: () => onBedroomTap(bedroom),
          onAddToCart: onAddToCart != null ? () => onAddToCart!(bedroom) : null,
          onWishlistToggle: onWishlistToggle != null
              ? () => onWishlistToggle!(bedroom)
              : null,
        );
      },
    );
  }
}

/// Shimmer placeholder for the bedroom grid while data loads.
class BedroomGridShimmer extends StatelessWidget {
  /// Number of shimmer cards to display.
  final int itemCount;

  /// Number of columns to layout.
  final int crossAxisCount;

  /// Padding around the grid.
  final EdgeInsets padding;

  const BedroomGridShimmer({
    super.key,
    this.itemCount = 6,
    this.crossAxisCount = 2,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: padding,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.65,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) => const _BedroomCardShimmer(),
    );
  }
}

/// Single card shimmer for the bedroom grid.
class _BedroomCardShimmer extends StatelessWidget {
  const _BedroomCardShimmer();

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.2,
            child: ShimmerWidget(
              width: double.infinity,
              height: double.infinity,
              borderRadius: 0,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ShimmerWidget(width: double.infinity, height: 16),
                  SizedBox(height: 8),
                  ShimmerWidget(width: 100, height: 12),
                  Spacer(),
                  ShimmerWidget(width: 80, height: 20),
                  SizedBox(height: 8),
                  ShimmerWidget(width: double.infinity, height: 36),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
