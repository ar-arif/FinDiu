import 'package:flutter/material.dart';
import '../main.dart'; // Import AppScreen enum

class ProfileScreen extends StatefulWidget {
  final Function(AppScreen) onNavigate;

  const ProfileScreen({super.key, required this.onNavigate});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        'icon': Icons.edit_outlined,
        'label': 'Edit Profile',
        'color': Colors.blue[700],
        'action': () => widget.onNavigate(AppScreen.profileEdit),
      },
      {
        'icon': Icons.notifications_none,
        'label': 'Notifications',
        'color': Colors.blue[700],
        'action': () {
          // Handle Notifications
        },
      },
      {
        'icon': Icons.security_outlined,
        'label': 'Security',
        'color': Colors.green[700],
        'action': () {
          // Handle Security
        },
      },
      {
        'icon': Icons.info_outline,
        'label': 'About Us',
        'color': Colors.purple[700],
        'action': () => widget.onNavigate(AppScreen.about),
      },
      {
        'icon': Icons.help_outline,
        'label': 'Help & Support',
        'color': Colors.orange[700],
        'action': () {
          // Handle Help & Support
        },
      },
      {
        'icon': Icons.logout,
        'label': 'Sign Out',
        'color': Colors.red[700],
        'action': () => widget.onNavigate(AppScreen.login),
      },
    ];

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
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () => widget.onNavigate(AppScreen.dashboard),
                      ),
                      const SizedBox(width: 16),
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
                  Container(
                    padding: const EdgeInsets.all(24), // p-6
                    decoration: BoxDecoration(
                      color: const Color(
                        0xFFFFFFFF,
                      ).withAlpha((0.1 * 255).round()), // bg-white/10
                      borderRadius: BorderRadius.circular(24), // rounded-3xl
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              width: 64, // w-16
                              height: 64, // h-16
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
                                size: 32, // w-8 h-8
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 16), // space-x-4
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const <Widget>[
                                Text(
                                  'Md Ariful Islam',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'arif-itm@diu.edu.bd',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70, // opacity-80
                                  ),
                                ),
                                Text(
                                  'Student ID: 1234567890',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed:
                              () => widget.onNavigate(AppScreen.profileEdit),
                          icon: Container(
                            padding: const EdgeInsets.all(12), // p-3
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFFFFFFFF,
                              ).withAlpha((0.2 * 255).round()), // bg-white/20
                              borderRadius: BorderRadius.circular(
                                16,
                              ), // rounded-2xl
                            ),
                            child: const Icon(
                              Icons.edit_outlined,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
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
                    // Stats Cards
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(24), // p-6
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                24,
                              ), // rounded-3xl
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withAlpha(
                                    (0.1 * 255).round(),
                                  ),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3), // shadow-sm
                                ),
                              ],
                            ),
                            child: Column(
                              children: const <Widget>[
                                Text(
                                  '156',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1A202C),
                                  ),
                                ),
                                Text(
                                  'Campus Transactions',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF4A5568),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16), // gap-4
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withAlpha(
                                    (0.1 * 255).round(),
                                  ),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: const <Widget>[
                                Text(
                                  '4',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1A202C),
                                  ),
                                ),
                                Text(
                                  'Savings Goals',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF4A5568),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24), // mb-6
                    // Campus Information
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
                            'Campus Information',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A202C),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Column(
                            children: const <Widget>[
                              _BuildInfoRow(
                                'University',
                                'Daffodil International University',
                              ),
                              _BuildInfoRow(
                                'Program',
                                'Information Technology & Management',
                              ),
                              _BuildInfoRow('Year', '3rd Year'),
                              _BuildInfoRow('Member Since', 'Jan 2024'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24), // mb-6
                    // Menu Items
                    Container(
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
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: menuItems.length,
                        itemBuilder: (context, index) {
                          final item = menuItems[index];
                          return Column(
                            children: [
                              InkWell(
                                onTap: item['action'],
                                child: Padding(
                                  padding: const EdgeInsets.all(24), // p-6
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            item['icon'],
                                            size: 24,
                                            color: item['color'],
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ), // space-x-4
                                          Text(
                                            item['label'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF1A202C),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.chevron_right,
                                        size: 20,
                                        color: Color(0xFFA0AEC0),
                                      ), // w-5 h-5 text-gray-400
                                    ],
                                  ),
                                ),
                              ),
                              if (index < menuItems.length - 1)
                                const Divider(
                                  height: 0,
                                  indent: 24,
                                  endIndent: 24,
                                  color: Color(0xFFEDF2F7),
                                ), // border-b border-gray-100
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 32), // mt-8
                    // App Version
                    const Text(
                      'FinDiu v1.0.0 - Campus Banking for Students',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF718096), // text-gray-500
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
}

class _BuildInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _BuildInfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ), // space-y-4 for parent column
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(color: Color(0xFF4A5568)), // text-gray-600
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xFF1A202C),
            ), // font-medium text-gray-900
          ),
        ],
      ),
    );
  }
}
