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
  String? _username;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null && token.isNotEmpty) {
      await getUsers(token);
    }
  }

  Future<void> getUsers(String token) async {
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
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    setState(() {
      _username = null;
    });
  }

  final List<_NavigationItem> _listItems = [
    _NavigationItem(Icon(Icons.people), NavItem.aboutUs, "เกี่ยวกับเรา"),
    _NavigationItem(Icon(Icons.settings), NavItem.setting, "ตั้งค่า"),
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
              title: _username != null
                  ? Text(
                      _username!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: const Text(
                        "เข้าสู่ระบบ",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
            ),
            ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: _listItems.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return BlocBuilder<DrawerBloc, DrawerState>(
                  buildWhen: (previous, current) =>
                      previous.selectedItem != current.selectedItem,
                  builder: (context, state) => _buildItem(_listItems[index], state),
                );
              },
            ),
            const Spacer(),
            if (_username != null)
              ListTile(
                leading: Icon(Icons.logout),
                title: const Text("ออกจากระบบ"),
                onTap: _logout,
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
        shape: const ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
        elevation: 0,
        margin: EdgeInsets.zero,
        child: ListTile(
          leading: data.icon,
          title: Text(
            data.title,
            style: TextStyle(color: Colors.grey.shade800),
          ),
          onTap: () {
            _handleItemClick(context, data);
          },
        ),
      );

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
