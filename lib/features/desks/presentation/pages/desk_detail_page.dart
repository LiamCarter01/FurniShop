import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/navigation/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/state_widgets.dart' as core;
import '../../domain/entities/desk_entity.dart';
import '../providers/providers.dart';
import '../state/state.dart';

/// Desk detail page.
///
/// Displays detailed information about a single desk.
/// Allows adding to cart with quantity selection.
class DeskDetailPage extends ConsumerStatefulWidget {
  final String deskId;

  const DeskDetailPage({
    super.key,
    required this.deskId,
  });

  @override
  ConsumerState<DeskDetailPage> createState() => _DeskDetailPageState();
}

class _DeskDetailPageState extends ConsumerState<DeskDetailPage> {
  @override
  void initState() {
    super.initState();
    // Load desk details when page is first displayed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(deskDetailProvider(widget.deskId).notifier).loadDesk(
            widget.deskId,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(deskDetailProvider(widget.deskId));

    return AppScaffold(
      title: '',
      transparentAppBar: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.share_outlined),
          onPressed: () {
            // TODO: Implement share
          },
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined),
          onPressed: () => context.push(AppRoutes.cart),
        ),
      ],
      body: _buildBody(state),
    );
  }

  Widget _buildBody(DeskDetailState state) {
    return switch (state) {
      DeskDetailInitial() => const core.LoadingWidget(),
      DeskDetailLoading() => const core.LoadingWidget(message: 'Loading...'),
      DeskDetailLoaded(:final desk, :final quantity, :final totalPrice) =>
        _buildDetailContent(
          desk: desk,
          quantity: quantity,
          totalPrice: totalPrice,
        ),
      DeskDetailError(:final message) => core.ErrorWidget(
          message: message,
          onRetry: () => ref
              .read(deskDetailProvider(widget.deskId).notifier)
              .loadDesk(widget.deskId),
        ),
    };
  }

  Widget _buildDetailContent({
    required Desk desk,
    required int quantity,
    required double totalPrice,
  }) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                _buildImageSection(desk),

                // Content
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withAlpha(25),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: AppText(
                          text: _formatCategory(desk.category),
                          variant: AppTextVariant.labelSmall,
                          color: AppColors.accent,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Name
                      AppText(
                        text: desk.name,
                        variant: AppTextVariant.headlineMedium,
                      ),

                      const SizedBox(height: 8),

                      // Rating
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 20,
                            color: Colors.amber[700],
                          ),
                          const SizedBox(width: 4),
                          AppText(
                            text: desk.rating.toStringAsFixed(1),
                            variant: AppTextVariant.titleSmall,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(width: 4),
                          AppText(
                            text: '(${desk.reviewCount} reviews)',
                            variant: AppTextVariant.bodySmall,
                            color: AppColors.textSecondary,
                          ),
                          const Spacer(),
                          if (!desk.inStock)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.error,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const AppText(
                                text: 'Out of Stock',
                                variant: AppTextVariant.labelSmall,
                                color: Colors.white,
                              ),
                            ),
                        ],
                      ),

                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 16),

                      // Price
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AppText.price(amount: desk.price),
                          if (desk.hasDiscount) ...[
                            const SizedBox(width: 8),
                            AppText.originalPrice(amount: desk.originalPrice!),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.success,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: AppText(
                                text: '-\${desk.discountPercentage}%',
                                variant: AppTextVariant.labelSmall,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Description
                      const AppText(
                        text: 'Description',
                        variant: AppTextVariant.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      AppText(
                        text: desk.description,
                        variant: AppTextVariant.bodyMedium,
                        color: AppColors.textSecondary,
                      ),

                      const SizedBox(height: 24),

                      // Specifications
                      const AppText(
                        text: 'Specifications',
                        variant: AppTextVariant.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      _buildSpecRow('Material', _formatCategory(desk.material)),
                      _buildSpecRow('Color', _formatCategory(desk.color)),
                      _buildSpecRow('Dimensions', desk.dimensions.formatted),

                      const SizedBox(height: 24),

                      // Tags
                      if (desk.tags.isNotEmpty) ...[
                        const AppText(
                          text: 'Tags',
                          variant: AppTextVariant.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: desk.tags.map((tag) {
                            return Chip(
                              label: Text(tag),
                              backgroundColor: AppColors.surfaceVariant,
                              padding: EdgeInsets.zero,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            );
                          }).toList(),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Bottom bar with quantity and add to cart
        _buildBottomBar(desk, quantity, totalPrice),
      ],
    );
  }

  Widget _buildImageSection(Desk desk) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: CachedNetworkImage(
            imageUrl: desk.imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: AppColors.surfaceVariant,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: AppColors.surfaceVariant,
              child: const Icon(
                Icons.broken_image_outlined,
                size: 64,
                color: AppColors.textHint,
              ),
            ),
          ),
        ),
        // Wishlist button
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton.small(
            heroTag: 'wishlist',
            onPressed: () {
              // TODO: Implement wishlist
            },
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.favorite_border,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSpecRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: AppText(
              text: label,
              variant: AppTextVariant.bodyMedium,
              color: AppColors.textSecondary,
            ),
          ),
          Expanded(
            child: AppText(
              text: value,
              variant: AppTextVariant.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(Desk desk, int quantity, double totalPrice) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Quantity selector
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: quantity > 1
                        ? () => ref
                            .read(deskDetailProvider(widget.deskId).notifier)
                            .decrementQuantity()
                        : null,
                    icon: const Icon(Icons.remove),
                    iconSize: 20,
                    constraints: const BoxConstraints(
                      minWidth: 40,
                      minHeight: 40,
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    child: Center(
                      child: AppText(
                        text: quantity.toString(),
                        variant: AppTextVariant.titleMedium,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => ref
                        .read(deskDetailProvider(widget.deskId).notifier)
                        .incrementQuantity(),
                    icon: const Icon(Icons.add),
                    iconSize: 20,
                    constraints: const BoxConstraints(
                      minWidth: 40,
                      minHeight: 40,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 16),

            // Add to cart button
            Expanded(
              child: AppButton(
                label: 'Add to Cart - \$${totalPrice.toStringAsFixed(2)}',
                onPressed: desk.inStock
                    ? () {
                        _showAddToCartSnackbar(desk.name, quantity);
                      }
                    : null,
                variant: AppButtonVariant.accent,
                size: AppButtonSize.large,
                leadingIcon: Icons.shopping_cart_outlined,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatCategory(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  void _showAddToCartSnackbar(String productName, int quantity) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$quantity x $productName added to cart'),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'View Cart',
          onPressed: () => context.push(AppRoutes.cart),
        ),
      ),
    );
  }
}