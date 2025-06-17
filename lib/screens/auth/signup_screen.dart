import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../dashboard/dashboard_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _studentIdController = TextEditingController();
  final _universityController = TextEditingController();
  final _programController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String _selectedYear = '1st Year';

  final List<String> _years = [
    '1st Year',
    '2nd Year',
    '3rd Year',
    '4th Year',
    'Masters',
    'PhD',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _studentIdController.dispose();
    _universityController.dispose();
    _programController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    final success = await authProvider.signUpWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      name: _nameController.text.trim(),
      studentId: _studentIdController.text.trim(),
      university: _universityController.text.trim(),
      program: _programController.text.trim(),
      year: _selectedYear,
    );

    if (success && mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.error ?? 'Signup failed'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF0FDF4),
              Color(0xFFEFF6FF),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  
                  // Header
                  const Text(
                    'Join FinDiu',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 8),
                  
                  const Text(
                    'Create your student banking account',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Personal Information
                  CustomTextField(
                    controller: _nameController,
                    label: 'Full Name',
                    prefixIcon: Icons.person_outline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  CustomTextField(
                    controller: _emailController,
                    label: 'University Email',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Academic Information
                  CustomTextField(
                    controller: _studentIdController,
                    label: 'Student ID',
                    prefixIcon: Icons.school_outlined,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your student ID';
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  CustomTextField(
                    controller: _universityController,
                    label: 'University',
                    prefixIcon: Icons.account_balance_outlined,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your university';
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  CustomTextField(
                    controller: _programController,
                    label: 'Program/Major',
                    prefixIcon: Icons.book_outlined,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your program';
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Year Dropdown
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.surfaceVariant),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: _selectedYear,
                      decoration: const InputDecoration(
                        labelText: 'Academic Year',
                        prefixIcon: Icon(Icons.calendar_today_outlined),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      ),
                      items: _years.map((year) {
                        return DropdownMenuItem(
                          value: year,
                          child: Text(year),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedYear = value!;
                        });
                      },
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Password Fields
                  CustomTextField(
                    controller: _passwordController,
                    label: 'Password',
                    prefixIcon: Icons.lock_outline,
                    obscureText: _obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.textSecondary,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  CustomTextField(
                    controller: _confirmPasswordController,
                    label: 'Confirm Password',
                    prefixIcon: Icons.lock_outline,
                    obscureText: _obscureConfirmPassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.textSecondary,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Signup Button
                  Consumer<AuthProvider>(
                    builder: (context, authProvider, child) {
                      return CustomButton(
                        onPressed: authProvider.isLoading ? null : _handleSignup,
                        isLoading: authProvider.isLoading,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Create Account'),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, size: 20),
                          ],
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Login Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.w600,
                          ),
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
    );
  }
}