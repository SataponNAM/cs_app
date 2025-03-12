import 'package:flutter/material.dart';

class RulePage extends StatefulWidget {
  const RulePage({super.key});

  @override
  State<RulePage> createState() => _RulePageState();
}

class _RulePageState extends State<RulePage> {
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
                  'ระเบียบและประกาศ',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.deepPurple.shade800,
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Finance Card
              _buildMenuCard(
                context,
                title: 'งานการเงิน',
                icon: Icons.attach_money_outlined,
                onTap: () {
                  Navigator.pushNamed(context, '/finance');
                },
              ),
              
              const SizedBox(height: 16),
              
              // Academic Card
              _buildMenuCard(
                context,
                title: 'งานวิชาการ',
                icon: Icons.menu_book_outlined,
                onTap: () {
                  Navigator.pushNamed(context, '/academic');
                },
              ),
              
              const SizedBox(height: 16),
              
              // Student Affairs Card
              _buildMenuCard(
                context,
                title: 'งานกิจการนักศึกษา',
                icon: Icons.people_outline,
                onTap: () {
                  Navigator.pushNamed(context, '/stdAffair');
                },
              ),
              
              const SizedBox(height: 16),
              
              // Graduate Student Card
              _buildMenuCard(
                context,
                title: 'ระดับบัณฑิตศึกษา',
                icon: Icons.school_outlined,
                onTap: () {
                  Navigator.pushNamed(context, '/graduateStd');
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