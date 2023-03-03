import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit_test/core/controllers/grupo_menu_controller.dart';
import 'package:flutter_cubit_test/core/controllers/usuarios_controller.dart';
import 'package:flutter_cubit_test/data/model/menu_grupo.dart';
import 'package:flutter_cubit_test/data/model/usuarios_model.dart';

part 'grupos_menu_state.dart';

class GruposMenuCubit extends Cubit<GruposMenuState> {
  GruposMenuCubit() : super(const GruposMenuState());

  final GrupoMenuController _grupoMenuController = GrupoMenuController();

  Future<void> init({required int idUsuario}) async {
    final usuario = UsuariosController().getById(idUsuario);
    emit(state.copyWith(usuario: usuario));
    await getAll();
  }

  Future<void> getAll() async {
    emit(state.copyWith(status: GrupoMenuEstatus.loading));

    final result =
        await _grupoMenuController.getAll(idUsuario: state.usuario!.id);

    if (result.isNotEmpty) {
      emit(
        state.copyWith(
          status: GrupoMenuEstatus.success,
          lsGruposMenu: result.reversed.toList(),
        ),
      );
    } else {
      emit(state.copyWith(status: GrupoMenuEstatus.failure));
    }
  }

  Future<void> insert({
    required String grupoMenu,
    required BuildContext context,
  }) async {
    emit(state.copyWith(status: GrupoMenuEstatus.loading));

    final grupo = GrupoMenuModel(name: grupoMenu);
    grupo.usuario.target = state.usuario;

    final result = await _grupoMenuController.insert(
      grupoMenu: grupo,
    );

    if (result) {
      await showDialogOkInsert(context: context);
      await getAll();
    } else {
      emit(state.copyWith(status: GrupoMenuEstatus.failure));
    }
  }

  Future<void> showDialogOkInsert({required BuildContext context}) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Grupo de menu creado'),
          content: const Text('El grupo de menu se ha creado correctamente'),
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
