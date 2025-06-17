import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/transaction_provider.dart';
import '../../models/transaction_model.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  String _selectedCategory = 'Tuition';
  bool _showSuccess = false;

  final List<Map<String, dynamic>> _categories = [
    {'name': 'Tuition', 'color': Colors.blue, 'icon': '🎓'},
    {'name': 'Campus Food', 'color': Colors.orange, 'icon': '🍽️'},
    {'name': 'One Card', 'color': Colors.purple, 'icon': '💳'},
    {'name': 'Coffee', 'color': Colors.amber, 'icon': '☕'},
    {'name': 'Exam Fees', 'color': Colors.red, 'icon': '📝'},
    {'name': 'Books & Supplies', 'color': Colors.green, 'icon': '📚'},
    {'name': 'Transport', 'color': Colors.cyan, 'icon': '🚌'},
    {'name': 'Hall Fees', 'color': Colors.pink, 'icon': '🏢'},
  ];

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _handleAddExpense() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final transactionProvider = Provider.of<TransactionProvider>(context, listen: false);

    if (authProvider.user == null) return;

    final transaction = TransactionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: authProvider.user!.uid,
      amount: double.parse(_amountController.text),
      description: _descriptionController.text.trim(),
      category: _selectedCategory,
      type: TransactionType.expense,
      date: DateTime.now(),
      createdAt: DateTime.now(),
    );

    final success = await transactionProvider.addTransaction(transaction);

    if (success) {
      setState(() {
        _showSuccess = true;
      });
      
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.of(context).pop();
        }
      });
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(transactionProvider.error ?? 'Failed to add expense'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_showSuccess) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.secondaryGradient,
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  size: 80,
                  color: Colors.white,
                ),
                SizedBox(height: 24),
                Text(
                  'Expense Added!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Your campus transaction has been recorded',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Campus Expense'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Amount Input
              Container(
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
                    const Row(
                      children: [
                        Icon(Icons.calculate, color: AppColors.primary),
                        SizedBox(width: 12),
                        Text(
                          'Amount',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      decoration: const InputDecoration(
                        prefixText: '৳',
                        prefixStyle: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textSecondary,
                        ),
                        hintText: '0',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an amount';
                        }
                        if (double.tryParse(value) == null || double.parse(value) <= 0) {
                          return 'Please enter a valid amount';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Description
              Container(
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
                    const Row(
                      children: [
                        Icon(Icons.description, color: AppColors.primary),
                        SizedBox(width: 12),
                        Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _descriptionController,
                      label: 'What did you spend on? (e.g., Green Garden lunch, Coffee at library)',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Category Selection
              Container(
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
                    const Row(
                      children: [
                        Icon(Icons.category, color: AppColors.primary),
                        SizedBox(width: 12),
                        Text(
                          'Campus Category',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 3,
                      ),
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        final isSelected = _selectedCategory == category['name'];
                        
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCategory = category['name'];
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isSelected 
                                  ? AppColors.primary.withOpacity(0.1)
                                  : AppColors.surfaceVariant,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected 
                                    ? AppColors.primary
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: category['color'],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      category['icon'],
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    category['name'],
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected 
                                          ? AppColors.primary
                                          : AppColors.textPrimary,
                                    ),
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
              
              const SizedBox(height: 32),
              
              // Add Button
              Consumer<TransactionProvider>(
                builder: (context, transactionProvider, child) {
                  return CustomButton(
                    onPressed: transactionProvider.isLoading ? null : _handleAddExpense,
                    isLoading: transactionProvider.isLoading,
                    child: const Text(
                      'Add Campus Expense',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}