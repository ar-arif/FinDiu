import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/transaction_provider.dart';
import '../models/transaction_model.dart';
import '../utils/app_colors.dart';
import '../screens/transactions/transactions_screen.dart';

class RecentTransactions extends StatelessWidget {
  const RecentTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'en_BD',
      symbol: '৳',
      decimalDigits: 0,
    );

    return Consumer<TransactionProvider>(
      builder: (context, transactionProvider, child) {
        final recentTransactions = transactionProvider.recentTransactions.take(4).toList();

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
                    'Recent Transactions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const TransactionsScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              if (recentTransactions.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.receipt_long,
                          size: 48,
                          color: AppColors.textTertiary,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No transactions yet',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Column(
                  children: recentTransactions.map((transaction) {
                    return _buildTransactionItem(transaction, currencyFormat);
                  }).toList(),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTransactionItem(TransactionModel transaction, NumberFormat currencyFormat) {
    final isIncome = transaction.type == TransactionType.income;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isIncome 
                  ? AppColors.secondary.withOpacity(0.1)
                  : AppColors.error.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              isIncome ? Icons.trending_up : Icons.trending_down,
              color: isIncome ? AppColors.secondary : AppColors.error,
              size: 24,
            ),
          ),
          
          const SizedBox(width: 16),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.description,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  transaction.category,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          
          Text(
            '${isIncome ? '+' : '-'}${currencyFormat.format(transaction.amount)}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isIncome ? AppColors.secondary : AppColors.error,
            ),
          ),
        ],
      ),
    );
  }
}