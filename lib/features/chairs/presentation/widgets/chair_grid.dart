import 'package:flutter/material.dart';

import '../../../../core/widgets/product_card.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/chair_entity.dart';

/// Grid widget for displaying chairs.
///
/// Features:
/// - Responsive grid layout
/// - Empty state handling
/// - Tap and action callbacks
class ChairGrid extends StatelessWidget {
  final List<Chair> chairs;
  final ValueChanged<Chair> onChairTap;
  final ValueChanged<Chair>? onAddToCart;
  final ValueChanged<Chair>? onWishlistToggle;
  final Set<String>? wishlistedIds;
  final EdgeInsets padding;
  final int crossAxisCount;
  final double childAspectRatio;

  const ChairGrid({
    super.key,
    required this.chairs,
    required this.onChairTap,
    this.onAddToCart,
    this.onWishlistToggle,
    this.wishlistedIds,
    this.padding = const EdgeInsets.all(16),
    this.crossAxisCount = 2,
    this.childAspectRatio = 0.65,
  });

  @override
  Widget build(BuildContext context) {
    if (chairs.isEmpty) {
      return const EmptyWidget(
        message: 'No chairs found',
        subtitle: 'Try adjusting your filters',
        icon: Icons.chair_outlined,
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
      itemCount: chairs.length,
      itemBuilder: (context, index) {
        final chair = chairs[index];
        return ProductCard(
          name: chair.name,
          description: chair.description,
          price: chair.price,
          originalPrice: chair.originalPrice,
          imageUrl: chair.imageUrl,
          rating: chair.rating,
          reviewCount: chair.reviewCount,
          inStock: chair.inStock,
          isWishlisted: wishlistedIds?.contains(chair.id) ?? false,
          onTap: () => onChairTap(chair),
          onAddToCart: onAddToCart != null ? () => onAddToCart!(chair) : null,
          onWishlistToggle:
              onWishlistToggle != null ? () => onWishlistToggle!(chair) : null,
        );
      },
    );
  }
}

/// Shimmer loading widget for chair grid.
class ChairGridShimmer extends StatelessWidget {
  final int itemCount;
  final int crossAxisCount;
  final EdgeInsets padding;

  const ChairGridShimmer({
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
        return const _ChairCardShimmer();
      },
    );
  }
}

/// Shimmer widget for a single chair card.
class _ChairCardShimmer extends StatelessWidget {
  const _ChairCardShimmer();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image shimmer
          AspectRatio(
            aspectRatio: 1.2,
            child: ShimmerWidget(
              width: double.infinity,
              height: double.infinity,
              borderRadius: 0,
            ),
          ),
          // Content shimmer
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerWidget(
                    width: double.infinity,
                    height: 16,
                  ),
                  const SizedBox(height: 8),
                  ShimmerWidget(
                    width: 100,
                    height: 12,
                  ),
                  const Spacer(),
                  ShimmerWidget(
                    width: 80,
                    height: 20,
                  ),
                  const SizedBox(height: 8),
                  ShimmerWidget(
                    width: double.infinity,
                    height: 36,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
