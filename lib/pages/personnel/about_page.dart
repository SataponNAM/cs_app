import 'package:flutter/material.dart';
import 'package:cs_app/logic/bottom_nav_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
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
                  'แนะนำภาควิชา',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.deepPurple.shade800,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Department Structure Card
              _buildMenuCard(
                context,
                title: 'โครงสร้างภาควิชา',
                icon: Icons.account_tree_outlined,
                onTap: () {
                  Navigator.pushNamed(context, '/departmentStruct');
                }
              ),
              
              const SizedBox(height: 16),
              
              // Academic Personnel Card
              _buildMenuCard(
                context,
                title: 'บุคลากรสายวิชาการ',
                icon: Icons.school_outlined,
                onTap: () {
                  context.read<BottomNavCubit>().changeSelectedIndex(1);
                  Navigator.pushNamed(context, '/professor');
                },
              ),
              
              const SizedBox(height: 16),
              
              // Support Personnel Card
              _buildMenuCard(
                context,
                title: 'บุคลากรสายสนับสนุน',
                icon: Icons.support_outlined,
                onTap: () {
                  Navigator.pushNamed(context, '/supportPers');
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