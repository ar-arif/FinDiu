import 'package:flutter/material.dart';
import '../main.dart'; // Import AppScreen enum
import 'package:intl/intl.dart';

class AnalyticsScreen extends StatefulWidget {
  final Function(AppScreen) onNavigate;

  const AnalyticsScreen({super.key, required this.onNavigate});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final List<Map<String, dynamic>> spendingData = const [
    {
      'category': 'Food',
      'amount': 2800,
      'percentage': 35,
      'color': Color(0xFFF97316),
    }, // orange-500
    {
      'category': 'Transport',
      'amount': 1500,
      'percentage': 19,
      'color': Color(0xFF3B82F6),
    }, // blue-500
    {
      'category': 'Education',
      'amount': 1200,
      'percentage': 15,
      'color': Color(0xFF8B5CF6),
    }, // purple-500
    {
      'category': 'Entertainment',
      'amount': 1000,
      'percentage': 12,
      'color': Color(0xFFEC4899),
    }, // pink-500
    {
      'category': 'Shopping',
      'amount': 800,
      'percentage': 10,
      'color': Color(0xFF22C55E),
    }, // green-500
    {
      'category': 'Others',
      'amount': 700,
      'percentage': 9,
      'color': Color(0xFF6B7280),
    }, // gray-500
  ];

  final List<Map<String, dynamic>> monthlyTrend = const [
    {'month': 'Oct', 'amount': 6800},
    {'month': 'Nov', 'amount': 7200},
    {'month': 'Dec', 'amount': 6900},
    {'month': 'Jan', 'amount': 8000},
  ];

  String _formatCurrency(double amount) {
    final format = NumberFormat.currency(
      locale: 'en_BD',
      symbol: '৳',
      decimalDigits: 0,
    );
    return format.format(amount);
  }

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
                    Color(0xFFED8936), // to-secondary-500
                  ],
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () => widget.onNavigate(AppScreen.dashboard),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'Analytics',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Summary Cards
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16), // p-4
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFFFFFFFF,
                            ).withAlpha((0.1 * 255).round()), // bg-white/10
                            borderRadius: BorderRadius.circular(
                              16,
                            ), // rounded-2xl
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: const <Widget>[
                                  Icon(
                                    Icons.trending_up,
                                    size: 20,
                                    color: Colors.white,
                                  ), // w-5 h-5
                                  SizedBox(width: 8), // space-x-2
                                  Text(
                                    'This Month',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white70, // opacity-80
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8), // mb-2
                              Text(
                                _formatCurrency(8000), // '৳8,000'
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const Text(
                                '+12% from last month',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70, // opacity-80
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16), // gap-4
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFFFFFFFF,
                            ).withAlpha((0.1 * 255).round()),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: const <Widget>[
                                  Icon(
                                    Icons.trending_down,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Daily Average',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _formatCurrency(258), // '৳258'
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const Text(
                                '-5% from last month',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24), // px-6
              child: Transform.translate(
                offset: const Offset(0, -24), // -mt-6
                child: Column(
                  children: <Widget>[
                    // Spending by Category
                    Container(
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
                          Row(
                            children: const <Widget>[
                              Icon(
                                Icons.pie_chart_outline,
                                size: 24,
                                color: Color(0xFF6B46C1),
                              ), // w-6 h-6 text-primary-500
                              SizedBox(width: 12), // space-x-3
                              Text(
                                'Spending by Category',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1A202C),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24), // mb-6

                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: spendingData.length,
                            itemBuilder: (context, index) {
                              final item = spendingData[index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 16.0,
                                ), // space-y-4
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              width: 16,
                                              height: 16,
                                              decoration: BoxDecoration(
                                                color: item['color'],
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      999,
                                                    ), // rounded-full
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ), // space-x-3
                                            Text(
                                              item['category'],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF1A202C),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                              _formatCurrency(
                                                item['amount'],
                                              ), // ৳{item.amount.toLocaleString()}
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF1A202C),
                                              ),
                                            ),
                                            Text(
                                              '${item['percentage']}%',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFF4A5568),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8), // mb-2
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        99,
                                      ), // rounded-full
                                      child: LayoutBuilder(
                                        builder: (context, constraints) {
                                          return LinearProgressIndicator(
                                            value: item['percentage'] / 100,
                                            backgroundColor: const Color(
                                              0xFFEDF2F7,
                                            ), // bg-gray-200
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  item['color'],
                                                ),
                                            minHeight: 8, // h-2
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24), // space-y-6
                    // Monthly Trend
                    Container(
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
                            children: const <Widget>[
                              Icon(
                                Icons.bar_chart,
                                size: 24,
                                color: Color(0xFF6B46C1),
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Monthly Spending Trend',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1A202C),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: monthlyTrend.length,
                            itemBuilder: (context, index) {
                              final item = monthlyTrend[index];
                              final double maxAmount = monthlyTrend
                                  .map((d) => d['amount'] as double)
                                  .reduce((a, b) => a > b ? a : b);
                              final double percentage =
                                  (item['amount'] / maxAmount);
                              final bool isIncrease =
                                  index > 0 &&
                                  (item['amount'] as double) >
                                      (monthlyTrend[index - 1]['amount']
                                          as double);

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          '${item['month']} 2024',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF1A202C),
                                          ),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              _formatCurrency(item['amount']),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF1A202C),
                                              ),
                                            ),
                                            if (index > 0)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 8.0,
                                                ),
                                                child: Icon(
                                                  isIncrease
                                                      ? Icons.trending_up
                                                      : Icons.trending_down,
                                                  size: 16,
                                                  color:
                                                      isIncrease
                                                          ? const Color(
                                                            0xFFE53E3E,
                                                          )
                                                          : const Color(
                                                            0xFFED8936,
                                                          ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(99),
                                      child: LayoutBuilder(
                                        builder: (context, constraints) {
                                          return LinearProgressIndicator(
                                            value: percentage.clamp(0.0, 1.0),
                                            backgroundColor: const Color(
                                              0xFFEDF2F7,
                                            ),
                                            valueColor:
                                                const AlwaysStoppedAnimation<
                                                  Color
                                                >(
                                                  Color(0xFF6B46C1),
                                                ), // Primary color for gradient approximation
                                            minHeight: 12, // h-3
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Insights
                    Container(
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
                          const Text(
                            'Insights',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A202C),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEBF8FF), // bg-blue-50
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: const Color(
                                          0xFF3B82F6,
                                        ), // bg-blue-500
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: const Icon(
                                        Icons.trending_up,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const <Widget>[
                                          Text(
                                            'Food spending increased',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF1A202C),
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            'You spent 15% more on food this month. Consider meal planning to reduce costs.',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF4A5568),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF0FFF4), // bg-green-50
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: const Color(
                                          0xFFED8936,
                                        ), // bg-secondary-500
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: const Icon(
                                        Icons.trending_down,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const <Widget>[
                                          Text(
                                            'Great job on transport!',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF1A202C),
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            'You saved ৳300 on transport this month by using your student bus pass.',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF4A5568),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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
            ),
          ],
        ),
      ),
    );
  }
}
