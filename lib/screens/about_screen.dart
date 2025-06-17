import 'package:flutter/material.dart';
import '../main.dart'; // Import AppScreen enum

class AboutScreen extends StatefulWidget {
  final Function(AppScreen) onNavigate;

  const AboutScreen({super.key, required this.onNavigate});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> features = [
      {
        'icon': Icons.account_balance_wallet_outlined,
        'title': 'Smart Campus Banking',
        'description':
            'Designed specifically for university students with campus-focused features',
      },
      {
        'icon': Icons.security_outlined,
        'title': 'Secure & Safe',
        'description':
            'Bank-level security to protect your financial data and transactions',
      },
      {
        'icon': Icons.flag_outlined,
        'title': 'Goal-Oriented Savings',
        'description':
            'Set and achieve financial goals like tuition, books, and emergency funds',
      },
      {
        'icon': Icons.people_outline,
        'title': 'Student Community',
        'description':
            'Built by students, for students - we understand your unique needs',
      },
    ];

    final List<Map<String, dynamic>> team = const [
      {'name': 'Md Ariful Islam', 'role': 'Founder & CTO', 'university': 'DIU'},
      {
        'name': 'Md Shariful Islam',
        'role': 'Founder & CEO',
        'university': 'DIU',
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
                    Color(0xFF6B46C1), // from-primary-500
                    Color(0xFF805AD5), // to-accent-500
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
                        onPressed: () => widget.onNavigate(AppScreen.profile),
                      ),
                      const SizedBox(width: 16),
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
                    padding: const EdgeInsets.all(24), // p-6
                    decoration: BoxDecoration(
                      color: const Color(
                        0xFFFFFFFF,
                      ).withAlpha((0.1 * 255).round()), // bg-white/10
                      borderRadius: BorderRadius.circular(24), // rounded-3xl
                    ),
                    child: Column(
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
                            Icons.account_balance_wallet_outlined,
                            size: 32, // w-8 h-8
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16), // mb-4
                        const Text(
                          'Smart Banking for Smart Students',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24, // text-2xl
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8), // mb-2
                        const Text(
                          'Empowering university students across Bangladesh to take control of their finances',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14, // text-sm
                            color: Colors.white70, // opacity-90
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
                    // Mission Statement
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
                        children: const <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.favorite_outline,
                                size: 24,
                                color: Color(0xFFEF4444),
                              ), // w-6 h-6 text-red-500
                              SizedBox(width: 12), // space-x-3
                              Text(
                                'Our Mission',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1A202C),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16), // mb-4
                          Text(
                            'FinDiu was created to solve the unique financial challenges faced by university students in Bangladesh. We understand the struggle of managing tuition fees, campus expenses, and daily budgets while pursuing education. Our mission is to provide a simple, secure, and student-friendly platform that helps you achieve financial independence.',
                            style: TextStyle(
                              color: Color(0xFF4A5568), // text-gray-600
                              height: 1.5, // leading-relaxed
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24), // space-y-6
                    // Features
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
                            'Why Choose FinDiu?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A202C),
                            ),
                          ),
                          const SizedBox(height: 24), // mb-6
                          Column(
                            children:
                                features.map((feature) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 16.0,
                                    ), // space-y-4
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: 48, // w-12
                                          height: 48, // h-12
                                          decoration: BoxDecoration(
                                            color: const Color(
                                              0xFFF0F4F8,
                                            ), // bg-primary-100
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ), // rounded-2xl
                                          ),
                                          child: Icon(
                                            feature['icon'],
                                            size: 24, // w-6 h-6
                                            color: const Color(
                                              0xFF553C9A,
                                            ), // text-primary-600
                                          ),
                                        ),
                                        const SizedBox(width: 16), // space-x-4
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                feature['title'],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF1A202C),
                                                ),
                                              ),
                                              const SizedBox(height: 4), // mb-1
                                              Text(
                                                feature['description'],
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xFF4A5568),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                          ),
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
                            'Our Impact',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A202C),
                            ),
                          ),
                          const SizedBox(height: 24), // mb-6
                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            mainAxisSpacing: 24, // gap-6
                            crossAxisSpacing: 24, // gap-6
                            childAspectRatio: 1.2, // Adjust as needed
                            children: const <Widget>[
                              _BuildStatItem(
                                '10K+',
                                'Active Students',
                                Color(0xFF553C9A),
                              ), // text-primary-600
                              _BuildStatItem(
                                '50+',
                                'Sponsors',
                                Color(0xFFD69E2E),
                              ), // text-secondary-600
                              _BuildStatItem(
                                '৳2Cr+',
                                'Money Managed',
                                Color(0xFF805AD5),
                              ), // text-accent-600
                              _BuildStatItem(
                                '95%',
                                'Satisfaction Rate',
                                Color(0xFFDD6B20),
                              ), // text-orange-600
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
                          const Row(
                            children: <Widget>[
                              Icon(
                                Icons.emoji_events_outlined,
                                size: 24,
                                color: Color(0xFFECC94B),
                              ), // w-6 h-6 text-yellow-500
                              SizedBox(width: 12),
                              Text(
                                'Meet Our Team',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1A202C),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24), // mb-6
                          Column(
                            children:
                                team.map((member) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 16.0,
                                    ), // space-y-4
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: 48, // w-12
                                          height: 48, // h-12
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color(
                                                  0xFF6B46C1,
                                                ), // from-primary-500
                                                Color(
                                                  0xFF805AD5,
                                                ), // to-accent-500
                                              ],
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              999,
                                            ), // rounded-full
                                          ),
                                          child: Center(
                                            child: Text(
                                              member['name']
                                                  .split(' ')
                                                  .map((n) => n[0])
                                                  .join(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 16), // space-x-4
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              member['name'],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF1A202C),
                                              ),
                                            ),
                                            Text(
                                              '${member['role']} • ${member['university']}',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFF4A5568),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                          ),
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
                            color: Colors.grey.withAlpha((0.1 * 255).round()),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text(
                            'Get in Touch',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A202C),
                            ),
                          ),
                          SizedBox(height: 16), // mb-4
                          _BuildContactRow(
                            Icons.mail_outline,
                            'support@findiu.com.bd',
                          ),
                          _BuildContactRow(
                            Icons.phone_outlined,
                            '+880 1700-000000',
                          ),
                          _BuildContactRow(
                            Icons.location_on_outlined,
                            'Dhaka, Bangladesh',
                          ),
                          _BuildContactRow(Icons.language, 'www.findiu.com.bd'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Version
                    const Text(
                      'FinDiu v1.0.0 • Made with ❤️ for Bangladeshi Students',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Color(0xFF718096)),
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

class _BuildStatItem extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _BuildStatItem(this.value, this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          value,
          style: TextStyle(
            fontSize: 28, // text-3xl
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4), // mb-1
        Text(
          label,
          style: const TextStyle(
            fontSize: 14, // text-sm
            color: Color(0xFF4A5568),
          ),
        ),
      ],
    );
  }
}

class _BuildContactRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _BuildContactRow(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4.0,
      ), // space-y-3 for parent column
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 16,
            color: const Color(0xFF4A5568),
          ), // 📧 📱 🏢 🌐 icons
          const SizedBox(width: 8), // space-x-2
          Text(
            text,
            style: const TextStyle(fontSize: 14, color: Color(0xFF4A5568)),
          ),
        ],
      ),
    );
  }
}
