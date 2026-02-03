import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/navigation/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/state_widgets.dart' as core;
import '../providers/providers.dart';
import '../state/state.dart';
import '../widgets/category_filter.dart';
import '../widgets/living_room_grid.dart';

/// Living rooms list page.
///
/// Displays a grid of living rooms with category filtering.
class LivingRoomsPage extends ConsumerStatefulWidget {
  const LivingRoomsPage({super.key});

  @override
  ConsumerState<LivingRoomsPage> createState() => _LivingRoomsPageState();
}

class _LivingRoomsPageState extends ConsumerState<LivingRoomsPage> {
  @override
  void initState() {
    super.initState();
    // Load living rooms when page is first displayed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(livingRoomsProvider.notifier).loadLivingRooms();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(livingRoomsProvider);

    return AppScaffold(
      title: 'Living Rooms',
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // TODO: Implement search
          },
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined),
          onPressed: () => context.push(AppRoutes.cart),
        ),
      ],
      body: RefreshIndicator(
        onRefresh: () => ref.read(livingRoomsProvider.notifier).refresh(),
        child: _buildBody(state),
      ),
    );
  }

  Widget _buildBody(LivingRoomsState state) {
    return switch (state) {
      LivingRoomsInitial() => const core.LoadingWidget(message: 'Loading...'),
      LivingRoomsLoading() => const core.LoadingWidget(message: 'Loading living rooms...'),
      LivingRoomsLoaded(:final rooms, :final selectedCategory, :final categories, :final filteredRooms) =>
        _buildLoadedContent(
          rooms: rooms,
          filteredRooms: filteredRooms,
          categories: categories,
          selectedCategory: selectedCategory,
        ),
      LivingRoomsError(:final message) => core.ErrorWidget(
          message: message,
          onRetry: () => ref.read(livingRoomsProvider.notifier).loadLivingRooms(),
        ),
    };
  }

  Widget _buildLoadedContent({
    required List rooms,
    required List filteredRooms,
    required List<String> categories,
    required String? selectedCategory,
  }) {
    return Column(
      children: [
        CategoryFilter(
          categories: categories,
          selectedCategory: selectedCategory,
          onCategorySelected: (category) {
            ref.read(livingRoomsProvider.notifier).filterByCategory(category);
          },
        ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Text(
                '\${filteredRooms.length} results',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () {
                  // TODO: Implement sorting
                },
                icon: const Icon(Icons.sort, size: 18),
                label: const Text('Sort'),
              ),
            ],
          ),
        ),
        Expanded(
          child: LivingRoomGrid(
            rooms: filteredRooms.cast(),
            onRoomTap: (room) {
              context.push(AppRoutes.livingRoomDetailPath(room.id));
            },
            onAddToCart: (room) {
              _showAddToCartSnackbar(room.name);
            },
            onWishlistToggle: (room) {
              // TODO: Implement wishlist
            },
          ),
        ),
      ],
    );
  }

  void _showAddToCartSnackbar(String productName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('\$productName added to cart'),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'View Cart',
          onPressed: () => context.push(AppRoutes.cart),
        ),
      ),
    );
  }
}