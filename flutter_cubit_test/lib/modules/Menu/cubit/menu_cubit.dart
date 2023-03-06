import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit_test/core/controllers/grupo_menu_controller.dart';
import 'package:flutter_cubit_test/core/controllers/menu_controller.dart';
import 'package:flutter_cubit_test/data/model/menu_grupo.dart';
import 'package:flutter_cubit_test/data/model/menu_usuario.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(const MenuState());

  final MenuController _menuController = MenuController();

  Future<void> init({required int idGrupoMenu}) async {
    final grupo = GrupoMenuController().getById(idGrupoMenu);
    emit(state.copyWith(grupoMenu: grupo));
    await getAll();
  }

  Future<void> getAll() async {
    emit(state.copyWith(status: MenuStatus.loading));

    final result =
        await _menuController.getAll(idGrupoMenu: state.grupoMenu!.id);

    if (result.isNotEmpty) {
      emit(
        state.copyWith(
          status: MenuStatus.success,
          lsMenusGrupos: result.reversed.toList(),
        ),
      );
    } else {
      emit(state.copyWith(status: MenuStatus.failure));
    }
  }

   Future<void> insert({
    required String menuUsuario,
    required BuildContext context,
  }) async {
    emit(state.copyWith(status: MenuStatus.loading));

    final grupo = MenuUsuarioModel(name: menuUsuario);
    grupo.grupo.target = state.grupoMenu;

    final result = await _menuController.insert(
      menuUsuario: grupo,
    );

    if (result) {
      await showDialogOkInsert(context: context);
      await getAll();
    } else {
      emit(state.copyWith(status: MenuStatus.failure));
    }
  }

  Future<void> showDialogOkInsert({required BuildContext context}) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Menu creado'),
          content: const Text('Menu se ha creado correctamente'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            )
          ],
        );
      },
    );
  }

}
