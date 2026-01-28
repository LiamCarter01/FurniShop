import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_colors.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/app_text.dart';
import 'routes.dart';

/// Home page with navigation to all features.
///
/// This is the main entry point of the app.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'FurniShop',
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // TODO: Navigate to search
          },
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined),
          onPressed: () => context.push(AppRoutes.cart),
        ),
      ],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome header
            const AppText(
              text: 'Welcome to FurniShop',
              variant: AppTextVariant.headlineMedium,
            ),
            const SizedBox(height: 8),
            const AppText(
              text: 'Discover beautiful furniture for your home',
              variant: AppTextVariant.bodyMedium,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 24),

            // Category grid
            const AppText(
              text: 'Categories',
              variant: AppTextVariant.titleLarge,
            ),
            const SizedBox(height: 16),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _CategoryCard(
                  title: 'Chairs',
                  icon: Icons.chair,
                  color: AppColors.accent,
                  onTap: () => context.push(AppRoutes.chairs),
                ),
                _CategoryCard(
                  title: 'Desks',
                  icon: Icons.desk,
                  color: AppColors.info,
                  onTap: () => context.push(AppRoutes.desks),
                ),
                _CategoryCard(
                  title: 'Bedrooms',
                  icon: Icons.bed,
                  color: AppColors.success,
                  onTap: () => context.push(AppRoutes.bedrooms),
                ),
                _CategoryCard(
                  title: 'Living Rooms',
                  icon: Icons.living,
                  color: AppColors.warning,
                  onTap: () => context.push(AppRoutes.livingRooms),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Featured section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppText(
                  text: 'Featured Chairs',
                  variant: AppTextVariant.titleLarge,
                ),
                TextButton(
                  onPressed: () => context.push(AppRoutes.chairs),
                  child: const Text('See All'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const AppText(
              text: 'Explore our top-rated chair collection',
              variant: AppTextVariant.bodySmall,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              // Already on home
              break;
            case 1:
              context.push(AppRoutes.chairs);
              break;
            case 2:
              context.push(AppRoutes.cart);
              break;
            case 3:
              context.push(AppRoutes.profile);
              break;
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.chair_outlined),
            selectedIcon: Icon(Icons.chair),
            label: 'Shop',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            selectedIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

/// Category card widget for the home page grid.
class _CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withValues(alpha: 0.1),
                color.withValues(alpha: 0.05),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 40,
                  color: color,
                ),
              ),
              const SizedBox(height: 12),
              AppText(
                text: title,
                variant: AppTextVariant.titleMedium,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
