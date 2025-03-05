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
    _NavigationItem(NavItem.aboutMenu, "แนะนำภาควิชา", '/aboutCs', Icons.info_outline_rounded),
    _NavigationItem(NavItem.newsMenu, "ข่าวสารและกิจกรรม", '/newsMenu', Icons.event_note_rounded),
    _NavigationItem(NavItem.csbPage, "โครงการพิเศษ", '/csb', Icons.language_rounded),
    _NavigationItem(NavItem.downloadMenu, "ดาวน์โหลด", '/downloadMenu', Icons.download_rounded),
    _NavigationItem(NavItem.serviceMenu, "บริการนักศึกษา", '/servicesMenu', Icons.school_rounded),
    _NavigationItem(NavItem.ruleMenu, "ระเบียบ/ประกาศ", '/rule', Icons.rule_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [
        //       Colors.deepPurple[500]!,
        //       //Colors.deepPurple[300]!,
        //       Color.fromARGB(255, 201, 92, 159)
        //     ],
        //   ),
        // ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.9,
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
          ),
        ),
      );
  }

  Widget _buildItem(_NavigationItem data, DrawerState state) => _makeListItem(data, state);

  Widget _makeListItem(_NavigationItem data, DrawerState state) => GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, data.link);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[100]!.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  data.icon,
                  color: Colors.deepPurple[700],
                  size: 40,
                ),
              ),
              SizedBox(height: 15),
              Text(
                data.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepPurple[800],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
}