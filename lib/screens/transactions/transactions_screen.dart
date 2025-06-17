import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../providers/transaction_provider.dart';
import '../../models/transaction_model.dart';
import '../../utils/app_colors.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String _searchQuery = '';
  String _selectedFilter = 'all';
  
  final List<Map<String, dynamic>> _filters = [
    {'id': 'all', 'label': 'All'},
    {'id': 'income', 'label': 'Income'},
    {'id': 'expense', 'label': 'Expenses'},
  ];

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'en_BD',
      symbol: '৳',
      decimalDigits: 0,
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        const Text(
                          'All Transactions',
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
                    Consumer<TransactionProvider>(
                      builder: (context, transactionProvider, child) {
                        return Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  children: [
                                    const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.trending_up, color: Colors.white, size: 20),
                                        SizedBox(width: 8),
                                        Text(
                                          'Total Income',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      currencyFormat.format(transactionProvider.monthlyIncome),
                                      style: const TextStyle(
                                        fontSize: 20,
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
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  children: [
                                    const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.trending_down, color: Colors.white, size: 20),
                                        SizedBox(width: 8),
                                        Text(
                                          'Total Expenses',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      currencyFormat.format(transactionProvider.monthlyExpenses),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Search Bar
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Search transactions...',
                          hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                          prefixIcon: Icon(Icons.search, color: Colors.white.withOpacity(0.6)),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Content
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Filters
                      Container(
                        padding: const EdgeInsets.all(24),
                        child: Row(
                          children: _filters.map((filter) {
                            final isSelected = _selectedFilter == filter['id'];
                            return Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedFilter = filter['id'];
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: isSelected ? AppColors.primary : Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: isSelected ? AppColors.primary : AppColors.surfaceVariant,
                                    ),
                                  ),
                                  child: Text(
                                    filter['label'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected ? Colors.white : AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      
                      // Transactions List
                      Expanded(
                        child: Consumer<TransactionProvider>(
                          builder: (context, transactionProvider, child) {
                            var filteredTransactions = transactionProvider.transactions;
                            
                            // Apply search filter
                            if (_searchQuery.isNotEmpty) {
                              filteredTransactions = filteredTransactions.where((transaction) {
                                return transaction.description.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                                       transaction.category.toLowerCase().contains(_searchQuery.toLowerCase());
                              }).toList();
                            }
                            
                            // Apply type filter
                            if (_selectedFilter != 'all') {
                              final filterType = _selectedFilter == 'income' 
                                  ? TransactionType.income 
                                  : TransactionType.expense;
                              filteredTransactions = filteredTransactions.where((transaction) {
                                return transaction.type == filterType;
                              }).toList();
                            }
                            
                            if (filteredTransactions.isEmpty) {
                              return const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.search_off,
                                      size: 64,
                                      color: AppColors.textTertiary,
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'No transactions found',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Try adjusting your search or filter criteria',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.textTertiary,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            
                            return ListView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              itemCount: filteredTransactions.length,
                              itemBuilder: (context, index) {
                                final transaction = filteredTransactions[index];
                                return _buildTransactionItem(transaction, currencyFormat);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionItem(TransactionModel transaction, NumberFormat currencyFormat) {
    final isIncome = transaction.type == TransactionType.income;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
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
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      transaction.category,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                        color: AppColors.textTertiary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      DateFormat('MMM dd').format(transaction.date),
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          Text(
            '${isIncome ? '+'  : '-'}${currencyFormat.format(transaction.amount)}',
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