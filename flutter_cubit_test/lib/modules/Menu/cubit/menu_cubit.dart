import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_cubit_test/data/model/menu_grupo.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(const MenuState());

  Future<void> loadMenu() async {
    emit(
      state.copyWith(
        status: MenuStatus.loading,
      ),
    );
    try {
      final lsMenusGrupos = <GrupoMenuModel>[];

      emit(
        state.copyWith(
          status: MenuStatus.success,
          lsMenusGrupos: lsMenusGrupos,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: MenuStatus.failure));
    }
  }
}
