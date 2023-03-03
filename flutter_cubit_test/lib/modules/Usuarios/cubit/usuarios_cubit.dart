// ignore_for_file: cascade_invocations

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_cubit_test/core/controllers/usuarios_controller.dart';
import 'package:flutter_cubit_test/data/model/usuarios_model.dart';

part 'usuarios_state.dart';

class UsuariosCubit extends Cubit<UsuariosState> {
  UsuariosCubit() : super(const UsuariosState());

  final ctrl = UsuariosController();

  Future<void> getAll() async {
    emit(state.copyWith(status: UsuarioEstatus.loading));

    try {
      await Future.delayed(const Duration(seconds: 1));
      final lsUsuarios = await ctrl.getAll();

      emit(
        state.copyWith(
          status: UsuarioEstatus.success,
          lsUsuarios: lsUsuarios,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: UsuarioEstatus.failure));
    }
  }

  Future<void> save(String text) async {
    emit(state.copyWith(status: UsuarioEstatus.loading));

    try {
      ctrl.save(UsuariosModel(name: text));
      await getAll();
    } catch (e) {
      emit(state.copyWith(status: UsuarioEstatus.saveError));
    }
  }
}
