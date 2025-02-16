import 'package:flutter/material.dart';
import 'package:flutter_app/logic/bottom_nav_cubit.dart';
import 'package:flutter_app/widgets/main_wrapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CS App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:BlocProvider(
        create: (context) => BottomNavCubit(),
        child: const MainWrapper(),

      ),
    );
  }
}