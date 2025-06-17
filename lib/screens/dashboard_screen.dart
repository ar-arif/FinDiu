import 'package:flutter/material.dart';
import '../main.dart'; // Import AppScreen enum

class DashboardScreen extends StatefulWidget {
  final Function(AppScreen) onNavigate;

  const DashboardScreen({super.key, required this.onNavigate});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _showBalance = true;
  final double _balance = 12750;
  final double _monthlyBudget = 8000;
  final double _spent = 4500;
  final double _income = 2500;
  final double _expenses = 1820;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Header
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFF6B46C1), // from-primary-500
                    Color(0xFF805AD5), // to-accent-500
                  ],
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text(
                            'Good morning,',
                            style: TextStyle(
                              fontSize: 24, // text-2xl
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Arif 👋',
                            style: TextStyle(
                              fontSize: 18, // text-lg
                              color: Colors.white70, // opacity-90
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () => widget.onNavigate(AppScreen.profile),
                        borderRadius: BorderRadius.circular(
                          999,
                        ), // rounded-full
                        child: Container(
                          width: 40, // w-10
                          height: 40, // h-10
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFFFFFFFF,
                            ).withAlpha((0.2 * 255).round()), // bg-white/20
                            borderRadius: BorderRadius.circular(
                              999,
                            ), // rounded-full
                          ),
                          child: const Center(
                            child: Text(
                              'A',
                              style: TextStyle(
                                fontSize: 18, // text-lg
                                fontWeight: FontWeight.w600, // font-semibold
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24), // mb-6
                  // Balance Card
                  Container(
                    padding: const EdgeInsets.all(24), // p-6
                    decoration: BoxDecoration(
                      color: const Color(
                        0xFFFFFFFF,
                      ).withAlpha((0.1 * 255).round()), // bg-white/10
                      borderRadius: BorderRadius.circular(24), // rounded-3xl
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text(
                              'Total Balance',
                              style: TextStyle(
                                fontSize: 14, // text-sm
                                color: Colors.white70, // opacity-80
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _showBalance = !_showBalance;
                                });
                              },
                              icon: Icon(
                                _showBalance
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                                size: 16, // w-4 h-4
                              ),
                              splashRadius: 20,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8), // mb-2
                        Text(
                          _showBalance
                              ? '৳${_balance.toStringAsFixed(0)}'
                              : '৳••••••',
                          style: const TextStyle(
                            fontSize: 28, // text-3xl
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16), // mb-4
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(12), // p-3
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFFFFF).withAlpha(
                                    (0.1 * 255).round(),
                                  ), // bg-white/10
                                  borderRadius: BorderRadius.circular(
                                    16,
                                  ), // rounded-2xl
                                ),
                                child: Column(
                                  children: <Widget>[
                                    const Icon(
                                      Icons.arrow_upward,
                                      color: Colors.white,
                                      size: 20,
                                    ), // w-5 h-5
                                    const SizedBox(height: 4), // mb-1
                                    const Text(
                                      'Income',
                                      style: TextStyle(
                                        fontSize: 14, // text-sm
                                        color: Colors.white70, // opacity-80
                                      ),
                                    ),
                                    Text(
                                      '৳${_income.toStringAsFixed(0)}',
                                      style: const TextStyle(
                                        fontWeight:
                                            FontWeight.w600, // font-semibold
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 16), // space-x-4
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFFFFFFFF,
                                  ).withAlpha((0.1 * 255).round()),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    const Icon(
                                      Icons.arrow_downward,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      'Expenses',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    Text(
                                      '৳${_expenses.toStringAsFixed(0)}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Quick Actions
            Transform.translate(
              offset: const Offset(0, -24), // -mt-6
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: const EdgeInsets.all(24), // p-6
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24), // rounded-3xl
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withAlpha((0.1 * 255).round()),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3), // shadow-sm
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Quick Actions',
                        style: TextStyle(
                          fontSize: 18, // text-lg
                          fontWeight: FontWeight.w600, // font-semibold
                          color: Color(0xFF1A202C), // text-gray-900
                        ),
                      ),
                      const SizedBox(height: 16), // mb-4
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 16, // gap-4
                        mainAxisSpacing: 16, // gap-4
                        childAspectRatio:
                            2.5, // Adjust as needed to fit content
                        children: <Widget>[
                          _buildQuickActionButton(
                            icon: Icons.add,
                            iconBgColor: const Color(0xFF6B46C1), // primary-500
                            title: 'Add Expense',
                            subtitle: 'Track spending',
                            bgColor: const Color(0xFFF0F4F8), // primary-50
                            onTap:
                                () => widget.onNavigate(AppScreen.addExpense),
                          ),
                          _buildQuickActionButton(
                            icon: Icons.trending_up,
                            iconBgColor: const Color(
                              0xFFED8936,
                            ), // secondary-500
                            title: 'Save Money',
                            subtitle: 'Set goals',
                            bgColor: const Color(0xFFFEF2F2), // secondary-50
                            onTap: () => widget.onNavigate(AppScreen.savings),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24), // mb-6
            // Budget Overview
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha((0.1 * 255).round()),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Text(
                          'Monthly Budget',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A202C),
                          ),
                        ),
                        Text(
                          'Jan 2024',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF4A5568),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16), // mb-4
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text(
                              'Spent',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF4A5568),
                              ),
                            ),
                            Text(
                              '৳${_spent.toStringAsFixed(0)} of ৳${_monthlyBudget.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8), // mb-2
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                            99,
                          ), // rounded-full
                          child: LinearProgressIndicator(
                            value:
                                _spent /
                                _monthlyBudget, // Progress based on spent/budget
                            backgroundColor: const Color(
                              0xFFEDF2F7,
                            ), // bg-gray-200
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFF6B46C1),
                            ), // from-primary-500 (will approximate gradient)
                            minHeight: 12, // h-3
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16), // mb-4
                    Text(
                      'You have ৳${(_monthlyBudget - _spent).toStringAsFixed(0)} left to spend this month',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF4A5568),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24), // mb-6
            // Recent Transactions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha((0.1 * 255).round()),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          'Recent Transactions',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A202C),
                          ),
                        ),
                        TextButton(
                          onPressed:
                              () => widget.onNavigate(AppScreen.transactions),
                          child: const Text(
                            'See All',
                            style: TextStyle(
                              color: Color(0xFF553C9A), // text-primary-600
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16), // mb-4
                    // Placeholder for transactions list - will add actual data later
                    Column(
                      children: List.generate(4, (index) {
                        // Mock transaction data for now
                        final bool isIncome = index % 2 == 0;
                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: 16.0,
                          ), // space-y-4
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 48, // w-12
                                height: 48, // h-12
                                decoration: BoxDecoration(
                                  color:
                                      isIncome
                                          ? const Color(0xFFF7FAFC)
                                          : const Color(
                                            0xFFFED7D7,
                                          ), // bg-secondary-100 or bg-red-100
                                  borderRadius: BorderRadius.circular(
                                    16,
                                  ), // rounded-2xl
                                ),
                                child: Icon(
                                  isIncome
                                      ? Icons.trending_up
                                      : Icons.trending_down,
                                  color:
                                      isIncome
                                          ? const Color(0xFFD69E2E)
                                          : const Color(
                                            0xFFE53E3E,
                                          ), // text-secondary-600 or text-red-600
                                  size: 24, // w-6 h-6
                                ),
                              ),
                              const SizedBox(width: 16), // space-x-4
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Transaction ${index + 1}', // Placeholder description
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF1A202C),
                                      ),
                                    ),
                                    Text(
                                      'Category ${index + 1}', // Placeholder category
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF4A5568),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '${isIncome ? '+' : '-'}৳${(index + 1) * 100}.00', // Placeholder amount
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color:
                                      isIncome
                                          ? const Color(0xFFD69E2E)
                                          : const Color(0xFFE53E3E),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
            // Add some spacing above the loader
            const SizedBox(height: 24),
            // Loading animation
            const Center(child: CircularProgressIndicator()),
            // Add some spacing below the loader
            const SizedBox(height: 24),
            // Add padding for the BottomNavigation bar to prevent content from being obscured
            const SizedBox(
              height: 80.0,
            ), // Approximate height of BottomNavigation
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required Color iconBgColor,
    required String title,
    required String subtitle,
    required Color bgColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16), // p-4
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16), // rounded-2xl
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 40, // w-10
              height: 40, // h-10
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(8), // rounded-xl
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20, // w-5 h-5
              ),
            ),
            const SizedBox(width: 12), // space-x-3
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A202C), // text-gray-900
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4A5568), // text-gray-600
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
