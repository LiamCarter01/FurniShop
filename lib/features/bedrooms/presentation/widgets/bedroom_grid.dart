import 'package:flutter/material.dart';

import '../../../../core/widgets/product_card.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/bedroom_entity.dart';

/// Grid that displays bedrooms in a responsive layout.
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
        subtitle: 'Try adjusting your filters',
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
          onAddToCart:
              onAddToCart != null ? () => onAddToCart!(bedroom) : null,
          onWishlistToggle: onWishlistToggle != null
              ? () => onWishlistToggle!(bedroom)
              : null,
        );
      },
    );
  }
}

/// Loading shimmer for bedrooms.
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

/// Shimmer card placeholder for a single bedroom.
class _BedroomCardShimmer extends StatelessWidget {
  const _BedroomCardShimmer();

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
