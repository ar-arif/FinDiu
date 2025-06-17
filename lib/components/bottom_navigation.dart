import 'package:flutter/material.dart';
import '../main.dart'; // Import AppScreen enum

class BottomNavigation extends StatelessWidget {
  final AppScreen currentScreen;
  final Function(AppScreen) onNavigate;

  const BottomNavigation({
    super.key,
    required this.currentScreen,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> navItems = [
      {'screen': AppScreen.dashboard, 'icon': Icons.home, 'label': 'Home'},
      {
        'screen': AppScreen.addExpense,
        'icon': Icons.add_circle,
        'label': 'Add',
      },
      {'screen': AppScreen.savings, 'icon': Icons.savings, 'label': 'Savings'},
      {'screen': AppScreen.aiChat, 'icon': Icons.chat, 'label': 'AI Chat'},
      {
        'screen': AppScreen.analytics,
        'icon': Icons.bar_chart,
        'label': 'Analytics',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey.withAlpha((0.2 * 255).round()),
            width: 1,
          ),
        ), // border-t border-gray-200
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha((0.1 * 255).round()),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, -5), // subtle shadow for elevation
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ), // px-6 py-4
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:
            navItems.map((item) {
              final bool isActive = currentScreen == item['screen'];
              return InkWell(
                onTap: () => onNavigate(item['screen']),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      item['icon'],
                      size: 24, // w-6 h-6
                      color:
                          isActive
                              ? const Color(0xFF6B46C1)
                              : const Color(
                                0xFFA0AEC0,
                              ), // text-primary-600 or text-gray-400
                    ),
                    const SizedBox(height: 4), // space-y-1
                    Text(
                      item['label'],
                      style: TextStyle(
                        fontSize: 12, // text-xs
                        fontWeight: FontWeight.w500, // font-medium
                        color:
                            isActive
                                ? const Color(0xFF6B46C1)
                                : const Color(
                                  0xFF718096,
                                ), // text-primary-600 or text-gray-400
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
      ),
    );
  }
}
