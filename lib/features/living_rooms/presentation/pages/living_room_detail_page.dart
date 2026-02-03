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
import '../../domain/entities/living_room_entity.dart';
import '../providers/providers.dart';
import '../state/state.dart';

/// Living room detail page.
///
/// Displays detailed information about a single living room item.
/// Allows adding to cart with quantity selection.
class LivingRoomDetailPage extends ConsumerStatefulWidget {
  final String livingRoomId;

  const LivingRoomDetailPage({
    super.key,
    required this.livingRoomId,
  });

  @override
  ConsumerState<LivingRoomDetailPage> createState() => _LivingRoomDetailPageState();
}

class _LivingRoomDetailPageState extends ConsumerState<LivingRoomDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(livingRoomDetailProvider(widget.livingRoomId).notifier)
          .loadLivingRoom(widget.livingRoomId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(livingRoomDetailProvider(widget.livingRoomId));

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

  Widget _buildBody(LivingRoomDetailState state) {
    return switch (state) {
      LivingRoomDetailInitial() => const core.LoadingWidget(),
      LivingRoomDetailLoading() => const core.LoadingWidget(message: 'Loading...'),
      LivingRoomDetailLoaded(:final livingRoom, :final quantity, :final totalPrice) =>
        _buildDetailContent(
          room: livingRoom,
          quantity: quantity,
          totalPrice: totalPrice,
        ),
      LivingRoomDetailError(:final message) => core.ErrorWidget(
          message: message,
          onRetry: () => ref
              .read(livingRoomDetailProvider(widget.livingRoomId).notifier)
              .loadLivingRoom(widget.livingRoomId),
        ),
    };
  }

  Widget _buildDetailContent({
    required LivingRoom room,
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
                _buildImageSection(room),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: AppText(
                          text: _formatText(room.category),
                          variant: AppTextVariant.labelSmall,
                          color: AppColors.accent,
                        ),
                      ),
                      const SizedBox(height: 12),
                      AppText(
                        text: room.name,
                        variant: AppTextVariant.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 20,
                            color: Colors.amber[700],
                          ),
                          const SizedBox(width: 4),
                          AppText(
                            text: room.rating.toStringAsFixed(1),
                            variant: AppTextVariant.titleSmall,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(width: 4),
                          AppText(
                            text: '(${room.reviewCount} reviews)',
                            variant: AppTextVariant.bodySmall,
                            color: AppColors.textSecondary,
                          ),
                          const Spacer(),
                          if (!room.inStock)
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AppText.price(amount: room.price),
                          if (room.hasDiscount) ...[
                            const SizedBox(width: 8),
                            AppText.originalPrice(amount: room.originalPrice!),
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
                                text: '-${room.discountPercentage}%',
                                variant: AppTextVariant.labelSmall,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 24),
                      const AppText(
                        text: 'Description',
                        variant: AppTextVariant.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      AppText(
                        text: room.description,
                        variant: AppTextVariant.bodyMedium,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(height: 24),
                      const AppText(
                        text: 'Specifications',
                        variant: AppTextVariant.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      _buildSpecRow('Material', _formatText(room.material)),
                      _buildSpecRow('Color', _formatText(room.color)),
                      _buildSpecRow('Dimensions', room.dimensions.formatted),
                      const SizedBox(height: 24),
                      if (room.tags.isNotEmpty) ...[
                        const AppText(
                          text: 'Tags',
                          variant: AppTextVariant.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: room.tags.map((tag) {
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
        _buildBottomBar(room, quantity, totalPrice),
      ],
    );
  }

  Widget _buildImageSection(LivingRoom room) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: CachedNetworkImage(
            imageUrl: room.imageUrl,
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

  Widget _buildBottomBar(LivingRoom room, int quantity, double totalPrice) {
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
                            .read(livingRoomDetailProvider(widget.livingRoomId).notifier)
                            .updateQuantity(quantity - 1)
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
                        .read(livingRoomDetailProvider(widget.livingRoomId).notifier)
                        .updateQuantity(quantity + 1),
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
            Expanded(
              child: AppButton(
                label: 'Add to Cart - \$${totalPrice.toStringAsFixed(2)}',
                onPressed: room.inStock
                    ? () {
                        _showAddToCartSnackbar(room.name, quantity);
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

  String _formatText(String text) {
    if (text.isEmpty) return text;
    return text.substring(0, 1).toUpperCase() + text.substring(1);
  }

  void _showAddToCartSnackbar(String name, int quantity) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$quantity x $name added to cart'),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'View Cart',
          onPressed: () => context.push(AppRoutes.cart),
        ),
      ),
    );
  }
}