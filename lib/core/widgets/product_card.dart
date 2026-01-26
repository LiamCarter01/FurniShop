import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'app_button.dart';
import 'app_text.dart';

/// A product card widget for displaying furniture items.
///
/// Features:
/// - Product image with caching
/// - Product name and description
/// - Price display with optional discount
/// - Add to cart button
/// - Favorite/wishlist toggle
/// - Loading and error states for image
///
/// Usage:
/// ```dart
/// ProductCard(
///   name: 'Modern Chair',
///   description: 'Comfortable office chair',
///   price: 299.99,
///   imageUrl: 'https://example.com/chair.jpg',
///   onTap: () => navigateToDetails(),
///   onAddToCart: () => addToCart(),
/// )
/// ```
class ProductCard extends StatelessWidget {
  /// Product name.
  final String name;

  /// Product description.
  final String? description;

  /// Product price.
  final double price;

  /// Original price (for showing discount).
  final double? originalPrice;

  /// Product image URL.
  final String? imageUrl;

  /// Product rating (0-5).
  final double? rating;

  /// Number of reviews.
  final int? reviewCount;

  /// Whether product is in stock.
  final bool inStock;

  /// Whether product is in wishlist.
  final bool isWishlisted;

  /// Callback when card is tapped.
  final VoidCallback? onTap;

  /// Callback when add to cart is pressed.
  final VoidCallback? onAddToCart;

  /// Callback when wishlist button is pressed.
  final VoidCallback? onWishlistToggle;

  /// Card width (for grid layouts).
  final double? width;

  /// Card height.
  final double? height;

  /// Whether to show compact version.
  final bool compact;

  const ProductCard({
    super.key,
    required this.name,
    this.description,
    required this.price,
    this.originalPrice,
    this.imageUrl,
    this.rating,
    this.reviewCount,
    this.inStock = true,
    this.isWishlisted = false,
    this.onTap,
    this.onAddToCart,
    this.onWishlistToggle,
    this.width,
    this.height,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: compact ? _buildCompactLayout() : _buildFullLayout(),
        ),
      ),
    );
  }

  Widget _buildFullLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image section
        _buildImageSection(),

        // Content section
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                AppText(
                  text: name,
                  variant: AppTextVariant.titleMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 4),

                // Description
                if (description != null) ...[
                  AppText(
                    text: description!,
                    variant: AppTextVariant.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(height: 8),
                ],

                // Rating
                if (rating != null) ...[
                  _buildRating(),
                  const SizedBox(height: 8),
                ],

                const Spacer(),

                // Price row
                _buildPriceRow(),

                const SizedBox(height: 8),

                // Add to cart button
                if (onAddToCart != null)
                  AppButton(
                    label: inStock ? 'Add to Cart' : 'Out of Stock',
                    onPressed: inStock ? onAddToCart : null,
                    variant: AppButtonVariant.accent,
                    size: AppButtonSize.small,
                    fullWidth: true,
                    leadingIcon: inStock ? Icons.shopping_cart_outlined : null,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompactLayout() {
    return Row(
      children: [
        // Image
        SizedBox(
          width: 100,
          height: 100,
          child: _buildImage(),
        ),

        // Content
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  text: name,
                  variant: AppTextVariant.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                _buildPriceRow(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageSection() {
    return AspectRatio(
      aspectRatio: 1.2,
      child: Stack(
        children: [
          // Image
          Positioned.fill(child: _buildImage()),

          // Wishlist button
          if (onWishlistToggle != null)
            Positioned(
              top: 8,
              right: 8,
              child: _buildWishlistButton(),
            ),

          // Out of stock overlay
          if (!inStock)
            Positioned.fill(
              child: Container(
                color: Colors.black.withValues(alpha: 0.5),
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Out of Stock',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),

          // Discount badge
          if (originalPrice != null && originalPrice! > price)
            Positioned(
              top: 8,
              left: 8,
              child: _buildDiscountBadge(),
            ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return Container(
        color: AppColors.surfaceVariant,
        child: const Icon(
          Icons.image_outlined,
          size: 48,
          color: AppColors.textHint,
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl!,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        color: AppColors.surfaceVariant,
        child: const Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        color: AppColors.surfaceVariant,
        child: const Icon(
          Icons.broken_image_outlined,
          size: 48,
          color: AppColors.textHint,
        ),
      ),
    );
  }

  Widget _buildWishlistButton() {
    return Material(
      color: Colors.white.withValues(alpha: 0.9),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onWishlistToggle,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            isWishlisted ? Icons.favorite : Icons.favorite_border,
            size: 20,
            color: isWishlisted ? AppColors.error : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildDiscountBadge() {
    final discountPercent =
        ((originalPrice! - price) / originalPrice! * 100).round();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '-$discountPercent%',
        style: AppTypography.labelSmall.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildRating() {
    return Row(
      children: [
        Icon(
          Icons.star,
          size: 16,
          color: Colors.amber[700],
        ),
        const SizedBox(width: 4),
        AppText(
          text: rating!.toStringAsFixed(1),
          variant: AppTextVariant.labelSmall,
          fontWeight: FontWeight.bold,
        ),
        if (reviewCount != null) ...[
          const SizedBox(width: 4),
          AppText(
            text: '($reviewCount)',
            variant: AppTextVariant.labelSmall,
            color: AppColors.textHint,
          ),
        ],
      ],
    );
  }

  Widget _buildPriceRow() {
    return Row(
      children: [
        AppText.price(amount: price),
        if (originalPrice != null && originalPrice! > price) ...[
          const SizedBox(width: 8),
          AppText.originalPrice(amount: originalPrice!),
        ],
      ],
    );
  }
}
