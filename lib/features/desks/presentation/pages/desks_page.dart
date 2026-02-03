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
import '../widgets/desk_grid.dart';

/// Desks list page.
///
/// Displays a grid of desks with category filtering.
class DesksPage extends ConsumerStatefulWidget {
  const DesksPage({super.key});

  @override
  ConsumerState<DesksPage> createState() => _DesksPageState();
}

class _DesksPageState extends ConsumerState<DesksPage> {
  @override
  void initState() {
    super.initState();
    // Load desks when page is first displayed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(desksProvider.notifier).loadDesks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(desksProvider);

    return AppScaffold(
      title: 'Desks',
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
        onRefresh: () => ref.read(desksProvider.notifier).refresh(),
        child: _buildBody(state),
      ),
    );
  }

  Widget _buildBody(DesksState state) {
    return switch (state) {
      DesksInitial() => const core.LoadingWidget(message: 'Loading...'),
      DesksLoading() => const core.LoadingWidget(message: 'Loading desks...'),
      DesksLoaded(:final desks, :final selectedCategory, :final categories, :final filteredDesks) =>
        _buildLoadedContent(
          desks: desks,
          filteredDesks: filteredDesks,
          categories: categories,
          selectedCategory: selectedCategory,
        ),
      DesksError(:final message) => core.ErrorWidget(
          message: message,
          onRetry: () => ref.read(desksProvider.notifier).loadDesks(),
        ),
    };
  }

  Widget _buildLoadedContent({
    required List desks,
    required List filteredDesks,
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
            ref.read(desksProvider.notifier).filterByCategory(category);
          },
        ),
        const Divider(height: 1),
        // Results count
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Text(
                '${filteredDesks.length} results',
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
        // Desk grid
        Expanded(
          child: DeskGrid(
            desks: filteredDesks.cast(),
            onDeskTap: (desk) {
              context.push(AppRoutes.deskDetailPath(desk.id));
            },
            onAddToCart: (desk) {
              _showAddToCartSnackbar(desk.name);
            },
            onWishlistToggle: (desk) {
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
