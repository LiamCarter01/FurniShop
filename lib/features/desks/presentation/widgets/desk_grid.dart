import 'package:flutter/material.dart';

import '../../../../core/widgets/product_card.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/desk_entity.dart';

/// Grid widget for displaying desks.
///
/// Features:
/// - Responsive grid layout
/// - Empty state handling
/// - Tap and action callbacks
class DeskGrid extends StatelessWidget {
  final List<Desk> desks;
  final ValueChanged<Desk> onDeskTap;
  final ValueChanged<Desk>? onAddToCart;
  final ValueChanged<Desk>? onWishlistToggle;
  final Set<String>? wishlistedIds;
  final EdgeInsets padding;
  final int crossAxisCount;
  final double childAspectRatio;

  const DeskGrid({
    super.key,
    required this.desks,
    required this.onDeskTap,
    this.onAddToCart,
    this.onWishlistToggle,
    this.wishlistedIds,
    this.padding = const EdgeInsets.all(16),
    this.crossAxisCount = 2,
    this.childAspectRatio = 0.65,
  });

  @override
  Widget build(BuildContext context) {
    if (desks.isEmpty) {
      return const EmptyWidget(
        message: 'No desks found',
        subtitle: 'Try adjusting your filters',
        icon: Icons.desktop_windows_outlined,
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
      itemCount: desks.length,
      itemBuilder: (context, index) {
        final desk = desks[index];
        return ProductCard(
          name: desk.name,
          description: desk.description,
          price: desk.price,
          originalPrice: desk.originalPrice,
          imageUrl: desk.imageUrl,
          rating: desk.rating,
          reviewCount: desk.reviewCount,
          inStock: desk.inStock,
          isWishlisted: wishlistedIds?.contains(desk.id) ?? false,
          onTap: () => onDeskTap(desk),
          onAddToCart: onAddToCart != null ? () => onAddToCart!(desk) : null,
          onWishlistToggle:
              onWishlistToggle != null ? () => onWishlistToggle!(desk) : null,
        );
      },
    );
  }
}

/// Shimmer loading widget for desk grid.
class DeskGridShimmer extends StatelessWidget {
  final int itemCount;
  final int crossAxisCount;
  final EdgeInsets padding;

  const DeskGridShimmer({
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
        return const _DeskCardShimmer();
      },
    );
  }
}

class _DeskCardShimmer extends StatelessWidget {
  const _DeskCardShimmer();

  @override
  Widget build(BuildContext context) {
    return Card(
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
                children: [
                  ShimmerWidget(width: double.infinity, height: 16),
                  const SizedBox(height: 8),
                  ShimmerWidget(width: 100, height: 12),
                  const Spacer(),
                  ShimmerWidget(width: 80, height: 20),
                  const SizedBox(height: 8),
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
