import 'package:flutter/material.dart';
import 'package:flutter_app/logic/drawer/drawer_bloc.dart';
import 'package:flutter_app/logic/bottom_nav_cubit.dart';
import 'package:flutter_app/pages/about/about_page.dart';
import 'package:flutter_app/pages/csb/csb_page.dart';
import 'package:flutter_app/pages/download/download_page.dart';
import 'package:flutter_app/pages/news/news_page.dart';
import 'package:flutter_app/pages/rule/rule_page.dart';
import 'package:flutter_app/pages/service/service_page.dart';
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

  _NavigationItem(this.item, this.title, this.link);
}

class _MenuPageState extends State<MenuPage> {
  final List<_NavigationItem> _listItems = [
    _NavigationItem(NavItem.aboutMenu, "แนะนำภาควิชา", '/aboutCs'),
    _NavigationItem(NavItem.newsMenu, "ข่าวสารและกิจกรรม", '/newsMenu'),
    _NavigationItem(NavItem.csbPage, "โครงการพิเศษ(สองภาษา)", '/csb'),
    _NavigationItem(NavItem.downloadMenu, "ดาวน์โหลด", '/downloadMenu'),
    _NavigationItem(NavItem.serviceMenu, "บริการนักศึกษา", '/servicesMenu'),
    _NavigationItem(NavItem.ruleMenu, "ระเบียบ/ประกาศ", '/rule'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 20),
      itemCount: _listItems.length,
      shrinkWrap: true,
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
          builder: (BuildContext context) => Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              shadowColor: Color.fromRGBO(240, 221, 252, 0.612),
              child: ListTile(
                title: Text(
                  data.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context,
                      data.link
                  );
                },
              ),
            ),
          ),
        ),
      );
}
