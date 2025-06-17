import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/transaction_provider.dart';
import '../utils/app_colors.dart';

class BudgetOverview extends StatelessWidget {
  const BudgetOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'en_BD',
      symbol: '৳',
      decimalDigits: 0,
    );

    return Consumer<TransactionProvider>(
      builder: (context, transactionProvider, child) {
        const monthlyBudget = 8000.0;
        final spent = transactionProvider.monthlyExpenses;
        final remaining = monthlyBudget - spent;
        final progress = spent / monthlyBudget;

        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Monthly Budget',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    DateFormat('MMM yyyy').format(DateTime.now()),
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Progress Bar
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Spent',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        '${currencyFormat.format(spent)} of ${currencyFormat.format(monthlyBudget)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Container(
                    width: double.infinity,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: progress.clamp(0.0, 1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: progress > 0.8 
                              ? const LinearGradient(
                                  colors: [AppColors.warning, AppColors.error],
                                )
                              : AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              Text(
                remaining > 0
                    ? 'You have ${currencyFormat.format(remaining)} left to spend this month'
                    : 'You have exceeded your budget by ${currencyFormat.format(-remaining)}',
                style: TextStyle(
                  fontSize: 14,
                  color: remaining > 0 ? AppColors.textSecondary : AppColors.error,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}