import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../data/models/food_item.dart';
import '../../providers/nutrition_provider.dart';

class FoodSearchScreen extends ConsumerStatefulWidget {
  const FoodSearchScreen({super.key});

  @override
  ConsumerState<FoodSearchScreen> createState() => _FoodSearchScreenState();
}

class _FoodSearchScreenState extends ConsumerState<FoodSearchScreen> {
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = ref.watch(foodSearchResultsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Search Food'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: TextField(
              controller: _ctrl,
              autofocus: true,
              onChanged: (v) {
                ref.read(foodSearchCategoryProvider.notifier).state = null;
                ref.read(foodSearchQueryProvider.notifier).state = v;
              },
              decoration: InputDecoration(
                hintText: 'Roti, Biryani, Daal...',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _ctrl.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () {
                          _ctrl.clear();
                          ref.read(foodSearchCategoryProvider.notifier).state =
                              null;
                          ref.read(foodSearchQueryProvider.notifier).state = '';
                        },
                      )
                    : null,
              ),
            ),
          ),

          // Category chips — Drinks early so Halal Drinks is easy to find
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: _chipOrder.map((cat) {
                final selected =
                    ref.watch(foodSearchCategoryProvider) == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(_catLabel(cat)),
                    selected: selected,
                    onSelected: (_) {
                      if (selected) {
                        _ctrl.clear();
                        ref.read(foodSearchCategoryProvider.notifier).state =
                            null;
                        ref.read(foodSearchQueryProvider.notifier).state = '';
                      } else {
                        // Category filter only — keep search box empty so
                        // typing does not clear the chip mid-filter.
                        _ctrl.clear();
                        ref.read(foodSearchCategoryProvider.notifier).state =
                            cat;
                        ref.read(foodSearchQueryProvider.notifier).state = '';
                      }
                      setState(() {});
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 8),

          // Results
          Expanded(
            child: results.when(
              loading: () => const Center(
                child: CircularProgressIndicator(
                    color: AppColors.primary, strokeWidth: 2),
              ),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (foods) {
                if (foods.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('🔍', style: TextStyle(fontSize: 48)),
                        SizedBox(height: 12),
                        Text(
                          'No food found',
                          style: TextStyle(
                              color: AppColors.textSecondary, fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Try "roti", "chicken", or "daal"',
                          style: TextStyle(color: AppColors.textMuted),
                        ),
                      ],
                    ),
                  );
                }

                // Pre-group BEFORE rendering to ensure UI stability
                final Map<String, List<FoodItem>> grouped = {};
                for (final f in foods) {
                  final group = f.family ?? 'Other';
                  grouped.putIfAbsent(group, () => []).add(f);
                }

                // Flatten into items list containing both Headers and Foods
                final List<dynamic> listItems = [];
                grouped.forEach((family, items) {
                  listItems.add(family);
                  listItems.addAll(items);
                });

                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
                  itemCount: listItems.length,
                  itemBuilder: (_, i) {
                    final item = listItems[i];
                    if (item is String) {
                      // Soft Grouping Header
                      return Padding(
                        padding: const EdgeInsets.only(top: 24, bottom: 8, left: 4),
                        child: Text(
                          item.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            color: AppColors.primary,
                          ),
                        ),
                      );
                    }
                    // Actual Food Tile
                    return _FoodTile(
                      food: item as FoodItem,
                      index: i,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Popular chips first — Halal Drinks near the start.
  static const _chipOrder = [
    FoodCategory.beverages,
    FoodCategory.bread,
    FoodCategory.rice,
    FoodCategory.chicken,
    FoodCategory.beef,
    FoodCategory.mutton,
    FoodCategory.fish,
    FoodCategory.lentils,
    FoodCategory.vegetables,
    FoodCategory.dairy,
    FoodCategory.fruits,
    FoodCategory.fastFood,
    FoodCategory.snacks,
    FoodCategory.desserts,
    FoodCategory.oils,
    FoodCategory.other,
  ];

  String _catLabel(FoodCategory cat) {
    switch (cat) {
      case FoodCategory.bread: return 'Roti/Bread';
      case FoodCategory.rice: return 'Rice';
      case FoodCategory.lentils: return 'Daal';
      case FoodCategory.chicken: return 'Chicken';
      case FoodCategory.beef: return 'Beef';
      case FoodCategory.mutton: return 'Mutton';
      case FoodCategory.fish: return 'Fish';
      case FoodCategory.vegetables: return 'Vegetables';
      case FoodCategory.dairy: return 'Dairy/Eggs';
      case FoodCategory.snacks: return 'Snacks';
      case FoodCategory.fruits: return 'Fruits';
      case FoodCategory.beverages: return 'Halal Drinks';
      case FoodCategory.desserts: return 'Desserts';
      case FoodCategory.oils: return 'Oils';
      case FoodCategory.fastFood: return 'Fast Food';
      case FoodCategory.other: return 'Other';
    }
  }
}

class _FoodTile extends StatelessWidget {
  final FoodItem food;
  final int index;

  const _FoodTile({required this.food, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/add-food', extra: food),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // Category icon container
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  _catEmoji(food.category),
                  style: const TextStyle(fontSize: 22),
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Food info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    food.name,
                    style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  if (food.nameUrdu.isNotEmpty)
                    Text(
                      food.nameUrdu,
                      style: const TextStyle(
                          color: AppColors.textSecondary, fontSize: 12),
                    ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: [
                      if (food.family != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                              color: AppColors.accent.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4)),
                          child: Text(food.family!.toUpperCase(),
                              style: const TextStyle(
                                  color: AppColors.accent,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ...food.ingredients.take(2).map((i) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                                color: AppColors.surfaceLight,
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(i,
                                style: const TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 10)),
                          )),
                    ],
                  ),
                ],
              ),
            ),

            // Macros column
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${food.caloriesPer100g.round()} kcal',
                  style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    _macroChip('P ${food.proteinPer100g.round()}g',
                        AppColors.proteinColor),
                    const SizedBox(width: 4),
                    _macroChip('C ${food.carbsPer100g.round()}g',
                        AppColors.carbsColor),
                    const SizedBox(width: 4),
                    _macroChip('F ${food.fatPer100g.round()}g',
                        AppColors.fatColor),
                  ],
                ),
              ],
            ),

            const SizedBox(width: 8),
            const Icon(Icons.chevron_right_rounded,
                color: AppColors.textMuted, size: 20),
          ],
        ),
      )
          .animate()
          .fadeIn(duration: 300.ms, delay: Duration(milliseconds: index * 30))
          .slideX(begin: 0.05),
    );
  }

  Widget _macroChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: 9, color: color, fontWeight: FontWeight.w600)),
    );
  }

  String _catEmoji(FoodCategory cat) {
    switch (cat) {
      case FoodCategory.bread: return '🫓';
      case FoodCategory.rice: return '🍚';
      case FoodCategory.lentils: return '🫘';
      case FoodCategory.chicken: return '🍗';
      case FoodCategory.beef: return '🥩';
      case FoodCategory.mutton: return '🍖';
      case FoodCategory.fish: return '🐟';
      case FoodCategory.vegetables: return '🥦';
      case FoodCategory.dairy: return '🥛';
      case FoodCategory.snacks: return '🥪';
      case FoodCategory.fruits: return '🍎';
      case FoodCategory.beverages: return '🥤';
      case FoodCategory.desserts: return '🍮';
      case FoodCategory.oils: return '🫙';
      case FoodCategory.fastFood: return '🍔';
      case FoodCategory.other: return '🍴';
    }
  }
}
