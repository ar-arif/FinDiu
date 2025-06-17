import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/transaction_provider.dart';
import '../utils/app_colors.dart';

class BalanceCard extends StatelessWidget {
  final bool showBalance;
  final VoidCallback onToggleVisibility;

  const BalanceCard({
    super.key,
    required this.showBalance,
    required this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'en_BD',
      symbol: '৳',
      decimalDigits: 0,
    );

    return Consumer<TransactionProvider>(
      builder: (context, transactionProvider, child) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: Column(
            children: [
              // Balance Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Balance',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: onToggleVisibility,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        showBalance ? Icons.visibility : Icons.visibility_off,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              // Balance Amount
              Text(
                showBalance 
                    ? currencyFormat.format(transactionProvider.totalBalance)
                    : '৳••••••',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Income and Expenses
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.trending_up,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Income',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            showBalance 
                                ? currencyFormat.format(transactionProvider.monthlyIncome)
                                : '৳••••',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.trending_down,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Expenses',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            showBalance 
                                ? currencyFormat.format(transactionProvider.monthlyExpenses)
                                : '৳••••',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
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
        );
      },
    );
  }
}