import 'package:flutter/material.dart';
import '../main.dart'; // Import AppScreen enum

class LoginScreen extends StatefulWidget {
  final Function(AppScreen) onNavigate;

  const LoginScreen({super.key, required this.onNavigate});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;

  void _handleLogin() {
    // Simulate login logic
    widget.onNavigate(AppScreen.dashboard);
  }

  void _handleGoogleLogin() {
    // Simulate Google login logic
    widget.onNavigate(AppScreen.dashboard);
  }

  @override
  void dispose() {
    _emailController.dispose();
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
              Color(0xFFF0F4F8), // from-primary-50 (light blue/gray)
              Color(0xFFE6EBF0), // to-accent-50 (slightly darker blue/gray)
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
                  // Welcome Back Title
                  const Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 28, // text-3xl
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A202C), // text-gray-900
                    ),
                  ),
                  const SizedBox(height: 8), // mb-2
                  const Text(
                    'Sign in to your FinDiu campus account',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF4A5568), // text-gray-600
                    ),
                  ),
                  const SizedBox(height: 32), // mb-8
                  // Google Login Button
                  ElevatedButton(
                    onPressed: _handleGoogleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF4A5568), // text-gray-700
                      side: const BorderSide(
                        color: Color(0xFFEDF2F7),
                        width: 2,
                      ), // border-2 border-gray-200
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16), // rounded-2xl
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                    ).copyWith(
                      overlayColor: WidgetStateProperty.all(
                        const Color(0xFFF7FAFC),
                      ), // hover:bg-gray-50
                      side: WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.hovered)) {
                          return const BorderSide(
                            color: Color(0xFFCBD5E0),
                            width: 2,
                          ); // hover:border-gray-300
                        }
                        return const BorderSide(
                          color: Color(0xFFEDF2F7),
                          width: 2,
                        );
                      }),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Placeholder for Google SVG. Actual SVG integration needs more work.
                        SizedBox(
                          width: 20, // w-5
                          height: 20, // h-5
                          child: const Icon(
                            Icons.g_mobiledata,
                            size: 24,
                            color: Color(
                              0xFF4A5568,
                            ), // Use a color that fits the design
                          ),
                        ),
                        const SizedBox(width: 12), // space-x-3
                        const Text(
                          'Continue with Google',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600, // font-semibold
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24), // mb-6
                  // Or continue with email divider
                  Row(
                    children: <Widget>[
                      const Expanded(
                        child: Divider(
                          color: Color(0xFFEDF2F7), // border-gray-200
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ), // px-4
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFF0F4F8), Color(0xFFE6EBF0)],
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Or continue with email',
                            style: TextStyle(
                              fontSize: 14, // text-sm
                              color: Color(0xFF718096), // text-gray-500
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          color: Color(0xFFEDF2F7), // border-gray-200
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24), // mb-6
                  // Email and Password Input Fields
                  Column(
                    children: <Widget>[
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
                              color: const Color(0xFFA0AEC0), // text-gray-400
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
                          ), // py-3 pl-10 pr-12
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24), // mb-6
                  // Sign In Button
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
                      onPressed: _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors
                                .transparent, // Make button background transparent to show gradient
                        shadowColor:
                            Colors.transparent, // Remove default shadow
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600, // font-semibold
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
                  const SizedBox(
                    height: 24,
                  ), // mt-6 (relative to previous element)
                  // Forgot Password?
                  TextButton(
                    onPressed: () {
                      // Handle forgot password
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Color(0xFF553C9A), // text-primary-600
                        fontWeight: FontWeight.w500, // font-medium
                      ),
                    ),
                  ),
                  const SizedBox(height: 32), // mt-8
                  // Don't have an account? Sign Up
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
                          "Don't have an account? ",
                          style: TextStyle(
                            color: Color(0xFF4A5568), // text-gray-600
                          ),
                        ),
                        TextButton(
                          onPressed: () => widget.onNavigate(AppScreen.signup),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero, // Remove default padding
                            minimumSize:
                                Size.zero, // Remove minimum size constraints
                            tapTargetSize:
                                MaterialTapTargetSize
                                    .shrinkWrap, // Shrink tap area
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Color(0xFF553C9A), // text-primary-600
                              fontWeight: FontWeight.w600, // font-semibold
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
