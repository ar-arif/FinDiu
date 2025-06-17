import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../providers/auth_provider.dart';
import '../../providers/savings_provider.dart';
import '../../models/savings_goal_model.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class SavingsScreen extends StatefulWidget {
  const SavingsScreen({super.key});

  @override
  State<SavingsScreen> createState() => _SavingsScreenState();
}

class _SavingsScreenState extends State<SavingsScreen> {
  bool _showCreateModal = false;
  bool _showAddMoneyModal = false;
  String _selectedGoalId = '';
  
  final _titleController = TextEditingController();
  final _targetAmountController = TextEditingController();
  final _addAmountController = TextEditingController();
  final _deadlineController = TextEditingController();
  
  String _selectedCategory = 'Education';
  
  final List<Map<String, dynamic>> _categories = [
    {'name': 'Education', 'color': Colors.blue},
    {'name': 'Technology', 'color': Colors.purple},
    {'name': 'Emergency', 'color': Colors.orange},
    {'name': 'Travel', 'color': Colors.green},
    {'name': 'Books', 'color': Colors.red},
    {'name': 'Other', 'color': Colors.grey},
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _targetAmountController.dispose();
    _addAmountController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }

  Future<void> _handleCreateGoal() async {
    if (_titleController.text.isEmpty || 
        _targetAmountController.text.isEmpty || 
        _deadlineController.text.isEmpty) {
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final savingsProvider = Provider.of<SavingsProvider>(context, listen: false);

    if (authProvider.user == null) return;

    final goal = SavingsGoalModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: authProvider.user!.uid,
      title: _titleController.text.trim(),
      targetAmount: double.parse(_targetAmountController.text),
      currentAmount: 0,
      category: _selectedCategory,
      deadline: DateTime.parse(_deadlineController.text),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final success = await savingsProvider.addSavingsGoal(goal);

    if (success) {
      _clearForm();
      setState(() {
        _showCreateModal = false;
      });
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(savingsProvider.error ?? 'Failed to create goal'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _handleAddMoney() async {
    if (_addAmountController.text.isEmpty || _selectedGoalId.isEmpty) return;

    final savingsProvider = Provider.of<SavingsProvider>(context, listen: false);
    final amount = double.parse(_addAmountController.text);

    final success = await savingsProvider.addMoneyToGoal(_selectedGoalId, amount);

    if (success) {
      _addAmountController.clear();
      setState(() {
        _showAddMoneyModal = false;
        _selectedGoalId = '';
      });
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(savingsProvider.error ?? 'Failed to add money'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _clearForm() {
    _titleController.clear();
    _targetAmountController.clear();
    _deadlineController.clear();
    _selectedCategory = 'Education';
  }

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
          gradient: AppColors.secondaryGradient,
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
                          'Savings Goals',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Total Savings
                    Consumer<SavingsProvider>(
                      builder: (context, savingsProvider, child) {
                        return Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Total Saved',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                currencyFormat.format(savingsProvider.totalSaved),
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.trending_up, color: Colors.white, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    '+12% this month',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
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
                      // Add New Goal Button
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _showCreateModal = true;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
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
                            child: Row(
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    gradient: AppColors.secondaryGradient,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Create New Goal',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                      Text(
                                        'Start saving for something special',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      
                      // Savings Goals List
                      Expanded(
                        child: Consumer<SavingsProvider>(
                          builder: (context, savingsProvider, child) {
                            if (savingsProvider.savingsGoals.isEmpty) {
                              return const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.savings,
                                      size: 64,
                                      color: AppColors.textTertiary,
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'No savings goals yet',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Create your first goal to start saving',
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
                              itemCount: savingsProvider.savingsGoals.length,
                              itemBuilder: (context, index) {
                                final goal = savingsProvider.savingsGoals[index];
                                return _buildGoalItem(goal, currencyFormat);
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
      
      // Modals
      bottomSheet: _showCreateModal ? _buildCreateGoalModal() : 
                  _showAddMoneyModal ? _buildAddMoneyModal() : null,
    );
  }

  Widget _buildGoalItem(SavingsGoalModel goal, NumberFormat currencyFormat) {
    final progress = goal.progress;
    final daysLeft = goal.daysLeft;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.savings,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        goal.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        goal.category,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                '$daysLeft days left',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Progress
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Progress',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
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
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Amounts
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Saved',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    currencyFormat.format(goal.currentAmount),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Target',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    currencyFormat.format(goal.targetAmount),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Add Money Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedGoalId = goal.id;
                  _showAddMoneyModal = true;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.surfaceVariant,
                foregroundColor: AppColors.textPrimary,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('৳', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(width: 8),
                  Text('Add Money'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateGoalModal() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Create New Goal',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      _showCreateModal = false;
                    });
                    _clearForm();
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            CustomTextField(
              controller: _titleController,
              label: 'Goal Title (e.g., New Laptop, Study Abroad)',
            ),
            
            const SizedBox(height: 16),
            
            CustomTextField(
              controller: _targetAmountController,
              label: 'Target Amount',
              keyboardType: TextInputType.number,
            ),
            
            const SizedBox(height: 16),
            
            // Category Selection
            const Text(
              'Category',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _categories.map((category) {
                final isSelected = _selectedCategory == category['name'];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = category['name'];
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: category['color'],
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          category['name'],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            
            const SizedBox(height: 16),
            
            CustomTextField(
              controller: _deadlineController,
              label: 'Target Date',
              keyboardType: TextInputType.datetime,
            ),
            
            const SizedBox(height: 32),
            
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _showCreateModal = false;
                      });
                      _clearForm();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.surfaceVariant,
                      foregroundColor: AppColors.textPrimary,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Consumer<SavingsProvider>(
                    builder: (context, savingsProvider, child) {
                      return CustomButton(
                        onPressed: savingsProvider.isLoading ? null : _handleCreateGoal,
                        isLoading: savingsProvider.isLoading,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.save, size: 16),
                            SizedBox(width: 8),
                            Text('Create Goal'),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddMoneyModal() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Consumer<SavingsProvider>(
          builder: (context, savingsProvider, child) {
            final selectedGoal = savingsProvider.savingsGoals
                .where((goal) => goal.id == _selectedGoalId)
                .firstOrNull;
            
            if (selectedGoal == null) return const SizedBox();
            
            final currencyFormat = NumberFormat.currency(
              locale: 'en_BD',
              symbol: '৳',
              decimalDigits: 0,
            );
            
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Add Money',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          _showAddMoneyModal = false;
                          _selectedGoalId = '';
                        });
                        _addAmountController.clear();
                      },
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // Goal Info
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.savings,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selectedGoal.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              'Current: ${currencyFormat.format(selectedGoal.currentAmount)} / ${currencyFormat.format(selectedGoal.targetAmount)}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Amount Input
                const Text(
                  'Amount to Add',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _addAmountController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  decoration: const InputDecoration(
                    prefixText: '৳',
                    prefixStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                    ),
                    hintText: '0',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(color: AppColors.surfaceVariant),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(color: AppColors.primary),
                    ),
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Quick Amount Buttons
                Row(
                  children: [500, 1000, 2000].map((amount) {
                    return Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        child: ElevatedButton(
                          onPressed: () {
                            _addAmountController.text = amount.toString();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.surfaceVariant,
                            foregroundColor: AppColors.textPrimary,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text('৳$amount'),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                
                const Spacer(),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _showAddMoneyModal = false;
                            _selectedGoalId = '';
                          });
                          _addAmountController.clear();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.surfaceVariant,
                          foregroundColor: AppColors.textPrimary,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomButton(
                        onPressed: savingsProvider.isLoading ? null : _handleAddMoney,
                        isLoading: savingsProvider.isLoading,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('৳', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            SizedBox(width: 8),
                            Text('Add Money'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}