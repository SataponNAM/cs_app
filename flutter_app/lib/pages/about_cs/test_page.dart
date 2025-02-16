import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/side_menu.dart'; // Import side menu
import 'package:flutter_app/logic/drawer/drawer_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late DrawerBloc _drawerBloc;

  @override
  void initState() {
    super.initState();
    _drawerBloc = DrawerBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _drawerBloc,
      child: BlocConsumer<DrawerBloc, DrawerState>(

        // Listener
        listener: (context, state) {
          // Handle any state changes
        },

        // Build When
        buildWhen: (previous, current) {
          return previous.selectedItem != current.selectedItem;
        },

        /// Listen When
        listenWhen: (previous, current) {
          return previous.selectedItem != current.selectedItem;
        },

        // Builder
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            appBar: _mainWrapperAppBar(state),
            drawer: SideMenu(), // Add the sidebar here
            body: const Center(
              child: Text('Test Page'),
            ),
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
}
