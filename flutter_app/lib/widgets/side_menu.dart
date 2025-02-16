import 'package:flutter/material.dart';
import 'package:flutter_app/pages/about_cs/test_page.dart';
import 'package:flutter_app/widgets/main_wrapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/logic/drawer/drawer_bloc.dart';

class _NavigationItem {
  final NavItem item;
  final String title;
  final Widget? link; // สามารถเป็น null ได้

  _NavigationItem(this.item, this.title, {this.link});
}

class SideMenu extends StatelessWidget {
  SideMenu({super.key});

  final List<_NavigationItem> _listItems = [
    _NavigationItem(
      NavItem.home,
      "หน้าหลัก",
      link: MainWrapper(), // ✅ กำหนด `link` 
    ),
    _NavigationItem(
      NavItem.aboutMenu,
      "เกี่ยวกับภาควิชา",
      link: TestPage(),
    ),
    _NavigationItem(
      NavItem.downloadMenu,
      "ดาวน์โหลด", // ❌ ไม่มี `link` ให้เป็น null
    ),
    _NavigationItem(
      NavItem.newsMenu,
      "ข่าวสาร/กิจกรรม",
    ),
    _NavigationItem(
      NavItem.serviceMenu,
      "บริการนักศึกษา",
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
  BlocProvider.of<DrawerBloc>(context).add(NavigateTo(data.item));
  Navigator.pop(context);

  if (data.item == NavItem.home) {
    // Go back to MainWrapper by clearing all previous routes
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainWrapper()),
      (route) => false, // Removes all previous routes
    );
  } else if (data.link != null) {
    // Navigate normally to other pages
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => data.link!),
    );
  }
}

}
