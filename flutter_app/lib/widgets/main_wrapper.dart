import 'package:flutter/material.dart';
import 'package:flutter_app/logic/bottom_nav_cubit.dart';
import 'package:flutter_app/pages/test_page.dart';
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

  @override
  void initState() {
    super.initState();
    pageController = PageController();
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
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: _mainWrapperAppBar(),
      body: _mainWrapperBody(),
      bottomNavigationBar: _mainWrapperBottomNavBar(context),
    );
  }

  AppBar _mainWrapperAppBar () {
    return AppBar(
      backgroundColor: Colors.deepPurple.shade100,
      title: const Text('Logo'),
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.menu),
      ),
    );
  }

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

          pageController.animateToPage(
            page, 
            duration: const Duration(milliseconds: 10), 
            curve: Curves.fastLinearToSlowEaseIn
          );
        },

        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 8,
              ),
              Icon(
                context.watch<BottomNavCubit>().state == page ? filledIcon : defaultIcon,
                color: context.watch<BottomNavCubit>().state == page ? Colors.deepPurple.shade400 : Colors.grey.shade800,
                size: 25,
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                label,
                style: TextStyle(
                  color: context.watch<BottomNavCubit>().state == page ? Colors.purple.shade900 : Colors.grey,
                  fontSize: 13,
                  fontWeight: context.watch<BottomNavCubit>().state == page ? FontWeight.w600 : FontWeight.w400,
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
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _bottomAppBarItem(
                  context, 
                  defaultIcon: IconlyLight.home, 
                  page: 0, 
                  label: "Home", 
                  filledIcon: IconlyBold.home
                ),
                _bottomAppBarItem(
                  context, 
                  defaultIcon: IconlyLight.home, 
                  page: 1, 
                  label: "Professor", 
                  filledIcon: IconlyBold.home
                ),
                _bottomAppBarItem(
                  context, 
                  defaultIcon: IconlyLight.home, 
                  page: 2, 
                  label: "Course", 
                  filledIcon: IconlyBold.home
                )
              ],
            )
          ),
        ],
      ),
    );
  }
}