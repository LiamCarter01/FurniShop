import 'package:flutter/material.dart';

import '../../../../core/widgets/product_card.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/bedroom_entity.dart';

/// Grid widget for displaying bedroom products.
///
/// Supports empty states, loading shimmers, and user interactions.
class BedroomGrid extends StatelessWidget {
  final List<Bedroom> bedrooms;
  final ValueChanged<Bedroom> onBedroomTap;
  final ValueChanged<Bedroom>? onAddToCart;
  final ValueChanged<Bedroom>? onWishlistToggle;
  final Set<String>? wishlistedIds;
  final EdgeInsets padding;
  final int crossAxisCount;
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
        subtitle: 'Try changing your filters or refreshing the list',
        icon: Icons.bedroom_parent_outlined,
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
          onWishlistToggle:
              onWishlistToggle != null ? () => onWishlistToggle!(bedroom) : null,
        );
      },
    );
  }
}

/// Shimmer placeholder for the bedroom grid.
class BedroomGridShimmer extends StatelessWidget {
  final int itemCount;
  final int crossAxisCount;
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
      itemBuilder: (context, index) {
        return const _BedroomCardShimmer();
      },
    );
  }
}

class _BedroomCardShimmer extends StatelessWidget {
  const _BedroomCardShimmer();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(4),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 16,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 8),
                Container(
                  height: 12,
                  width: 120,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 12),
                Container(
                  height: 20,
                  width: 80,
                  color: Colors.grey.shade300,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
