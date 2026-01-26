import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/navigation/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/state_widgets.dart' as core;
import '../providers/chairs_providers.dart';
import '../state/chairs_state.dart';
import '../widgets/category_filter.dart';
import '../widgets/chair_grid.dart';

/// Chairs list page.
///
/// Displays a grid of chairs with category filtering.
/// Uses Riverpod for state management.
class ChairsPage extends ConsumerStatefulWidget {
  const ChairsPage({super.key});

  @override
  ConsumerState<ChairsPage> createState() => _ChairsPageState();
}

class _ChairsPageState extends ConsumerState<ChairsPage> {
  @override
  void initState() {
    super.initState();
    // Load chairs when page is first displayed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(chairsProvider.notifier).loadChairs();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chairsProvider);

    return AppScaffold(
      title: 'Chairs',
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
        onRefresh: () => ref.read(chairsProvider.notifier).refresh(),
        child: _buildBody(state),
      ),
    );
  }

  Widget _buildBody(ChairsState state) {
    return switch (state) {
      ChairsInitial() => const core.LoadingWidget(message: 'Loading...'),
      ChairsLoading() => const core.LoadingWidget(message: 'Loading chairs...'),
      ChairsLoaded(:final chairs, :final selectedCategory, :final categories, :final filteredChairs) =>
        _buildLoadedContent(
          chairs: chairs,
          filteredChairs: filteredChairs,
          categories: categories,
          selectedCategory: selectedCategory,
        ),
      ChairsError(:final message) => core.ErrorWidget(
          message: message,
          onRetry: () => ref.read(chairsProvider.notifier).loadChairs(),
        ),
    };
  }

  Widget _buildLoadedContent({
    required List chairs,
    required List filteredChairs,
    required List<String> categories,
    required String? selectedCategory,
  }) {
    return Column(
      children: [
        // Category filter
        CategoryFilter(
          categories: categories,
          selectedCategory: selectedCategory,
          onCategorySelected: (category) {
            ref.read(chairsProvider.notifier).filterByCategory(category);
          },
        ),
        const Divider(height: 1),
        // Results count
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Text(
                '${filteredChairs.length} results',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              const Spacer(),
              // Sort button (placeholder)
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
        // Chair grid
        Expanded(
          child: ChairGrid(
            chairs: filteredChairs.cast(),
            onChairTap: (chair) {
              context.push(AppRoutes.chairDetailPath(chair.id));
            },
            onAddToCart: (chair) {
              _showAddToCartSnackbar(chair.name);
            },
            onWishlistToggle: (chair) {
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
        content: Text('$productName added to cart'),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'View Cart',
          onPressed: () => context.push(AppRoutes.cart),
        ),
      ),
    );
  }
}
