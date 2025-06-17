import 'package:flutter/material.dart';
import '../main.dart'; // Import AppScreen enum
import 'package:intl/intl.dart';

enum TransactionType { income, expense }

class Transaction {
  final String id;
  final String description;
  final String category;
  final double amount;
  final TransactionType type;
  final DateTime date;

  Transaction({
    required this.id,
    required this.description,
    required this.category,
    required this.amount,
    required this.type,
    required this.date,
  });
}

final List<Transaction> mockTransactions = [
  Transaction(
    id: '1',
    description: 'Salary',
    category: 'Work',
    amount: 15000.0,
    type: TransactionType.income,
    date: DateTime.now().subtract(const Duration(days: 2)),
  ),
  Transaction(
    id: '2',
    description: 'Books',
    category: 'Education',
    amount: 1200.0,
    type: TransactionType.expense,
    date: DateTime.now().subtract(const Duration(days: 1)),
  ),
  Transaction(
    id: '3',
    description: 'Groceries',
    category: 'Food',
    amount: 800.0,
    type: TransactionType.expense,
    date: DateTime.now(),
  ),
  Transaction(
    id: '4',
    description: 'Freelance Payment',
    category: 'Work',
    amount: 5000.0,
    type: TransactionType.income,
    date: DateTime.now().subtract(const Duration(days: 5)),
  ),
  Transaction(
    id: '5',
    description: 'Electricity Bill',
    category: 'Utilities',
    amount: 750.0,
    type: TransactionType.expense,
    date: DateTime.now().subtract(const Duration(days: 3)),
  ),
  Transaction(
    id: '6',
    description: 'Pocket Money',
    category: 'Allowance',
    amount: 2000.0,
    type: TransactionType.income,
    date: DateTime.now().subtract(const Duration(days: 10)),
  ),
  Transaction(
    id: '7',
    description: 'Shopping',
    category: 'Personal',
    amount: 1500.0,
    type: TransactionType.expense,
    date: DateTime.now().subtract(const Duration(days: 7)),
  ),
  Transaction(
    id: '8',
    description: 'Bus Fare',
    category: 'Transportation',
    amount: 100.0,
    type: TransactionType.expense,
    date: DateTime.now().subtract(const Duration(days: 1)),
  ),
  Transaction(
    id: '9',
    description: 'Scholarship',
    category: 'Education',
    amount: 10000.0,
    type: TransactionType.income,
    date: DateTime.now().subtract(const Duration(days: 15)),
  ),
  Transaction(
    id: '10',
    description: 'Dinner',
    category: 'Food',
    amount: 500.0,
    type: TransactionType.expense,
    date: DateTime.now().subtract(const Duration(days: 0)),
  ),
];

class TransactionsScreen extends StatefulWidget {
  final Function(AppScreen) onNavigate;

  const TransactionsScreen({super.key, required this.onNavigate});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String _searchQuery = '';
  String _selectedFilter = 'all';
  String _selectedMonth = 'current';

  List<Map<String, dynamic>> filters = [];
  List<Map<String, dynamic>> months = [];

  @override
  void initState() {
    super.initState();
    _updateFiltersAndMonths();
  }

  void _updateFiltersAndMonths() {
    filters = [
      {'id': 'all', 'label': 'All', 'count': mockTransactions.length},
      {
        'id': 'income',
        'label': 'Income',
        'count':
            mockTransactions
                .where((t) => t.type == TransactionType.income)
                .length,
      },
      {
        'id': 'expense',
        'label': 'Expenses',
        'count':
            mockTransactions
                .where((t) => t.type == TransactionType.expense)
                .length,
      },
    ];

    months = [
      {'id': 'current', 'label': 'This Month'},
      {'id': 'last', 'label': 'Last Month'},
      {'id': 'all', 'label': 'All Time'},
    ];
  }

  List<Transaction> get filteredTransactions {
    List<Transaction> transactions =
        mockTransactions.where((transaction) {
          final matchesSearch =
              transaction.description.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ||
              transaction.category.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              );
          final matchesFilter =
              _selectedFilter == 'all' ||
              transaction.type.name == _selectedFilter;

          // Simple month filtering (can be expanded for more complex logic)
          bool matchesMonth = true;
          if (_selectedMonth == 'current') {
            final now = DateTime.now();
            matchesMonth =
                transaction.date.year == now.year &&
                transaction.date.month == now.month;
          } else if (_selectedMonth == 'last') {
            final lastMonth = DateTime.now().subtract(const Duration(days: 30));
            matchesMonth =
                transaction.date.year == lastMonth.year &&
                transaction.date.month == lastMonth.month;
          }

          return matchesSearch && matchesFilter && matchesMonth;
        }).toList();

    // Sort transactions by date, newest first
    transactions.sort((a, b) => b.date.compareTo(a.date));
    return transactions;
  }

  double get totalIncome => filteredTransactions
      .where((t) => t.type == TransactionType.income)
      .fold(0.0, (sum, t) => sum + t.amount);

  double get totalExpenses => filteredTransactions
      .where((t) => t.type == TransactionType.expense)
      .fold(0.0, (sum, t) => sum + t.amount);

  Icon getTransactionIcon(Transaction transaction) {
    if (transaction.type == TransactionType.income) {
      return const Icon(
        Icons.trending_up,
        size: 24,
        color: Color(0xFF48BB78),
      ); // text-secondary-600
    } else {
      return const Icon(
        Icons.trending_down,
        size: 24,
        color: Color(0xFFE53E3E),
      ); // text-red-600
    }
  }

  String formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat('MMM d').format(date);
    }
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
                    Color(0xFF805AD5), // to-accent-500
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
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Container(
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
                                  Icons.arrow_upward,
                                  size: 20,
                                  color: Colors.white,
                                ), // w-5 h-5
                                SizedBox(width: 8), // space-x-2
                                Text(
                                  'Total Income',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70, // opacity-80
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8), // mb-2
                            Text(
                              '৳${totalIncome.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
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
                                  Icons.arrow_downward,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Total Expenses',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '৳${totalExpenses.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16), // mb-4
                  // Search Bar
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                        _updateFiltersAndMonths(); // Recalculate counts
                      });
                    },
                    style: const TextStyle(color: Colors.white), // text-white
                    decoration: InputDecoration(
                      hintText: 'Search transactions...',
                      hintStyle: const TextStyle(
                        color: Colors.white60,
                      ), // placeholder-white/60
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.white60,
                      ), // text-white/60
                      filled: true,
                      fillColor: const Color(
                        0xFFFFFFFF,
                      ).withAlpha((0.1 * 255).round()), // bg-white/10
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16), // rounded-2xl
                        borderSide: const BorderSide(
                          color: Color(0xFFFFFFFF),
                          width: 0.2,
                        ), // border border-white/20
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xFFFFFFFF),
                          width: 0.2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xFFFFFFFF),
                          width: 0.4,
                        ), // focus:border-white/40
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                      ), // py-3
                    ),
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
                    // Filters
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text(
                                'Filters',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1A202C),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  const Icon(
                                    Icons.filter_list,
                                    size: 20,
                                    color: Color(0xFFA0AEC0),
                                  ), // w-5 h-5 text-gray-400
                                  const SizedBox(width: 8), // space-x-2
                                  DropdownButton<String>(
                                    value: _selectedMonth,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedMonth = newValue!;
                                        _updateFiltersAndMonths(); // Recalculate counts
                                      });
                                    },
                                    items:
                                        months.map<DropdownMenuItem<String>>((
                                          month,
                                        ) {
                                          return DropdownMenuItem<String>(
                                            value: month['id'],
                                            child: Text(month['label']),
                                          );
                                        }).toList(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF4A5568),
                                    ), // text-sm text-gray-700
                                    underline:
                                        Container(), // Removes the default underline
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    isDense: true,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16), // mb-4
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children:
                                  filters.map((filter) {
                                    final isSelected =
                                        _selectedFilter == filter['id'];
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        right: 8.0,
                                      ), // space-x-2
                                      child: ChoiceChip(
                                        label: Row(
                                          children: [
                                            Text(filter['label']),
                                            const SizedBox(width: 8),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                              decoration: BoxDecoration(
                                                color:
                                                    isSelected
                                                        ? const Color(
                                                          0xFFFFFFFF,
                                                        ).withAlpha(
                                                          (0.2 * 255).round(),
                                                        )
                                                        : const Color(
                                                          0xFFEDF2F7,
                                                        ), // bg-gray-200
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      999,
                                                    ), // rounded-full
                                              ),
                                              child: Text(
                                                '${filter['count']}',
                                                style: TextStyle(
                                                  fontSize: 10, // text-xs
                                                  color:
                                                      isSelected
                                                          ? Colors.white
                                                          : const Color(
                                                            0xFF4A5568,
                                                          ), // text-gray-600
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        selected: isSelected,
                                        onSelected: (selected) {
                                          setState(() {
                                            _selectedFilter = filter['id'];
                                          });
                                        },
                                        selectedColor: const Color(
                                          0xFF6B46C1,
                                        ), // bg-primary-500
                                        backgroundColor: const Color(
                                          0xFFF7FAFC,
                                        ), // bg-gray-100
                                        labelStyle: TextStyle(
                                          color:
                                              isSelected
                                                  ? Colors.white
                                                  : const Color(
                                                    0xFF2D3748,
                                                  ), // text-gray-700
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ), // rounded-2xl
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ), // px-4 py-2
                                      ),
                                    );
                                  }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24), // mb-6
                    // Transactions List
                    Container(
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
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: Text(
                              '${filteredTransactions.length} Transaction${filteredTransactions.length != 1 ? 's' : ''}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1A202C),
                              ),
                            ),
                          ),
                          const Divider(
                            height: 1,
                            color: Color(0xFFEDF2F7),
                          ), // border-b border-gray-100
                          filteredTransactions.isEmpty
                              ? Padding(
                                padding: const EdgeInsets.all(48),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      width: 64,
                                      height: 64,
                                      decoration: BoxDecoration(
                                        color: const Color(
                                          0xFFF7FAFC,
                                        ), // bg-gray-100
                                        borderRadius: BorderRadius.circular(
                                          999,
                                        ), // rounded-full
                                      ),
                                      child: const Icon(
                                        Icons.search,
                                        size: 32,
                                        color: Color(0xFFA0AEC0),
                                      ), // w-8 h-8 text-gray-400
                                    ),
                                    const SizedBox(height: 16), // mb-4
                                    const Text(
                                      'No transactions found',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF1A202C),
                                      ),
                                    ),
                                    const SizedBox(height: 8), // mb-2
                                    const Text(
                                      'Try adjusting your search or filter criteria',
                                      style: TextStyle(
                                        color: Color(0xFF4A5568),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              : ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: filteredTransactions.length,
                                separatorBuilder:
                                    (context, index) => const Divider(
                                      height: 1,
                                      color: Color(0xFFEDF2F7),
                                    ), // divide-y divide-gray-100
                                itemBuilder: (context, index) {
                                  final transaction =
                                      filteredTransactions[index];
                                  return InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(24), // p-6
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: 48,
                                            height: 48,
                                            decoration: BoxDecoration(
                                              color:
                                                  transaction.type ==
                                                          TransactionType.income
                                                      ? const Color(
                                                        0xFFF0FFF4,
                                                      ) // bg-secondary-100
                                                      : const Color(
                                                        0xFFFFF5F5,
                                                      ), // bg-red-100
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    16,
                                                  ), // rounded-2xl
                                            ),
                                            child: getTransactionIcon(
                                              transaction,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ), // space-x-4
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                      transaction.description,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Color(
                                                          0xFF1A202C,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      '${transaction.type == TransactionType.income ? '+' : '-'}৳${transaction.amount.toStringAsFixed(0)}',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                        color:
                                                            transaction.type ==
                                                                    TransactionType
                                                                        .income
                                                                ? const Color(
                                                                  0xFF48BB78,
                                                                ) // text-secondary-600
                                                                : const Color(
                                                                  0xFFE53E3E,
                                                                ), // text-red-600
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ), // mb-1
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                      transaction.category,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Color(
                                                          0xFF4A5568,
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        const Icon(
                                                          Icons.calendar_today,
                                                          size: 16,
                                                          color: Color(
                                                            0xFFA0AEC0,
                                                          ),
                                                        ), // w-4 h-4 text-gray-400
                                                        const SizedBox(
                                                          width: 8,
                                                        ), // space-x-2
                                                        Text(
                                                          formatDate(
                                                            transaction.date,
                                                          ),
                                                          style: const TextStyle(
                                                            fontSize: 12,
                                                            color: Color(
                                                              0xFF718096,
                                                            ), // text-gray-500
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                        ],
                      ),
                    ),

                    // Monthly Summary
                    if (filteredTransactions.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(top: 24), // mt-6
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
                              'Monthly Summary',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1A202C),
                              ),
                            ),
                            const SizedBox(height: 16), // mb-4
                            GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(16), // p-4
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFFF0FFF4,
                                    ), // bg-secondary-50
                                    borderRadius: BorderRadius.circular(
                                      16,
                                    ), // rounded-2xl
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '৳${totalIncome.toStringAsFixed(0)}',
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Color(
                                            0xFF48BB78,
                                          ), // text-secondary-600
                                        ),
                                      ),
                                      const SizedBox(height: 4), // mb-1
                                      const Text(
                                        'Total Income',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF4A5568),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF5F5), // bg-red-50
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '৳${totalExpenses.toStringAsFixed(0)}',
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Color(
                                            0xFFE53E3E,
                                          ), // text-red-600
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      const Text(
                                        'Total Expenses',
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
                            const SizedBox(height: 16), // mt-4
                            Container(
                              padding: const EdgeInsets.all(16), // p-4
                              decoration: BoxDecoration(
                                color: const Color(0xFFF7FAFC), // bg-gray-50
                                borderRadius: BorderRadius.circular(
                                  16,
                                ), // rounded-2xl
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '৳${(totalIncome - totalExpenses).abs().toStringAsFixed(0)}',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          (totalIncome - totalExpenses) >= 0
                                              ? const Color(
                                                0xFF48BB78,
                                              ) // text-secondary-600
                                              : const Color(
                                                0xFFE53E3E,
                                              ), // text-red-600
                                    ),
                                  ),
                                  const SizedBox(height: 4), // mb-1
                                  Text(
                                    'Net ${totalIncome - totalExpenses >= 0 ? 'Savings' : 'Deficit'}',
                                    style: const TextStyle(
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
                    const SizedBox(height: 24), // pb-6
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
