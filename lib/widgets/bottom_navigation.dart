import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home,
                label: 'Home',
                index: 0,
                isActive: currentIndex == 0,
              ),
              _buildNavItem(
                icon: Icons.add_circle,
                label: 'Add',
                index: 1,
                isActive: currentIndex == 1,
              ),
              _buildNavItem(
                icon: Icons.savings,
                label: 'Goals',
                index: 2,
                isActive: currentIndex == 2,
              ),
              _buildNavItem(
                icon: Icons.chat,
                label: 'AI Chat',
                index: 3,
                isActive: currentIndex == 3,
              ),
              _buildNavItem(
                icon: Icons.bar_chart,
                label: 'Analytics',
                index: 4,
                isActive: currentIndex == 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required bool isActive,
  }) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isActive ? AppColors.primary : AppColors.textTertiary,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isActive ? AppColors.primary : AppColors.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}