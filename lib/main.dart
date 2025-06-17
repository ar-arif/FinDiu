import 'package:flutter/material.dart';
import 'package:fin_diu_app/screens/login_screen.dart'; // Import LoginScreen
import 'package:fin_diu_app/screens/signup_screen.dart'; // Import SignupScreen
import 'package:fin_diu_app/screens/dashboard_screen.dart'; // Import DashboardScreen
import 'package:fin_diu_app/screens/add_expense_screen.dart'; // Import AddExpenseScreen
import 'package:fin_diu_app/screens/savings_screen.dart'; // Import SavingsScreen
import 'package:fin_diu_app/screens/reminders_screen.dart'; // Import RemindersScreen
import 'package:fin_diu_app/screens/analytics_screen.dart'; // Import AnalyticsScreen
import 'package:fin_diu_app/screens/profile_screen.dart'; // Import ProfileScreen
import 'package:fin_diu_app/screens/profile_edit_screen.dart'; // Import ProfileEditScreen
import 'package:fin_diu_app/screens/about_screen.dart'; // Import AboutScreen
import 'package:fin_diu_app/screens/transactions_screen.dart'; // Import TransactionsScreen
import 'package:fin_diu_app/screens/ai_chat_screen.dart'; // Import AIChatScreen
import 'package:fin_diu_app/components/bottom_navigation.dart'; // Import BottomNavigation

void main() {
  runApp(const MyApp());
}

enum AppScreen {
  splash,
  login,
  signup,
  dashboard,
  addExpense,
  savings,
  reminders,
  aiChat,
  analytics,
  profile,
  profileEdit,
  about,
  transactions,
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppScreen _currentScreen = AppScreen.splash;

  void _navigate(AppScreen screen) {
    setState(() {
      _currentScreen = screen;
    });
  }

  Widget _buildScreen() {
    switch (_currentScreen) {
      case AppScreen.splash:
        return SplashScreen(onComplete: () => _navigate(AppScreen.login));
      case AppScreen.login:
        return LoginScreen(onNavigate: _navigate);
      case AppScreen.signup:
        return SignupScreen(onNavigate: _navigate);
      case AppScreen.dashboard:
        return DashboardScreen(onNavigate: _navigate);
      case AppScreen.addExpense:
        return AddExpenseScreen(onNavigate: _navigate);
      case AppScreen.savings:
        return SavingsScreen(onNavigate: _navigate);
      case AppScreen.reminders:
        return RemindersScreen(onNavigate: _navigate);
      case AppScreen.aiChat:
        return AIChatScreen(onNavigate: _navigate);
      case AppScreen.analytics:
        return AnalyticsScreen(onNavigate: _navigate);
      case AppScreen.profile:
        return ProfileScreen(onNavigate: _navigate);
      case AppScreen.profileEdit:
        return ProfileEditScreen(onNavigate: _navigate);
      case AppScreen.about:
        return AboutScreen(onNavigate: _navigate);
      case AppScreen.transactions:
        return TransactionsScreen(onNavigate: _navigate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinDiu App', // Changed title
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true, // Added for modern Material Design
      ),
      home: Scaffold(
        // Added Scaffold for basic app structure
        body: _buildScreen(),
        bottomNavigationBar:
            (_currentScreen == AppScreen.dashboard ||
                    _currentScreen == AppScreen.addExpense ||
                    _currentScreen == AppScreen.savings ||
                    _currentScreen == AppScreen.aiChat ||
                    _currentScreen == AppScreen.analytics)
                ? BottomNavigation(
                  currentScreen: _currentScreen,
                  onNavigate: _navigate,
                )
                : null,
      ),
    );
  }
}

// Placeholder for SplashScreen
class SplashScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const SplashScreen({super.key, required this.onComplete});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _dot1Controller;
  late Animation<double> _dot1Animation;
  late AnimationController _dot2Controller;
  late Animation<double> _dot2Animation;
  late AnimationController _dot3Controller;
  late Animation<double> _dot3Animation;

  @override
  void initState() {
    super.initState();

    _dot1Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _dot1Animation = Tween(begin: 0.5, end: 1.0).animate(_dot1Controller);

    _dot2Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _dot2Animation = Tween(begin: 0.5, end: 1.0).animate(_dot2Controller);
    Future.delayed(const Duration(milliseconds: 200), () {
      _dot2Controller.repeat(reverse: true);
    });

    _dot3Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _dot3Animation = Tween(begin: 0.5, end: 1.0).animate(_dot3Controller);
    Future.delayed(const Duration(milliseconds: 400), () {
      _dot3Controller.repeat(reverse: true);
    });

    Future.delayed(const Duration(seconds: 3), () {
      widget.onComplete();
    });
  }

  @override
  void dispose() {
    _dot1Controller.dispose();
    _dot2Controller.dispose();
    _dot3Controller.dispose();
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
              Color(0xFF6B46C1), // Corresponds to primary-500
              Color(0xFF805AD5), // Corresponds to accent-500
              Color(
                0xFF6B46C1,
              ), // Corresponds to secondary-500, using primary for now for a simpler gradient. Needs exact colors if primary/accent/secondary are different.
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(height: 48), // Add top margin
                    // Main Wallet Icon with surrounding
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 96, // w-24 * 4
                          height: 96, // h-24 * 4
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFFFFFFFF,
                            ).withAlpha((0.2 * 255).round()), // bg-white/20
                            borderRadius: BorderRadius.circular(24),
                          ), // rounded-3xl
                          child: const Icon(
                            Icons.wallet,
                            size: 48, // w-12 h-12
                            color: Colors.white,
                          ),
                        ),
                        Positioned(
                          top: 0, // -top-2
                          right: 0, // -right-2
                          child: Container(
                            width: 24, // w-6
                            height: 24, // h-6
                            decoration: BoxDecoration(
                              color: const Color(0xFFED8936).withAlpha(
                                (0.4 * 255).round(),
                              ), // bg-secondary-400 (assuming this is orange based on typical Tailwind colors)
                              borderRadius: BorderRadius.circular(
                                12,
                              ), // rounded-full
                            ),
                            child: const Icon(
                              Icons.trending_up,
                              size: 12, // w-3 h-3
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32), // mb-8
                    // FinDiu Title
                    const Text(
                      'FinDiu',
                      style: TextStyle(
                        fontSize: 36, // text-4xl
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8), // mb-2
                    // Subtitle
                    const Text(
                      'Smart Banking for Smart Students',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18, // text-lg
                        color: Colors.white70, // opacity-90
                      ),
                    ),
                    const SizedBox(height: 48), // mb-12
                    // Secure, Smart, Simple section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _buildFeatureItem(Icons.shield, 'Secure'),
                        const SizedBox(width: 32), // space-x-8
                        _buildFeatureItem(Icons.trending_up, 'Smart'),
                        const SizedBox(width: 32), // space-x-8
                        _buildFeatureItem(Icons.wallet, 'Simple'),
                      ],
                    ),
                  ],
                ),

                // Pulsing dots at the bottom
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 32.0,
                  ), // absolute bottom-8
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FadeTransition(
                        opacity: _dot1Animation,
                        child: _buildDot(Colors.white60),
                      ), // w-2 h-2 bg-white/60
                      const SizedBox(width: 8), // space-x-2
                      FadeTransition(
                        opacity: _dot2Animation,
                        child: _buildDot(Colors.white54),
                      ), // w-2 h-2 bg-white/40
                      const SizedBox(width: 8), // space-x-2
                      FadeTransition(
                        opacity: _dot3Animation,
                        child: _buildDot(Colors.white60),
                      ), // w-2 h-2 bg-white/60
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Column(
      children: <Widget>[
        Container(
          width: 48, // w-12
          height: 48, // h-12
          decoration: BoxDecoration(
            color: const Color(
              0xFFFFFFFF,
            ).withAlpha((0.2 * 255).round()), // bg-white/20
            borderRadius: BorderRadius.circular(16), // rounded-2xl
          ),
          child: Icon(
            icon,
            size: 24, // w-6 h-6
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8), // mb-2
        Text(
          text,
          style: const TextStyle(
            fontSize: 14, // text-sm
            color: Colors.white70, // opacity-80
          ),
        ),
      ],
    );
  }

  Widget _buildDot(Color color) {
    return Container(
      width: 8, // w-2
      height: 8, // h-2
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4), // rounded-full
      ),
    );
  }
}
