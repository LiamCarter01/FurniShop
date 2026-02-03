import 'package:flutter/material.dart';

import '../../../../core/widgets/product_card.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/living_room_entity.dart';

/// Grid widget for displaying living rooms.
///
/// Features:
/// - Responsive grid layout
/// - Empty state handling
/// - Tap and action callbacks
class LivingRoomGrid extends StatelessWidget {
  final List<LivingRoom> rooms;
  final ValueChanged<LivingRoom> onRoomTap;
  final ValueChanged<LivingRoom>? onAddToCart;
  final ValueChanged<LivingRoom>? onWishlistToggle;
  final Set<String>? wishlistedIds;
  final EdgeInsets padding;
  final int crossAxisCount;
  final double childAspectRatio;

  const LivingRoomGrid({
    super.key,
    required this.rooms,
    required this.onRoomTap,
    this.onAddToCart,
    this.onWishlistToggle,
    this.wishlistedIds,
    this.padding = const EdgeInsets.all(16),
    this.crossAxisCount = 2,
    this.childAspectRatio = 0.65,
  });

  @override
  Widget build(BuildContext context) {
    if (rooms.isEmpty) {
      return const EmptyWidget(
        message: 'No living rooms found',
        subtitle: 'Try adjusting your filters',
        icon: Icons.weekend_outlined,
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
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        final room = rooms[index];
        return ProductCard(
          name: room.name,
          description: room.description,
          price: room.price,
          originalPrice: room.originalPrice,
          imageUrl: room.imageUrl,
          rating: room.rating,
          reviewCount: room.reviewCount,
          inStock: room.inStock,
          isWishlisted: wishlistedIds?.contains(room.id) ?? false,
          onTap: () => onRoomTap(room),
          onAddToCart: onAddToCart != null ? () => onAddToCart!(room) : null,
          onWishlistToggle: onWishlistToggle != null ? () => onWishlistToggle!(room) : null,
        );
      },
    );
  }
}

/// Shimmer loading widget for living room grid.
class LivingRoomGridShimmer extends StatelessWidget {
  final int itemCount;
  final int crossAxisCount;
  final EdgeInsets padding;

  const LivingRoomGridShimmer({
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
        return const _LivingRoomCardShimmer();
      },
    );
  }
}

/// Shimmer widget for a single living room card.
class _LivingRoomCardShimmer extends StatelessWidget {
  const _LivingRoomCardShimmer();

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