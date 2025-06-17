import 'package:flutter/material.dart';
import '../main.dart'; // Import AppScreen enum
import 'dart:async'; // For Future.delayed

class ProfileEditScreen extends StatefulWidget {
  final Function(AppScreen) onNavigate;

  const ProfileEditScreen({super.key, required this.onNavigate});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final TextEditingController _nameController = TextEditingController(
    text: 'Md Ariful Islam',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'arif-itm@diu.edu.bd',
  );
  final TextEditingController _phoneController = TextEditingController(
    text: '+880 1700-123456',
  );
  final TextEditingController _studentIdController = TextEditingController(
    text: '1234567890',
  );
  final TextEditingController _universityController = TextEditingController(
    text: 'Daffodil International University',
  );
  final TextEditingController _programController = TextEditingController(
    text: 'Information Technology & Management',
  );
  final TextEditingController _addressController = TextEditingController(
    text: 'Dhaka, Bangladesh',
  );
  String _selectedYear = '3rd Year';

  bool _showSuccess = false;

  void _handleSave() {
    setState(() {
      _showSuccess = true;
    });
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _showSuccess = false;
      });
      widget.onNavigate(AppScreen.profile);
    });
  }

  void _handlePhotoChange() {
    // Simulate photo change
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Photo change functionality would be implemented here'),
      ),
    );
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
                    Icons.save_outlined, // Save icon
                    color: Colors.white,
                    size: 40, // w-10 h-10
                  ),
                ),
                const SizedBox(height: 16), // mb-4
                const Text(
                  'Profile Updated!',
                  style: TextStyle(
                    fontSize: 24, // text-2xl
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8), // mb-2
                const Text(
                  'Your information has been saved successfully',
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
                    Color(0xFF805AD5), // from-accent-500
                    Color(0xFF6B46C1), // to-primary-500
                  ],
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 20,
                            ),
                            onPressed:
                                () => widget.onNavigate(AppScreen.profile),
                          ),
                          const SizedBox(width: 16),
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
                      ElevatedButton(
                        onPressed: _handleSave,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFFFFFFFF,
                          ).withAlpha((0.2 * 255).round()), // bg-white/20
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              16,
                            ), // rounded-2xl
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ), // px-4 py-2
                          elevation: 0,
                        ),
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Profile Picture
                  Container(
                    padding: const EdgeInsets.all(24), // p-6
                    decoration: BoxDecoration(
                      color: const Color(
                        0xFFFFFFFF,
                      ).withAlpha((0.1 * 255).round()), // bg-white/10
                      borderRadius: BorderRadius.circular(24), // rounded-3xl
                    ),
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 80, // w-20
                            height: 80, // h-20
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFFFFFFFF,
                              ).withAlpha((0.2 * 255).round()), // bg-white/20
                              borderRadius: BorderRadius.circular(
                                999,
                              ), // rounded-full
                            ),
                            child: const Icon(
                              Icons.person_outline,
                              size: 40, // w-10 h-10
                              color: Colors.white,
                            ),
                          ),
                          Positioned(
                            bottom: -8, // -bottom-2
                            right: -8, // -right-2
                            child: InkWell(
                              onTap: _handlePhotoChange,
                              child: Container(
                                width: 32, // w-8
                                height: 32, // h-8
                                decoration: BoxDecoration(
                                  color: const Color(0xFF6B46C1), // primary-500
                                  borderRadius: BorderRadius.circular(
                                    999,
                                  ), // rounded-full
                                ),
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
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
                  children: <Widget>[
                    // Personal Information
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
                          const Text(
                            'Personal Information',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A202C),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _nameController,
                            hintText: 'Full Name',
                            icon: Icons.person_outline,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _emailController,
                            hintText: 'Email Address',
                            icon: Icons.mail_outline,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _phoneController,
                            hintText: 'Phone Number',
                            icon: Icons.phone_outlined,
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _addressController,
                            hintText: 'Address',
                            icon: Icons.map_outlined,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24), // space-y-6
                    // Academic Information
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
                          const Text(
                            'Academic Information',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A202C),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _studentIdController,
                            hintText: 'Student ID',
                            icon: Icons.school_outlined,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _universityController,
                            hintText: 'University',
                            icon:
                                null, // No specific icon in React, so keeping null
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _programController,
                            hintText: 'Program/Major',
                            icon: null,
                          ),
                          const SizedBox(height: 16),
                          // Year dropdown
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ), // px-4
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                16,
                              ), // rounded-2xl
                              border: Border.all(
                                color: const Color(0xFFEDF2F7),
                                width: 1,
                              ), // border border-gray-200
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedYear,
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Color(0xFFA0AEC0),
                                ),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF1A202C),
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedYear = newValue!;
                                  });
                                },
                                items:
                                    <String>[
                                      '1st Year',
                                      '2nd Year',
                                      '3rd Year',
                                      '4th Year',
                                      'Masters',
                                      'PhD',
                                    ].map<DropdownMenuItem<String>>((
                                      String value,
                                    ) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24), // space-y-6
                    // Save Changes Button
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF6B46C1), // from-primary-500
                            Color(0xFF805AD5), // to-accent-500
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(16), // rounded-2xl
                      ),
                      child: ElevatedButton(
                        onPressed: _handleSave,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ), // py-4
                        ),
                        child: const Text(
                          'Save Changes',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    IconData? icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFFA0AEC0)), // text-gray-400
        prefixIcon:
            icon != null
                ? Icon(icon, color: const Color(0xFFA0AEC0)) // text-gray-400
                : null,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16), // rounded-2xl
          borderSide: const BorderSide(
            color: Color(0xFFEDF2F7),
            width: 1,
          ), // border border-gray-200
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFEDF2F7), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFF6B46C1),
            width: 2,
          ), // focus:border-primary-500 focus:ring-2 focus:ring-primary-200
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        ), // py-3 pl-10 pr-4 (prefix handles left padding)
      ),
    );
  }
}
