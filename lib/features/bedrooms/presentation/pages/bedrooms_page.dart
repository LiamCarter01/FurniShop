import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/navigation/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/state_widgets.dart' as core;
import '../providers/bedrooms_providers.dart';
import '../state/bedrooms_state.dart';
import '../widgets/category_filter.dart';
import '../widgets/bedroom_grid.dart';

/// Bedrooms list page.
class BedroomsPage extends ConsumerStatefulWidget {
  const BedroomsPage({super.key});

  @override
  ConsumerState<BedroomsPage> createState() => _BedroomsPageState();
}

class _BedroomsPageState extends ConsumerState<BedroomsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bedroomsProvider.notifier).loadBedrooms();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bedroomsProvider);

    return AppScaffold(
      title: 'Bedrooms',
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined),
          onPressed: () => context.push(AppRoutes.cart),
        ),
      ],
      body: RefreshIndicator(
        onRefresh: () => ref.read(bedroomsProvider.notifier).refresh(),
        child: _buildBody(state),
      ),
    );
  }

  Widget _buildBody(BedroomsState state) {
    return switch (state) {
      BedroomsInitial() => const core.LoadingWidget(message: 'Loading...'),
      BedroomsLoading() => const core.LoadingWidget(message: 'Loading bedrooms...'),
      BedroomsLoaded(:final bedrooms, :final selectedCategory, :final categories, :final filteredBedrooms) =>
        _buildLoadedContent(
          bedrooms: bedrooms,
          filteredBedrooms: filteredBedrooms,
          categories: categories,
          selectedCategory: selectedCategory,
        ),
      BedroomsError(:final message) => core.ErrorWidget(
        message: message,
        onRetry: () => ref.read(bedroomsProvider.notifier).loadBedrooms(),
      ),
    };
  }

  Widget _buildLoadedContent({
    required List<Bedroom> bedrooms,
    required List<Bedroom> filteredBedrooms,
    required List<String> categories,
    required String? selectedCategory,
  }) {
    return Column(
      children: [
        CategoryFilter(
          categories: categories,
          selectedCategory: selectedCategory,
          onCategorySelected: (category) {
            ref.read(bedroomsProvider.notifier).filterByCategory(category);
          },
        ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Text(
                '${filteredBedrooms.length} results',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.sort, size: 18),
                label: const Text('Sort'),
              ),
            ],
          ),
        ),
        Expanded(
          child: BedroomGrid(
            bedrooms: filteredBedrooms,
            onBedroomTap: (bedroom) => context.push(AppRoutes.bedroomDetailPath(bedroom.id)),
            onAddToCart: (bedroom) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('\${bedroom.name} added to cart')),
              );
            },
          ),
        ),
      ],
    );
  }
}