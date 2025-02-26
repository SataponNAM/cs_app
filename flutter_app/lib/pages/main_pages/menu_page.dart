import 'package:flutter/material.dart';
import 'package:flutter_app/logic/drawer/drawer_bloc.dart';
import 'package:flutter_app/logic/bottom_nav_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _NavigationItem {
  final NavItem item;
  final String title;

  _NavigationItem(this.item, this.title);
}

class _MenuPageState extends State<MenuPage> {
  final List<_NavigationItem> _listItems = [
    _NavigationItem(
      NavItem.aboutMenu,
      "แนะนำภาควิชา",
    ),
    _NavigationItem(
      NavItem.newsMenu,
      "ข่าวสารและกิจกรรม",
    ),
    _NavigationItem(
      NavItem.csbPage,
      "โครงการพิเศษ(สองภาษา)",
    ),
    _NavigationItem(
      NavItem.downloadMenu,
      "ดาวน์โหลด", 
    ),
    _NavigationItem(
      NavItem.serviceMenu,
      "บริการนักศึกษา/บุคลากร",
    ),
    _NavigationItem(
      NavItem.ruleMenu,
      "ระเบียบ/ประกาศ",
    ),
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
                  _handleItemClick(context, data);
                },
              ),
            ),
          ),
        ),
      );

  void _handleItemClick(BuildContext context, _NavigationItem data) {
    int index = _getIndexFromNavItem(data.item);

    // Change the selected index using BottomNavCubit
    context.read<BottomNavCubit>().changeSelectedIndex(index);

    // Optionally close the side menu if applicable
    // Navigator.pop(context);
  }

  int _getIndexFromNavItem(NavItem item) {
    switch (item) {
      case NavItem.csbPage:
        return 5;
      case NavItem.newsMenu:
        return 6;
      case NavItem.downloadMenu:
        return 7;
      case NavItem.serviceMenu:
        return 8;
      case NavItem.aboutMenu:
        return 9;
      case NavItem.ruleMenu:
        return 10;
      default:
        return 0;
    }
  }
}