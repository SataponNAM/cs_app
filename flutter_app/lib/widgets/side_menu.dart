import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/logic/bottom_nav_cubit.dart';
import 'package:flutter_app/pages/auth_page/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/logic/drawer/drawer_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class _NavigationItem {
  final Icon icon;
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
  String _username = '';

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      final token = prefs.getString('token') ?? '';
      getUsers(token);
    });
  }

  Future<void> getUsers(String token) async {
    final url = Uri.parse('http://202.44.40.179:3000/user');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print(token);

    if (response.statusCode == 200) {
      final Map<String, dynamic> user = jsonDecode(response.body);
      setState(() {
        _username = user['username'] ?? 'Guest';
      });
      //print('User: $user');
    } else if (response.statusCode == 401) {
      // Unauthorized, prompt user to log in again
      print('Token is invalid or expired. Please log in again.');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
        (Route<dynamic> route) => false,
      );
    } else {
      print('ดึงข้อมูลไม่สำเร็จ: ${response.body}');
    }
  }

  final List<_NavigationItem> _listItems = [
    _NavigationItem(
      Icon(Icons.people),
      NavItem.aboutUs,
      "เกี่ยวกับเรา",
    ),
    _NavigationItem(
      Icon(Icons.settings),
      NavItem.setting,
      "ตั้งค่า",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 288,
      height: double.infinity,
      color: const Color.fromARGB(255, 243, 237, 247),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Center(
                child: Text(
                  _username,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: _listItems.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return BlocBuilder<DrawerBloc, DrawerState>(
                      buildWhen: (previous, current) {
                        return previous.selectedItem != current.selectedItem;
                      },
                      builder: (context, state) =>
                          _buildItem(_listItems[index], state),
                    );
                  },
                ),
              ],
            ),

            // Logout
            const Spacer(),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text("ออกจากระบบ"),
              onTap: () async {
                // ออกจากระบบ
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove('token');
                await prefs.remove('username');

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(_NavigationItem data, DrawerState state) =>
      _makeListItem(data, state);

  Widget _makeListItem(_NavigationItem data, DrawerState state) => Card(
        color: Colors.transparent,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        borderOnForeground: true,
        elevation: 0,
        margin: EdgeInsets.zero,
        child: Builder(
          builder: (BuildContext context) => ListTile(
            leading: data.icon,
            title: Text(
              data.title,
              style: TextStyle(
                color: Colors.grey.shade800,
              ),
            ),
            onTap: () {
              _handleItemClick(context, data);
            },
          ),
        ),
      );

  /// Tap OnEach item Handler
  void _handleItemClick(BuildContext context, _NavigationItem data) {
    int index = _getIndexFromNavItem(data.item);

    // เปลี่ยนหน้าโดยใช้ BottomNavCubit
    context.read<BottomNavCubit>().changeSelectedIndex(index);

    // ปิด Side Menu
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
