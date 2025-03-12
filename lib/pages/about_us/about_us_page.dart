import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // List of students with their details
    final List<Map<String, String>> students = [
      {
        'name': 'นางสาวคณัสนันท์ วิทยาเรืองสุข',
        'id': '6504062630049',
      },
      {
        'name': 'นางสาวภคนันท์ กิจไพบูลย์รัตน์',
        'id': '6504062630201',
      },
      {
        'name': 'นางสาวสตพร ฟักน้อย',
        'id': '6504062630294',
      },
    ];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple.shade50, Colors.white],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Header
              Text(
                'About Us',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple[500],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Team Members',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),
              
              // Team cards
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    return _buildStudentCard(
                      students[index]['name']!,
                      students[index]['id']!,
                      index,
                    );
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStudentCard(String name, String id, int index) {
    // Different purple colors for different cards
    final List<Color> cardColors = [
      Colors.deepPurple[400]!,
      Colors.deepPurple[500]!,
      Colors.deepPurple.shade800,
    ];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: cardColors[index % cardColors.length],
          child: Icon(
            Icons.person,
            color: Colors.white,
            size: 30,
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'ID: $id',
                style: TextStyle(
                  color: Colors.deepPurple.shade700,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.school, size: 14, color: Colors.grey.shade600),
                const SizedBox(width: 4),
                Text(
                  'Student',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}