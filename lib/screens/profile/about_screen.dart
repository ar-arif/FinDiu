import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final features = [
      {
        'icon': Icons.account_balance_wallet,
        'title': 'Smart Campus Banking',
        'description': 'Designed specifically for university students with campus-focused features'
      },
      {
        'icon': Icons.security,
        'title': 'Secure & Safe',
        'description': 'Bank-level security to protect your financial data and transactions'
      },
      {
        'icon': Icons.track_changes,
        'title': 'Goal-Oriented Savings',
        'description': 'Set and achieve financial goals like tuition, books, and emergency funds'
      },
      {
        'icon': Icons.people,
        'title': 'Student Community',
        'description': 'Built by students, for students - we understand your unique needs'
      },
    ];

    final team = [
      {'name': 'Md Ariful Islam', 'role': 'Founder & CTO', 'university': 'DIU'},
      {'name': 'Md Shariful Islam', 'role': 'Founder & CEO', 'university': 'DIU'},
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
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
                          'About FinDiu',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Hero Section
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.account_balance_wallet,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Smart Banking for Smart Students',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Empowering university students across Bangladesh to take control of their finances',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.9),
                            ),
                            textAlign: TextAlign.center,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Mission Statement
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
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.favorite, color: Colors.red, size: 24),
                                  SizedBox(width: 12),
                                  Text(
                                    'Our Mission',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Text(
                                'FinDiu was created to solve the unique financial challenges faced by university students in Bangladesh. We understand the struggle of managing tuition fees, campus expenses, and daily budgets while pursuing education. Our mission is to provide a simple, secure, and student-friendly platform that helps you achieve financial independence.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textSecondary,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Features
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
                                'Why Choose FinDiu?',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 24),
                              ...features.map((feature) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 48,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: AppColors.primary.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: Icon(
                                          feature['icon'] as IconData,
                                          color: AppColors.primary,
                                          size: 24,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              feature['title'] as String,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.textPrimary,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              feature['description'] as String,
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
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Statistics
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
                                'Our Impact',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          '10K+',
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                        Text(
                                          'Active Students',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          '50+',
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.secondary,
                                          ),
                                        ),
                                        Text(
                                          'Sponsors',
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
                              const SizedBox(height: 24),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          '৳2Cr+',
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.accent,
                                          ),
                                        ),
                                        Text(
                                          'Money Managed',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          '95%',
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange,
                                          ),
                                        ),
                                        Text(
                                          'Satisfaction Rate',
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
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Team
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
                              const Row(
                                children: [
                                  Icon(Icons.emoji_events, color: Colors.amber, size: 24),
                                  SizedBox(width: 12),
                                  Text(
                                    'Meet Our Team',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              ...team.map((member) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 48,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          gradient: AppColors.primaryGradient,
                                          borderRadius: BorderRadius.circular(24),
                                        ),
                                        child: Center(
                                          child: Text(
                                            member['name']!.split(' ').map((n) => n[0]).join(''),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            member['name']!,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.textPrimary,
                                            ),
                                          ),
                                          Text(
                                            '${member['role']} • ${member['university']}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: AppColors.textSecondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Contact
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
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Get in Touch',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              SizedBox(height: 16),
                              Text('📧 support@findiu.com.bd', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                              SizedBox(height: 8),
                              Text('📱 +880 1700-000000', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                              SizedBox(height: 8),
                              Text('🏢 Dhaka, Bangladesh', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                              SizedBox(height: 8),
                              Text('🌐 www.findiu.com.bd', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 32),
                        
                        // Version
                        const Text(
                          'FinDiu v1.0.0 • Made with ❤️ for Bangladeshi Students',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textTertiary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
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