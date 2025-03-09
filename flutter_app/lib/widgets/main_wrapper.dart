import 'package:flutter/material.dart';
import 'package:flutter_app/logic/bottom_nav_cubit.dart';
import 'package:flutter_app/logic/NavigatorInBody/drawer_bloc.dart';
import 'package:flutter_app/pages/about_us/about_us_page.dart';
import 'package:flutter_app/widgets/side_menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/main_pages/pages.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  late DrawerBloc _drawerBloc;
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    _drawerBloc = DrawerBloc();
    checkIsLogin();
  }

  final List<Widget> topLevelPages = const [
    HomePage(),
    PersonnelPage(),
    CoursePage(),
    ContactPage(),
    MenuPage(),
    AboutUsPage()
  ];

  Future<void> checkIsLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');
    if (token != null && token.isNotEmpty) {
      print("login");
      setState(() {
        isLogin = true;
      });
    }
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _drawerBloc,
      child: BlocConsumer<DrawerBloc, DrawerState>(
        listener: (context, state) {},
        buildWhen: (previous, current) {
          return previous.selectedItem != current.selectedItem;
        },
        listenWhen: (previous, current) {
          return previous.selectedItem != current.selectedItem;
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: _mainWrapperAppBar(state),
            body: SafeArea(
              child: _mainWrapperBody(context),
            ),
            drawer: SideMenu(),
            drawerEnableOpenDragGesture: true,
            bottomNavigationBar: _mainWrapperBottomNavBar(context),
          );
        },
      ),
    );
  }

  // Build AppBar
  AppBar _mainWrapperAppBar(DrawerState state) {
    return AppBar(
      backgroundColor: Colors.deepPurple[500],
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(
            Icons.menu_rounded,
            color: Colors.white,
            size: 28,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(
            'http://202.44.40.179/Data_From_Chiab/Image/img/logo.png',
            width: 40,
            color: Colors.white,
            colorBlendMode: BlendMode.srcIn,
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: isLogin
              ? () {
                  print("logout");
                  setState(() {
                    isLogin = false;
                  });
                  _logout();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                }
              : () {
                  print("login");
                  Navigator.pushNamed(context, '/login');
                },
          icon: Icon(
            isLogin ? Icons.logout_rounded : Icons.login_rounded,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  // Build Body
  Widget _mainWrapperBody(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, selectedIndex) {
        return IndexedStack(
          index: selectedIndex,
          children: topLevelPages,
        );
      },
    );
  }

  // Bottom Navigation Bar - Item
  Widget _bottomAppBarItem(
    BuildContext context, {
    required defaultIcon,
    required int page,
    required String label,
    required filledIcon,
  }) {
    final isSelected = context.watch<BottomNavCubit>().state == page;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          BlocProvider.of<BottomNavCubit>(context).changeSelectedIndex(page);
        },
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSelected ? filledIcon : defaultIcon,
                color: isSelected ? Colors.deepPurple[700] : Colors.grey.shade600,
                size: 25,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.deepPurple[700] : Colors.grey.shade600,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Bottom Navigation Bar - Main Wrapper
  BottomAppBar _mainWrapperBottomNavBar(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      elevation: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _bottomAppBarItem(context,
              defaultIcon: IconlyLight.home,
              page: 0,
              label: "Home",
              filledIcon: IconlyBold.home),
          _bottomAppBarItem(context,
              defaultIcon: IconlyLight.user,
              page: 1,
              label: "Personnel",
              filledIcon: IconlyBold.user_2),
          _bottomAppBarItem(context,
              defaultIcon: IconlyLight.document,
              page: 2,
              label: "Course",
              filledIcon: IconlyBold.document),
          _bottomAppBarItem(context,
              defaultIcon: IconlyLight.call,
              page: 3,
              label: "Contact",
              filledIcon: IconlyBold.call),
          _bottomAppBarItem(context,
              defaultIcon: IconlyLight.more_square,
              page: 4,
              label: "Menu",
              filledIcon: IconlyBold.more_square),
        ],
      ),
    );
  }
}