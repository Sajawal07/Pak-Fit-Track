import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/constants/app_colors.dart';
import '../providers/activity_weight_provider.dart';

class MainShell extends ConsumerStatefulWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell> {
  int _currentIndex = 0;
  int _lastSavedSteps = -1;

  final List<_NavItem> _items = const [
    _NavItem(icon: Icons.home_rounded, label: 'Home', path: '/dashboard'),
    _NavItem(icon: Icons.directions_walk_rounded, label: 'Activity', path: '/activity'),
    _NavItem(icon: Icons.bar_chart_rounded, label: 'Analytics', path: '/analytics'),
    _NavItem(icon: Icons.monitor_weight_outlined, label: 'Weight', path: '/weight'),
    _NavItem(icon: Icons.person_rounded, label: 'Profile', path: '/profile'),
  ];

  @override
  Widget build(BuildContext context) {
    // Persist live steps whenever shell is open (not only on Activity tab),
    // so daily progress reports can read real counts from Isar.
    ref.listen<AsyncValue<int>>(liveStepsProvider, (_, next) {
      next.whenData((steps) {
        if (steps > 0 && steps != _lastSavedSteps) {
          _lastSavedSteps = steps;
          ref.read(activityNotifierProvider.notifier).saveStepCount(steps);
        }
      });
    });

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.surfaceLight, width: 1)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (i) {
              final item = _items[i];
              final selected = _currentIndex == i;
              return GestureDetector(
                onTap: () {
                  setState(() => _currentIndex = i);
                  context.go(item.path);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: selected
                        ? AppColors.primary.withValues(alpha: 0.15)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item.icon,
                        color: selected ? AppColors.primary : AppColors.textMuted,
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                          color: selected ? AppColors.primary : AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final String path;
  const _NavItem({required this.icon, required this.label, required this.path});
}
