import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _studentIdController = TextEditingController();
  final _universityController = TextEditingController();
  final _programController = TextEditingController();
  final _addressController = TextEditingController();
  
  String _selectedYear = '1st Year';
  bool _showSuccess = false;

  final List<String> _years = [
    '1st Year',
    '2nd Year',
    '3rd Year',
    '4th Year',
    'Masters',
    'PhD',
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.userModel;
    
    if (user != null) {
      _nameController.text = user.name;
      _emailController.text = user.email;
      _phoneController.text = user.phone ?? '';
      _studentIdController.text = user.studentId;
      _universityController.text = user.university;
      _programController.text = user.program;
      _addressController.text = user.address ?? '';
      _selectedYear = user.year;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _studentIdController.dispose();
    _universityController.dispose();
    _programController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final currentUser = authProvider.userModel;
    
    if (currentUser == null) return;

    final updatedUser = currentUser.copyWith(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      studentId: _studentIdController.text.trim(),
      university: _universityController.text.trim(),
      program: _programController.text.trim(),
      year: _selectedYear,
      address: _addressController.text.trim(),
    );

    final success = await authProvider.updateProfile(updatedUser);

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
            content: Text(authProvider.error ?? 'Failed to update profile'),
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
                  'Profile Updated!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Your information has been saved successfully',
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.accentGradient,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back, color: Colors.white),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            const Text(
                              'Edit Profile',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Consumer<AuthProvider>(
                          builder: (context, authProvider, child) {
                            return TextButton(
                              onPressed: authProvider.isLoading ? null : _handleSave,
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white.withOpacity(0.2),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Text(
                                'Save',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Profile Picture
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                              Positioned(
                                bottom: -4,
                                right: -4,
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Tap to change photo',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
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
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Personal Information
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
                                const Text(
                                  'Personal Information',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 16),
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
                                  label: 'Email Address',
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
                                CustomTextField(
                                  controller: _phoneController,
                                  label: 'Phone Number',
                                  prefixIcon: Icons.phone_outlined,
                                  keyboardType: TextInputType.phone,
                                ),
                                const SizedBox(height: 16),
                                CustomTextField(
                                  controller: _addressController,
                                  label: 'Address',
                                  prefixIcon: Icons.location_on_outlined,
                                ),
                              ],
                            ),
                          ),
                          
                          const SizedBox(height: 24),
                          
                          // Academic Information
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
                                const Text(
                                  'Academic Information',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 16),
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
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your program';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: AppColors.surfaceVariant),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 10,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value: _selectedYear,
                                    decoration: const InputDecoration(
                                      labelText: 'Academic Year',
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
                              ],
                            ),
                          ),
                          
                          const SizedBox(height: 32),
                          
                          // Save Button
                          Consumer<AuthProvider>(
                            builder: (context, authProvider, child) {
                              return CustomButton(
                                onPressed: authProvider.isLoading ? null : _handleSave,
                                isLoading: authProvider.isLoading,
                                child: const Text(
                                  'Save Changes',
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}