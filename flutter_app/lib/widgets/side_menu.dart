import 'package:flutter/material.dart';
import 'package:flutter_app/logic/bottom_nav_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/logic/drawer/drawer_bloc.dart';

class _NavigationItem {
  final Icon icon;
  final NavItem item;
  final String title;

  _NavigationItem(this.icon, this.item, this.title);
}

class SideMenu extends StatelessWidget {
  SideMenu({super.key});

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
          const ListTile(
            leading: CircleAvatar(),
            title: Text("CS App"),
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
                  })
            ],
          )
        ],
      )),
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
                )),
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
