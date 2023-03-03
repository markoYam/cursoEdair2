import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_test/modules/Menu/cubit/menu_cubit.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: BlocProvider(
        create: (context) => MenuCubit(),
        child: BlocBuilder<MenuCubit, MenuState>(
          builder: (context, state) {
            if (state.status == MenuStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status == MenuStatus.success) {
              return const Center(
                child: Text('Menu'),
              );
            } else {
              return const Center(
                child: Text('Menu'),
              );
            }
          },
        ),
      ),
    );
  }
}
