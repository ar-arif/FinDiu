import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../utils/app_colors.dart';
import 'auth/login_screen.dart';
import 'dashboard/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late AnimationController _fadeController;
  late Animation<double> _bounceAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    _bounceController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _bounceAnimation = Tween<double>(
      begin: 0,
      end: -10,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));

    _startAnimations();
    _navigateToNextScreen();
  }

  void _startAnimations() {
    _fadeController.forward();
    _bounceController.repeat(reverse: true);
  }

  void _navigateToNextScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => authProvider.isAuthenticated
                ? const DashboardScreen()
                : const LoginScreen(),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Animation
              AnimatedBuilder(
                animation: _bounceAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _bounceAnimation.value),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.account_balance_wallet,
                          size: 48,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 32),
              
              // App Name
              FadeTransition(
                opacity: _fadeAnimation,
                child: const Text(
                  'FinDiu',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -1,
                  ),
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Tagline
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  'Smart Banking for Smart Students',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              
              const SizedBox(height: 80),
              
              // Feature Icons
              FadeTransition(
                opacity: _fadeAnimation,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildFeatureIcon(Icons.security, 'Secure'),
                    _buildFeatureIcon(Icons.trending_up, 'Smart'),
                    _buildFeatureIcon(Icons.account_balance_wallet, 'Simple'),
                  ],
                ),
              ),
              
              const SizedBox(height: 80),
              
              // Loading Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return AnimatedBuilder(
                    animation: _bounceController,
                    builder: (context, child) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(
                            0.6 + 0.4 * ((_bounceController.value + index * 0.3) % 1),
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            icon,
            size: 24,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.8),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}