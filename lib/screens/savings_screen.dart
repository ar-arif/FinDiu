import 'package:flutter/material.dart';
import '../main.dart'; // Import AppScreen enum
import 'package:intl/intl.dart'; // For number formatting

// Mock data for now, will be replaced with actual data models later
class SavingsGoal {
  final String id;
  final String title;
  final String category;
  final Color color;
  final double targetAmount;
  double currentAmount;
  final DateTime deadline;

  SavingsGoal({
    required this.id,
    required this.title,
    required this.category,
    required this.color,
    required this.targetAmount,
    required this.currentAmount,
    required this.deadline,
  });
}

List<SavingsGoal> mockSavingsGoals = [
  SavingsGoal(
    id: '1',
    title: 'New Laptop',
    category: 'Technology',
    color: const Color(0xFF8B5CF6), // purple-500
    targetAmount: 80000,
    currentAmount: 50000,
    deadline: DateTime.now().add(const Duration(days: 90)),
  ),
  SavingsGoal(
    id: '2',
    title: 'Study Abroad',
    category: 'Education',
    color: const Color(0xFF3B82F6), // blue-500
    targetAmount: 200000,
    currentAmount: 25000,
    deadline: DateTime.now().add(const Duration(days: 365)),
  ),
  SavingsGoal(
    id: '3',
    title: 'Emergency Fund',
    category: 'Emergency',
    color: const Color(0xFFF97316), // orange-500
    targetAmount: 50000,
    currentAmount: 4500,
    deadline: DateTime.now().add(const Duration(days: 180)),
  ),
];

class SavingsScreen extends StatefulWidget {
  final Function(AppScreen) onNavigate;

  const SavingsScreen({super.key, required this.onNavigate});

  @override
  State<SavingsScreen> createState() => _SavingsScreenState();
}

class _SavingsScreenState extends State<SavingsScreen> {
  bool _showCreateModal = false;
  bool _showAddMoneyModal = false;
  String? _selectedGoalId;
  final TextEditingController _addAmountController = TextEditingController();
  final TextEditingController _newGoalTitleController = TextEditingController();
  final TextEditingController _newGoalTargetAmountController =
      TextEditingController();
  DateTime? _newGoalDeadline;
  String _newGoalCategory = 'Education';

  final List<Map<String, dynamic>> categories = const [
    {
      'name': 'Education',
      'color': Color(0xFF3B82F6),
      'icon': Icons.school_outlined,
    }, // bg-blue-500
    {
      'name': 'Technology',
      'color': Color(0xFF8B5CF6),
      'icon': Icons.laptop_mac,
    }, // bg-purple-500
    {
      'name': 'Emergency',
      'color': Color(0xFFF97316),
      'icon': Icons.medical_services_outlined,
    }, // bg-orange-500
    {
      'name': 'Travel',
      'color': Color(0xFF22C55E),
      'icon': Icons.card_travel,
    }, // bg-green-500
    {
      'name': 'Books',
      'color': Color(0xFFEF4444),
      'icon': Icons.book_outlined,
    }, // bg-red-500
    {
      'name': 'Other',
      'color': Color(0xFF6B7280),
      'icon': Icons.category_outlined,
    }, // bg-gray-500
  ];

  @override
  void dispose() {
    _addAmountController.dispose();
    _newGoalTitleController.dispose();
    _newGoalTargetAmountController.dispose();
    super.dispose();
  }

  void _handleCreateGoal() {
    if (_newGoalTitleController.text.isNotEmpty &&
        _newGoalTargetAmountController.text.isNotEmpty &&
        _newGoalDeadline != null) {
      setState(() {
        mockSavingsGoals.add(
          SavingsGoal(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            title: _newGoalTitleController.text,
            targetAmount: double.parse(_newGoalTargetAmountController.text),
            currentAmount: 0,
            deadline: _newGoalDeadline!,
            category: _newGoalCategory,
            color:
                categories.firstWhere(
                  (cat) => cat['name'] == _newGoalCategory,
                )['color'],
          ),
        );
        _showCreateModal = false;
        _newGoalTitleController.clear();
        _newGoalTargetAmountController.clear();
        _newGoalDeadline = null;
        _newGoalCategory = 'Education';
      });
    }
  }

  void _handleAddMoney() {
    if (_addAmountController.text.isNotEmpty && _selectedGoalId != null) {
      setState(() {
        final goal = mockSavingsGoals.firstWhere(
          (g) => g.id == _selectedGoalId,
        );
        goal.currentAmount += double.parse(_addAmountController.text);
        _showAddMoneyModal = false;
        _addAmountController.clear();
        _selectedGoalId = null;
      });
    }
  }

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
    final totalSaved = mockSavingsGoals.fold(
      0.0,
      (sum, goal) => sum + goal.currentAmount,
    );

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // Header
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFFED8936), // from-secondary-500
                        Color(0xFF6B46C1), // to-primary-500
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 20,
                            ), // w-5 h-5
                            onPressed:
                                () => widget.onNavigate(AppScreen.dashboard),
                          ),
                          const SizedBox(width: 16), // space-x-4
                          const Text(
                            'Savings Goals',
                            style: TextStyle(
                              fontSize: 20, // text-xl
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24), // mb-6
                      // Total Savings
                      Container(
                        padding: const EdgeInsets.all(24), // p-6
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFFFFFFFF,
                          ).withAlpha((0.1 * 255).round()), // bg-white/10
                          borderRadius: BorderRadius.circular(
                            24,
                          ), // rounded-3xl
                        ),
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              const Text(
                                'Total Saved',
                                style: TextStyle(
                                  fontSize: 14, // text-sm
                                  color: Colors.white70, // opacity-80
                                ),
                              ),
                              const SizedBox(height: 4), // mb-1
                              Text(
                                _formatCurrency(totalSaved), // '৳79,500',
                                style: const TextStyle(
                                  fontSize: 28, // text-3xl
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 16), // mb-4
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(
                                    Icons.trending_up,
                                    color: Colors.white,
                                    size: 16,
                                  ), // w-4 h-4
                                  SizedBox(width: 8), // space-x-2
                                  Text(
                                    '+12% this month',
                                    style: TextStyle(
                                      fontSize: 14, // text-sm
                                      color: Colors.white70, // opacity-90
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
                      children: [
                        // Add New Goal Button
                        InkWell(
                          onTap: () {
                            setState(() {
                              _showCreateModal = true;
                            });
                          },
                          borderRadius: BorderRadius.circular(
                            24,
                          ), // rounded-3xl
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16), // p-4
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                24,
                              ), // rounded-3xl
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withAlpha(
                                    (0.1 * 255).round(),
                                  ),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3), // shadow-sm
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 48, // w-12
                                  height: 48, // h-12
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFFED8936), // from-secondary-500
                                        Color(0xFF6B46C1), // to-primary-500
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      16,
                                    ), // rounded-2xl
                                  ),
                                  child: const Icon(
                                    Icons.add, // Plus icon
                                    color: Colors.white,
                                    size: 24, // w-6 h-6
                                  ),
                                ),
                                const SizedBox(width: 12), // space-x-3
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const <Widget>[
                                      Text(
                                        'Create New Goal',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF1A202C),
                                        ),
                                      ),
                                      Text(
                                        'Start saving for something special',
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
                        ),
                        const SizedBox(height: 24), // mb-6
                        // Savings Goals List
                        Column(
                          children:
                              mockSavingsGoals.map((goal) {
                                final double progress =
                                    (goal.currentAmount / goal.targetAmount);
                                final int daysLeft =
                                    goal.deadline
                                        .difference(DateTime.now())
                                        .inDays;
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 16.0,
                                  ), // space-y-4
                                  child: Container(
                                    padding: const EdgeInsets.all(24), // p-6
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                        24,
                                      ), // rounded-3xl
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withAlpha(
                                            (0.1 * 255).round(),
                                          ),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  width: 48, // w-12
                                                  height: 48, // h-12
                                                  decoration: BoxDecoration(
                                                    color: goal.color,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          16,
                                                        ), // rounded-2xl
                                                  ),
                                                  child: const Icon(
                                                    Icons.flag,
                                                    color: Colors.white,
                                                    size: 24,
                                                  ), // w-6 h-6
                                                ),
                                                const SizedBox(
                                                  width: 12,
                                                ), // space-x-3
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      goal.title,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Color(
                                                          0xFF1A202C,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      goal.category,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Color(
                                                          0xFF4A5568,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Text(
                                              daysLeft > 0
                                                  ? '$daysLeft days left'
                                                  : 'Goal Reached!',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color:
                                                    daysLeft > 0
                                                        ? const Color(
                                                          0xFF4A5568,
                                                        )
                                                        : Colors
                                                            .green[700], // text-gray-600
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16), // mb-4
                                        // Progress Bar
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                const Text(
                                                  'Progress',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xFF4A5568),
                                                  ),
                                                ),
                                                Text(
                                                  '${(progress * 100).toStringAsFixed(0)}%',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8), // mb-2
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    99,
                                                  ), // rounded-full
                                              child: LinearProgressIndicator(
                                                value: progress.clamp(
                                                  0.0,
                                                  1.0,
                                                ), // Ensure progress is between 0 and 1
                                                backgroundColor: const Color(
                                                  0xFFEDF2F7,
                                                ), // bg-gray-200
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                      Color
                                                    >(
                                                      goal.color,
                                                    ), // dynamic color
                                                minHeight: 12, // h-3
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16), // mb-4

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                const Text(
                                                  'Saved',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xFF4A5568),
                                                  ),
                                                ),
                                                Text(
                                                  _formatCurrency(
                                                    goal.currentAmount,
                                                  ),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: <Widget>[
                                                const Text(
                                                  'Target',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xFF4A5568),
                                                  ),
                                                ),
                                                Text(
                                                  _formatCurrency(
                                                    goal.targetAmount,
                                                  ),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16), // mb-4
                                        // Add Money Button
                                        Container(
                                          width: double.infinity,
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 24,
                                          ),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                _selectedGoalId = goal.id;
                                                _showAddMoneyModal = true;
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color(
                                                0xFF6B46C1,
                                              ), // primary-500
                                              foregroundColor: Colors.white,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 16,
                                                  ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      16,
                                                    ), // rounded-2xl
                                              ),
                                              elevation: 0,
                                            ),
                                            child: const Text(
                                              'Add Money',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Create Goal Modal
          if (_showCreateModal)
            Container(
              color: Colors.black54, // Fixed inset-0 bg-black/50
              alignment: Alignment.center,
              padding: const EdgeInsets.all(24),
              child: Material(
                color: Colors.transparent, // Ensure no extra background
                child: Container(
                  padding: const EdgeInsets.all(24), // p-6
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24), // rounded-3xl
                  ),
                  width: double.infinity,
                  constraints: const BoxConstraints(
                    maxWidth: 400,
                    maxHeight: 600,
                  ), // max-w-md max-h-[90vh]
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text(
                              'Create New Goal',
                              style: TextStyle(
                                fontSize: 20, // text-xl
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1A202C),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: Color(0xFF4A5568),
                                size: 16,
                              ), // w-4 h-4
                              onPressed: () {
                                setState(() {
                                  _showCreateModal = false;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 24), // mb-6
                        // Form Fields
                        Column(
                          children: <Widget>[
                            // Goal Title
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  'Goal Title',
                                  style: TextStyle(
                                    fontSize: 14, // text-sm
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF4A5568),
                                  ),
                                ),
                                const SizedBox(height: 8), // mb-2
                                TextField(
                                  controller: _newGoalTitleController,
                                  decoration: InputDecoration(
                                    hintText: 'e.g., New Laptop, Study Abroad',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                        color: Color(0xFFEDF2F7),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                        color: Color(0xFFEDF2F7),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                        color: Color(0xFF6B46C1),
                                        width: 2,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16), // space-y-4
                            // Target Amount
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  'Target Amount',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF4A5568),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextField(
                                  controller: _newGoalTargetAmountController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: '0',
                                    prefixText: '৳',
                                    prefixStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFA0AEC0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                        color: Color(0xFFEDF2F7),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                        color: Color(0xFFEDF2F7),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                        color: Color(0xFF6B46C1),
                                        width: 2,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Category
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  'Category',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF4A5568),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 8, // gap-2
                                        mainAxisSpacing: 8, // gap-2
                                        childAspectRatio:
                                            3.5, // Adjust as needed
                                      ),
                                  itemCount: categories.length,
                                  itemBuilder: (context, index) {
                                    final category = categories[index];
                                    final bool isSelected =
                                        _newGoalCategory == category['name'];
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          _newGoalCategory = category['name'];
                                        });
                                      },
                                      borderRadius: BorderRadius.circular(16),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ), // p-3
                                        decoration: BoxDecoration(
                                          color:
                                              isSelected
                                                  ? const Color(
                                                    0xFFF0F4F8,
                                                  ) // bg-primary-50
                                                  : Colors
                                                      .white, // Default background
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          border: Border.all(
                                            color:
                                                isSelected
                                                    ? const Color(
                                                      0xFF6B46C1,
                                                    ) // border-primary-500
                                                    : const Color(
                                                      0xFFEDF2F7,
                                                    ), // border-gray-200
                                            width: 2,
                                          ),
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: 24, // w-6
                                              height: 24, // h-6
                                              decoration: BoxDecoration(
                                                color: category['color'],
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      8,
                                                    ), // rounded-lg
                                              ),
                                              child: Icon(
                                                category['icon'],
                                                color: Colors.white,
                                                size: 16, // w-4 h-4
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ), // space-x-2
                                            Expanded(
                                              child: Text(
                                                category['name'],
                                                style: const TextStyle(
                                                  fontSize: 14, // text-sm
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF1A202C),
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
                            const SizedBox(height: 16),

                            // Deadline
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  'Target Date',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF4A5568),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                InkWell(
                                  onTap: () async {
                                    final DateTime? pickedDate =
                                        await showDatePicker(
                                          context: context,
                                          initialDate:
                                              _newGoalDeadline ??
                                              DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2101),
                                        );
                                    if (pickedDate != null &&
                                        pickedDate != _newGoalDeadline) {
                                      setState(() {
                                        _newGoalDeadline = pickedDate;
                                      });
                                    }
                                  },
                                  child: InputDecorator(
                                    decoration: InputDecoration(
                                      hintText: 'Select Date',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: const BorderSide(
                                          color: Color(0xFFEDF2F7),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: const BorderSide(
                                          color: Color(0xFFEDF2F7),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: const BorderSide(
                                          color: Color(0xFF6B46C1),
                                          width: 2,
                                        ),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            vertical: 12,
                                            horizontal: 16,
                                          ),
                                    ),
                                    child: Text(
                                      _newGoalDeadline != null
                                          ? DateFormat(
                                            'yyyy-MM-dd',
                                          ).format(_newGoalDeadline!)
                                          : 'Select Date',
                                      style: TextStyle(
                                        color:
                                            _newGoalDeadline != null
                                                ? Colors.black
                                                : Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24), // mt-6

                        Row(
                          children: <Widget>[
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _showCreateModal = false;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(
                                    0xFFEDF2F7,
                                  ), // bg-gray-100
                                  foregroundColor: const Color(
                                    0xFF1A202C,
                                  ), // text-gray-900
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ), // py-3
                                  elevation: 0,
                                ),
                                child: const Text('Cancel'),
                              ),
                            ),
                            const SizedBox(width: 12), // space-x-3
                            Expanded(
                              child: ElevatedButton(
                                onPressed:
                                    (_newGoalTitleController.text.isNotEmpty &&
                                            _newGoalTargetAmountController
                                                .text
                                                .isNotEmpty &&
                                            _newGoalDeadline != null)
                                        ? _handleCreateGoal
                                        : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(
                                    0xFF6B46C1,
                                  ), // primary-500
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  elevation: 0,
                                ),
                                child: const Text('Create Goal'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // Add Money Modal
          if (_showAddMoneyModal)
            Container(
              color: Colors.black54,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(24),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 400), // max-w-md
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            'Add Money to Goal',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A202C),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Color(0xFF4A5568),
                              size: 16,
                            ),
                            onPressed: () {
                              setState(() {
                                _showAddMoneyModal = false;
                                _addAmountController.clear();
                                _selectedGoalId = null;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Amount to add',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF4A5568),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _addAmountController,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              hintText: '0',
                              prefixText: '৳',
                              prefixStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFA0AEC0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Color(0xFFEDF2F7),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Color(0xFFEDF2F7),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Color(0xFF6B46C1),
                                  width: 2,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _showAddMoneyModal = false;
                                  _addAmountController.clear();
                                  _selectedGoalId = null;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFEDF2F7),
                                foregroundColor: const Color(0xFF1A202C),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                elevation: 0,
                              ),
                              child: const Text('Cancel'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed:
                                  (_addAmountController.text.isNotEmpty &&
                                          _selectedGoalId != null)
                                      ? _handleAddMoney
                                      : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF6B46C1),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                elevation: 0,
                              ),
                              child: const Text('Add Money'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
