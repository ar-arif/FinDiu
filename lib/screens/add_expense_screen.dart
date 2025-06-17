import 'package:flutter/material.dart';
import '../main.dart'; // Import AppScreen enum

class AddExpenseScreen extends StatefulWidget {
  final Function(AppScreen) onNavigate;

  const AddExpenseScreen({super.key, required this.onNavigate});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedCategory;
  bool _showSuccess = false;

  final List<Map<String, dynamic>> categories = const [
    {
      'name': 'Tuition',
      'color': Color(0xFF3B82F6),
      'icon': Icons.school_outlined,
    }, // bg-blue-500
    {
      'name': 'Campus Food',
      'color': Color(0xFFF97316),
      'icon': Icons.restaurant_menu,
    }, // bg-orange-500
    {
      'name': 'One Card',
      'color': Color(0xFF8B5CF6),
      'icon': Icons.credit_card,
    }, // bg-purple-500
    {
      'name': 'Coffee',
      'color': Color(0xFFF59E0B),
      'icon': Icons.local_cafe,
    }, // bg-amber-500
    {
      'name': 'Exam Fees',
      'color': Color(0xFFEF4444),
      'icon': Icons.assignment,
    }, // bg-red-500
    {
      'name': 'Books & Supplies',
      'color': Color(0xFF22C55E),
      'icon': Icons.book,
    }, // bg-green-500
    {
      'name': 'Transport',
      'color': Color(0xFF06B6D4),
      'icon': Icons.directions_bus,
    }, // bg-cyan-500
    {
      'name': 'Hall Fees',
      'color': Color(0xFFEC4899),
      'icon': Icons.apartment,
    }, // bg-pink-500
  ];

  void _handleAddExpense() {
    if (_amountController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _selectedCategory != null) {
      setState(() {
        _showSuccess = true;
      });
      Future.delayed(const Duration(milliseconds: 1500), () {
        widget.onNavigate(AppScreen.dashboard);
      });
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_showSuccess) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFED8936), // from-secondary-500
                Color(0xFF6B46C1), // to-primary-500
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 80, // w-20
                  height: 80, // h-20
                  decoration: BoxDecoration(
                    color: const Color(
                      0xFFFFFFFF,
                    ).withAlpha((0.2 * 255).round()), // bg-white/20
                    borderRadius: BorderRadius.circular(999), // rounded-full
                  ),
                  child: const Icon(
                    Icons.check, // Check icon
                    color: Colors.white,
                    size: 40, // w-10 h-10
                  ),
                ),
                const SizedBox(height: 16), // mb-4
                const Text(
                  'Expense Added!',
                  style: TextStyle(
                    fontSize: 24, // text-2xl
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8), // mb-2
                const Text(
                  'Your campus transaction has been recorded',
                  style: TextStyle(
                    fontSize: 18, // text-lg
                    color: Colors.white70, // opacity-90
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
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF4A5568),
          ), // text-gray-700
          onPressed: () => widget.onNavigate(AppScreen.dashboard),
        ),
        title: const Text(
          'Add Campus Expense',
          style: TextStyle(
            fontSize: 20, // text-xl
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A202C), // text-gray-900
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24), // px-6 py-6 space-y-6
        child: Column(
          children: <Widget>[
            // Amount Input
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
                        Icons.calculate_outlined,
                        color: Color(0xFF6B46C1),
                        size: 24,
                      ), // text-primary-500 w-6 h-6
                      SizedBox(width: 12), // space-x-3
                      Text(
                        'Amount',
                        style: TextStyle(
                          fontSize: 18, // text-lg
                          fontWeight: FontWeight.w600, // font-semibold
                          color: Color(0xFF1A202C), // text-gray-900
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16), // mb-4
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 28, // text-3xl
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A202C), // text-gray-900
                    ),
                    decoration: InputDecoration(
                      hintText: '0',
                      hintStyle: TextStyle(
                        fontSize: 28, // text-3xl
                        fontWeight: FontWeight.bold,
                        color: const Color(
                          0xFFA0AEC0,
                        ).withAlpha((0.5 * 255).round()),
                      ), // text-gray-400
                      prefixText: '৳',
                      prefixStyle: const TextStyle(
                        fontSize: 28, // text-3xl
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFA0AEC0), // text-gray-400
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16), // rounded-2xl
                        borderSide: const BorderSide(
                          color: Color(0xFFEDF2F7),
                          width: 2,
                        ), // border-2 border-gray-200
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xFFEDF2F7),
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xFF6B46C1),
                          width: 2,
                        ), // focus:border-primary-500
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ), // py-4 pl-12 pr-4 (prefix handles left padding)
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24), // space-y-6
            // Description
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
                        Icons.tag_outlined,
                        color: Color(0xFF6B46C1),
                        size: 24,
                      ), // text-primary-500
                      SizedBox(width: 12),
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A202C),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _descriptionController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText:
                          'What did you spend on? (e.g., Green Garden lunch, Coffee at library)',
                      hintStyle: const TextStyle(color: Color(0xFFA0AEC0)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xFFEDF2F7),
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xFFEDF2F7),
                          width: 2,
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
                        vertical: 14,
                        horizontal: 16,
                      ), // px-4 py-3
                    ),
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
                        Icons.category_outlined,
                        color: Color(0xFF6B46C1),
                        size: 24,
                      ), // text-primary-500
                      SizedBox(width: 12),
                      Text(
                        'Campus Category',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A202C),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12, // gap-3
                          mainAxisSpacing: 12, // gap-3
                          childAspectRatio: 2.8, // Adjust as needed
                        ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final bool isSelected =
                          _selectedCategory == category['name'];
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selectedCategory = category['name'];
                          });
                        },
                        borderRadius: BorderRadius.circular(16), // rounded-2xl
                        child: Container(
                          padding: const EdgeInsets.all(16), // p-4
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? const Color(0xFFF0F4F8) // bg-primary-50
                                    : Colors.white, // Default background
                            borderRadius: BorderRadius.circular(16),
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
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: category['color'],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Icon(
                                    category['icon'],
                                    color: Colors.white,
                                    size:
                                        20, // text-lg corresponds to 20 here for icon size
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12), // space-x-3
                              Expanded(
                                child: Text(
                                  category['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500, // font-medium
                                    color: Color(0xFF1A202C), // text-gray-900
                                    fontSize: 14,
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
            const SizedBox(height: 24),

            // Add Button
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF6B46C1), // from-primary-500
                    const Color(0xFF805AD5), // to-accent-500
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(16), // rounded-2xl
              ),
              child: ElevatedButton(
                onPressed:
                    (_amountController.text.isNotEmpty &&
                            _descriptionController.text.isNotEmpty &&
                            _selectedCategory != null)
                        ? _handleAddExpense
                        : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16), // py-4
                ),
                child: const Text(
                  'Add Campus Expense',
                  style: TextStyle(
                    fontSize: 18, // text-lg
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
