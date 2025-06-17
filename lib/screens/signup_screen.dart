import 'package:flutter/material.dart';
import '../main.dart'; // Import AppScreen enum

class SignupScreen extends StatefulWidget {
  final Function(AppScreen) onNavigate;

  const SignupScreen({super.key, required this.onNavigate});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;

  void _handleSignup() {
    // Simulate signup logic
    widget.onNavigate(AppScreen.dashboard);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _studentIdController.dispose();
    _passwordController.dispose();
    super.dispose();
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
              Color(0xFFFEF2F2), // from-secondary-50 (light red/pink)
              Color(0xFFF0F4F8), // to-primary-50 (light blue/gray)
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 32.0,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400), // max-w-sm
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Join FinDiu Title
                  const Text(
                    'Join FinDiu',
                    style: TextStyle(
                      fontSize: 28, // text-3xl
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A202C), // text-gray-900
                    ),
                  ),
                  const SizedBox(height: 8), // mb-2
                  const Text(
                    'Create your student banking account',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF4A5568), // text-gray-600
                    ),
                  ),
                  const SizedBox(height: 32), // mb-8
                  // Input Fields
                  Column(
                    children: <Widget>[
                      TextField(
                        controller: _nameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Full Name',
                          hintStyle: const TextStyle(
                            color: Color(0xFFA0AEC0),
                          ), // text-gray-400
                          prefixIcon: const Icon(
                            Icons.person_outline,
                            color: Color(0xFFA0AEC0),
                          ), // text-gray-400
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              16,
                            ), // rounded-2xl
                            borderSide: const BorderSide(
                              color: Color(0xFFEDF2F7),
                              width: 1,
                            ), // border border-gray-200
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Color(0xFFEDF2F7),
                              width: 1,
                            ),
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
                          ), // py-3 pl-10 pr-4
                        ),
                      ),
                      const SizedBox(height: 16), // space-y-4

                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'University email',
                          hintStyle: const TextStyle(
                            color: Color(0xFFA0AEC0),
                          ), // text-gray-400
                          prefixIcon: const Icon(
                            Icons.mail_outline,
                            color: Color(0xFFA0AEC0),
                          ), // text-gray-400
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Color(0xFFEDF2F7),
                              width: 1,
                            ), // border border-gray-200
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Color(0xFFEDF2F7),
                              width: 1,
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
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      TextField(
                        controller: _studentIdController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Student ID',
                          hintStyle: const TextStyle(color: Color(0xFFA0AEC0)),
                          prefixIcon: const Icon(
                            Icons.school_outlined,
                            color: Color(0xFFA0AEC0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Color(0xFFEDF2F7),
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Color(0xFFEDF2F7),
                              width: 1,
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
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      TextField(
                        controller: _passwordController,
                        obscureText: !_showPassword,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: const TextStyle(color: Color(0xFFA0AEC0)),
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: Color(0xFFA0AEC0),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _showPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: const Color(0xFFA0AEC0),
                            ),
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Color(0xFFEDF2F7),
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Color(0xFFEDF2F7),
                              width: 1,
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
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ), // space-y-4 (for the form fields)
                    ],
                  ),
                  const SizedBox(height: 24), // mb-6
                  // Sign Up Button
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
                      onPressed: _handleSignup,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8), // space-x-2
                          Icon(
                            Icons.arrow_right_alt,
                            color: Colors.white,
                            size: 24,
                          ), // w-5 h-5
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32), // mt-8
                  // Already have an account? Sign In
                  Container(
                    padding: const EdgeInsets.only(top: 24), // pt-6
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color(0xFFEDF2F7), // border-gray-200
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(
                            color: Color(0xFF4A5568), // text-gray-600
                          ),
                        ),
                        TextButton(
                          onPressed: () => widget.onNavigate(AppScreen.login),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              color: Color(0xFF6B46C1), // text-primary-600
                              fontWeight: FontWeight.w600,
                            ),
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
      ),
    );
  }
}
