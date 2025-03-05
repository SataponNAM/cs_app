import 'package:flutter/material.dart';
import 'package:flutter_app/logic/drawer/drawer_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _NavigationItem {
  final NavItem item;
  final String title;
  final String link;
  final IconData icon;

  _NavigationItem(this.item, this.title, this.link, this.icon);
}

class _MenuPageState extends State<MenuPage> {
  final List<_NavigationItem> _listItems = [
    _NavigationItem(NavItem.aboutMenu, "แนะนำภาควิชา", '/aboutCs', Icons.info),
    _NavigationItem(NavItem.newsMenu, "ข่าวสารและกิจกรรม", '/newsMenu', Icons.event),
    _NavigationItem(NavItem.csbPage, "โครงการพิเศษ", '/csb', Icons.language),
    _NavigationItem(NavItem.downloadMenu, "ดาวน์โหลด", '/downloadMenu', Icons.download),
    _NavigationItem(NavItem.serviceMenu, "บริการนักศึกษา", '/servicesMenu', Icons.school),
    _NavigationItem(NavItem.ruleMenu, "ระเบียบ/ประกาศ", '/rule', Icons.rule),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: 100,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: _listItems.length,
      itemBuilder: (context, index) {
        return BlocBuilder<DrawerBloc, DrawerState>(
          buildWhen: (previous, current) {
            return previous.selectedItem != current.selectedItem;
          },
          builder: (context, state) => _buildItem(_listItems[index], state),
        );
      },
    );
  }

  Widget _buildItem(_NavigationItem data, DrawerState state) => _makeListItem(data, state);

  Widget _makeListItem(_NavigationItem data, DrawerState state) => Container(
        child: Builder(
          builder: (BuildContext context) => InkWell(
            onTap: () {
              // Handle the tap event here
              Navigator.pushNamed(context, data.link);
            },
            child: Card(
              shadowColor: Color.fromRGBO(240, 221, 252, 0.612),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(data.icon, color: Colors.grey.shade800, size: 30),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Text(
                        data.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}