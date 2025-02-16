import 'package:flutter/material.dart';
import 'package:flutter_app/logic/bottom_nav_cubit.dart';
import 'package:flutter_app/logic/drawer/drawer_bloc.dart';
import 'package:flutter_app/pages/about_cs/test_page.dart';
import 'package:flutter_app/widgets/side_menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../pages/pages.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  late PageController pageController;
  late DrawerBloc _drawerBloc;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    _drawerBloc = DrawerBloc();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final List<Widget> topLevelPages = const [
    HomePage(),
    ProfessorPage(),
    CoursePage()
  ];

  void onPageChanged(int page) {
    BlocProvider.of<BottomNavCubit>(context).changeSelectedIndex(page);
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
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            appBar: _mainWrapperAppBar(state),
            body: _mainWrapperBody(),
            drawer: SideMenu(),
            bottomNavigationBar: _mainWrapperBottomNavBar(context),
          );
        },
      ),
    );
  }

  // Build AppBar
  AppBar _mainWrapperAppBar(DrawerState state) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(243, 237, 247, 100),
      title: const Text('Logo'),
    );
  }

  // Build Body
  PageView _mainWrapperBody() {
    return PageView(
      onPageChanged: (int page) => onPageChanged(page),
      controller: pageController,
      children: topLevelPages,
    );
  }

  // Bottom Navigation Bar - Item
  Widget _bottomAppBarItem(
    BuildContext context, {
    required defaultIcon,
    required page,
    required label,
    required filledIcon,
  }) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<BottomNavCubit>(context).changeSelectedIndex(page);

        pageController.animateToPage(page,
            duration: const Duration(milliseconds: 10),
            curve: Curves.fastLinearToSlowEaseIn);
      },
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 8,
            ),
            Icon(
              context.watch<BottomNavCubit>().state == page
                  ? filledIcon
                  : defaultIcon,
              color: context.watch<BottomNavCubit>().state == page
                  ? Colors.deepPurple.shade400
                  : Colors.grey.shade800,
              size: 25,
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              label,
              style: TextStyle(
                color: context.watch<BottomNavCubit>().state == page
                    ? Colors.deepPurple.shade400
                    : Colors.grey.shade800,
                fontSize: 13,
                fontWeight: context.watch<BottomNavCubit>().state == page
                    ? FontWeight.w600
                    : FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }

  // Bottom Navigation Bar - Main Wrapper
  BottomAppBar _mainWrapperBottomNavBar(BuildContext context) {
    return BottomAppBar(
      color: const Color.fromRGBO(243, 237, 247, 100),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _bottomAppBarItem(context,
                  defaultIcon: IconlyLight.home,
                  page: 0,
                  label: "Home",
                  filledIcon: IconlyBold.home),
              _bottomAppBarItem(context,
                  defaultIcon: IconlyLight.home,
                  page: 1,
                  label: "Professor",
                  filledIcon: IconlyBold.home),
              _bottomAppBarItem(context,
                  defaultIcon: IconlyLight.home,
                  page: 2,
                  label: "Course",
                  filledIcon: IconlyBold.home)
            ],
          )),
        ],
      ),
    );
  }

}
