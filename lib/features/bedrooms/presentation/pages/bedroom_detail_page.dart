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
import '../../domain/entities/bedroom_entity.dart';
import '../providers/providers.dart';
import '../state/state.dart';

/// Bedroom detail page.
///
/// Displays detailed information about a single bedroom item.
/// Allows adding to cart with quantity selection.
class BedroomDetailPage extends ConsumerStatefulWidget {
  final String bedroomId;

  const BedroomDetailPage({
    super.key,
    required this.bedroomId,
  });

  @override
  ConsumerState<BedroomDetailPage> createState() => _BedroomDetailPageState();
}

class _BedroomDetailPageState extends ConsumerState<BedroomDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(bedroomDetailProvider(widget.bedroomId).notifier)
          .loadBedroom(widget.bedroomId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bedroomDetailProvider(widget.bedroomId));

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

  Widget _buildBody(BedroomDetailState state) {
    return switch (state) {
      BedroomDetailInitial() => const core.LoadingWidget(),
      BedroomDetailLoading() => const core.LoadingWidget(message: 'Loading...'),
      BedroomDetailLoaded(:final bedroom, :final quantity, :final totalPrice) =>
        _buildDetailContent(
          bedroom: bedroom,
          quantity: quantity,
          totalPrice: totalPrice,
        ),
      BedroomDetailError(:final message) => core.ErrorWidget(
        message: message,
        onRetry: () => ref
            .read(bedroomDetailProvider(widget.bedroomId).notifier)
            .loadBedroom(widget.bedroomId),
      ),
    };
  }

  Widget _buildDetailContent({
    required Bedroom bedroom,
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
                _buildImageSection(bedroom),
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
                          text: _formatText(bedroom.category),
                          variant: AppTextVariant.labelSmall,
                          color: AppColors.accent,
                        ),
                      ),
                      const SizedBox(height: 12),
                      AppText(
                        text: bedroom.name,
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
                            text: bedroom.rating.toStringAsFixed(1),
                            variant: AppTextVariant.titleSmall,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(width: 4),
                          AppText(
                            text: '(${bedroom.reviewCount} reviews)',
                            variant: AppTextVariant.bodySmall,
                            color: AppColors.textSecondary,
                          ),
                          const Spacer(),
                          if (!bedroom.inStock)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.error,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: AppText(
                                text: 'Out of stock',
                                variant: AppTextVariant.labelSmall,
                                color: Colors.white,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        bedroom.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: '\$${bedroom.price.toStringAsFixed(2)}',
                    variant: AppTextVariant.titleLarge,
                  ),
                  if (bedroom.hasDiscount)
                    AppText(
                      text: '\$${bedroom.originalPrice!.toStringAsFixed(2)}',
                      variant: AppTextVariant.bodySmall,
                      decoration: TextDecoration.lineThrough,
                      color: AppColors.textSecondary,
                    ),
                ],
              ),
              const Spacer(),
              core.QuantitySelector(
                quantity: quantity,
                onIncrement: () =>
                    ref.read(bedroomDetailProvider(widget.bedroomId).notifier).updateQuantity(quantity + 1),
                onDecrement: () =>
                    ref.read(bedroomDetailProvider(widget.bedroomId).notifier).updateQuantity(quantity - 1),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppButton(
                  text: 'Add to Cart',
                  onPressed: () {
                    // TODO: Implement add to cart
                  },
                  enabled: bedroom.inStock,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImageSection(Bedroom bedroom) {
    return CachedNetworkImage(
      imageUrl: bedroom.imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: 300,
      placeholder: (context, url) => const core.LoadingWidget(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  String _formatText(String text) {
    return text.substring(0, 1).toUpperCase() + text.substring(1);
  }
}