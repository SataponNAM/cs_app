import 'package:flutter/material.dart';
import 'package:flutter_app/logic/bottom_nav_cubit.dart';
import 'package:flutter_app/logic/drawer/drawer_bloc.dart';
<<<<<<< HEAD
import 'package:flutter_app/pages/login/login_page.dart';
import 'package:flutter_app/pages/news/news_page.dart';
=======
import 'package:flutter_app/pages/auth_page/login_page.dart';
>>>>>>> ca19191747dfb9d1ceddef06201bcab9379df4b8
import 'package:flutter_app/widgets/main_wrapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BottomNavCubit()),
        BlocProvider(create: (_) => DrawerBloc()),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CS App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
<<<<<<< HEAD
      home: const MainWrapper(),
=======
      home: LoginPage()//MainWrapper(),
>>>>>>> ca19191747dfb9d1ceddef06201bcab9379df4b8
    );
  }
}