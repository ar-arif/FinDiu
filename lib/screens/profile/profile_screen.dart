import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../utils/app_colors.dart';
import '../auth/login_screen.dart';
import 'profile_edit_screen.dart';
import 'about_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        const Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Profile Info
                    Consumer<AuthProvider>(
                      builder: (context, authProvider, child) {
                        final user = authProvider.userModel;
                        
                        return Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 64,
                                height: 64,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user?.name ?? 'Student',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      user?.email ?? '',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                    ),
                                    if (user?.studentId != null && user!.studentId.isNotEmpty)
                                      Text(
                                        'Student ID: ${user.studentId}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const ProfileEditScreen(),
                                    ),
                                  );
                                },
                                icon: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
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
                      children: [
                        // Stats Cards
                        Row(
                          children: [
                            Expanded(
                              child: Container(
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
                                  children: [
                                    Text(
                                      '156',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    Text(
                                      'Campus Transactions',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textSecondary,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Container(
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
                                  children: [
                                    Text(
                                      '4',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    Text(
                                      'Savings Goals',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textSecondary,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Account Info
                        Consumer<AuthProvider>(
                          builder: (context, authProvider, child) {
                            final user = authProvider.userModel;
                            
                            return Container(
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
                                    'Campus Information',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  _buildInfoRow('University', user?.university ?? 'Not set'),
                                  _buildInfoRow('Program', user?.program ?? 'Not set'),
                                  _buildInfoRow('Year', user?.year ?? 'Not set'),
                                  _buildInfoRow('Member Since', 'Jan 2024'),
                                ],
                              ),
                            );
                          },
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Menu Items
                        Container(
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
                            children: [
                              _buildMenuItem(
                                icon: Icons.edit,
                                label: 'Edit Profile',
                                color: Colors.blue,
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const ProfileEditScreen(),
                                    ),
                                  );
                                },
                              ),
                              _buildMenuItem(
                                icon: Icons.notifications,
                                label: 'Notifications',
                                color: Colors.blue,
                                onTap: () {
                                  // TODO: Implement notifications
                                },
                              ),
                              _buildMenuItem(
                                icon: Icons.security,
                                label: 'Security',
                                color: Colors.green,
                                onTap: () {
                                  // TODO: Implement security settings
                                },
                              ),
                              _buildMenuItem(
                                icon: Icons.info,
                                label: 'About Us',
                                color: Colors.purple,
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const AboutScreen(),
                                    ),
                                  );
                                },
                              ),
                              _buildMenuItem(
                                icon: Icons.help,
                                label: 'Help & Support',
                                color: Colors.orange,
                                onTap: () {
                                  // TODO: Implement help & support
                                },
                              ),
                              _buildMenuItem(
                                icon: Icons.logout,
                                label: 'Sign Out',
                                color: Colors.red,
                                onTap: () async {
                                  final authProvider = Provider.of<AuthProvider>(context, listen: false);
                                  await authProvider.signOut();
                                  
                                  if (context.mounted) {
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) => const LoginScreen(),
                                      ),
                                      (route) => false,
                                    );
                                  }
                                },
                                isLast: true,
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 32),
                        
                        // App Version
                        const Text(
                          'FinDiu v1.0.0 - Campus Banking for Students',
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

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    bool isLast = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(isLast ? 24 : 0),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          border: isLast ? null : const Border(
            bottom: BorderSide(color: AppColors.surfaceVariant),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.textTertiary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}