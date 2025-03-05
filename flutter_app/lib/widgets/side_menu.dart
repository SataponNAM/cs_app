import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/logic/bottom_nav_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/logic/drawer/drawer_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class _NavigationItem {
  final IconData icon;
  final NavItem item;
  final String title;

  _NavigationItem(this.icon, this.item, this.title);
}

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  String? _username;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // โหลดข้อมูล user
  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    
    if (token != null && token.isNotEmpty) {
      await getUsers(token);
    }
    
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> getUsers(String token) async {
    try {
      final url = Uri.parse('http://202.44.40.179:3000/user');
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> user = jsonDecode(response.body);
        setState(() {
          _username = user['username'];
        });
      } else {
        await _logout();
      }
    } catch (e) {
      await _logout();
    }
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    setState(() {
      _username = null;
    });
  }

  // navigator ใน sidebar
  final List<_NavigationItem> _listItems = [
    _NavigationItem(Icons.people_outline_rounded, NavItem.aboutUs, "เกี่ยวกับเรา"),
    _NavigationItem(Icons.settings_outlined, NavItem.setting, "ตั้งค่า"),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //     colors: [
        //       Colors.deepPurple.shade50,
        //       Colors.deepPurple.shade100,
        //     ],
        //   ),
        // ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              _buildHeader(context),
              
              const SizedBox(height: 16),
              
              // Navigation Items
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: _listItems.length,
                  itemBuilder: (context, index) {
                    return BlocBuilder<DrawerBloc, DrawerState>(
                      buildWhen: (previous, current) =>
                          previous.selectedItem != current.selectedItem,
                      builder: (context, state) =>
                          _buildNavigationItem(_listItems[index], state),
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

  // สร้างส่วนหัวของ sidebar
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade100.withOpacity(0.5),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.deepPurple.shade200,
            child: _isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : _username != null
                    ? Text(
                        _username![0].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : const Icon(Icons.person_outline, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _username ?? 'Guest',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade800,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  _username != null ? 'Active' : 'Not Logged In',
                  style: TextStyle(
                    fontSize: 14,
                    color: _username != null 
                      ? Colors.green.shade700 
                      : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // สร้่างรายการ menu
  Widget _buildNavigationItem(_NavigationItem data, DrawerState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: state.selectedItem == data.item 
          ? Colors.deepPurple.shade100 
          : Colors.transparent,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: Icon(
            data.icon,
            color: state.selectedItem == data.item 
              ? Colors.deepPurple.shade700 
              : Colors.grey.shade700,
          ),
          title: Text(
            data.title,
            style: TextStyle(
              color: state.selectedItem == data.item 
                ? Colors.deepPurple.shade700 
                : Colors.grey.shade800,
              fontWeight: state.selectedItem == data.item 
                ? FontWeight.bold 
                : FontWeight.normal,
            ),
          ),
          onTap: () {
            _handleItemClick(context, data);
          },
        ),
      ),
    );
  }

  void _handleItemClick(BuildContext context, _NavigationItem data) {
    int index = _getIndexFromNavItem(data.item);
    context.read<BottomNavCubit>().changeSelectedIndex(index);
    Navigator.pop(context);
  }

  int _getIndexFromNavItem(NavItem item) {
    switch (item) {
      case NavItem.aboutUs:
        return 5;
      case NavItem.setting:
        return 6;
      default:
        return 0;
    }
  }
}