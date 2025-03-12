import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  // News categories with routes and icons
  final List<Map<String, dynamic>> _newsCategories = [
    {
      'title': 'ข่าวภาควิชา',
      'route': '/departmentNews',
      'icon': Icons.account_balance_outlined,
    },
    {
      'title': 'ข่าวคณะและมหาวิทยาลัย',
      'route': '/uniNews',
      'icon': Icons.school_outlined,
    },
    {
      'title': 'ข่าวทุนการศึกษา',
      'route': '/scholarshipNews',
      'icon': Icons.card_membership_outlined,
    },
    {
      'title': 'ข่าวรับสมัครงาน-ประชาสัมพันธ์',
      'route': '/rescruitmentNews',
      'icon': Icons.work_outline,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/images/logo.png',
          width: 70,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'ข่าวสารและกิจกรรม',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.deepPurple.shade800,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Department News Card
              _buildMenuCard(
                context,
                title: 'ข่าวภาควิชา',
                icon: Icons.account_balance_outlined,
                onTap: () {
                  Navigator.pushNamed(context, '/departmentNews');
                },
              ),
              
              const SizedBox(height: 16),
              
              // University News Card
              _buildMenuCard(
                context,
                title: 'ข่าวคณะและมหาวิทยาลัย',
                icon: Icons.school_outlined,
                onTap: () {
                  Navigator.pushNamed(context, '/uniNews');
                },
              ),
              
              const SizedBox(height: 16),
              
              // Scholarship News Card
              _buildMenuCard(
                context,
                title: 'ข่าวทุนการศึกษา',
                icon: Icons.card_membership_outlined,
                onTap: () {
                  Navigator.pushNamed(context, '/scholarshipNews');
                },
              ),
              
              const SizedBox(height: 16),
              
              // Recruitment News Card
              _buildMenuCard(
                context,
                title: 'ข่าวรับสมัครงาน-ประชาสัมพันธ์',
                icon: Icons.work_outline,
                onTap: () {
                  Navigator.pushNamed(context, '/rescruitmentNews');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepPurple.shade50,
                Colors.deepPurple.shade100,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade200,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Title
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.deepPurple.shade900,
                  ),
                ),
              ),
              
              // Forward Icon
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.deepPurple.shade700,
              ),
            ],
          ),
        ),
      ),
    );
  }
}