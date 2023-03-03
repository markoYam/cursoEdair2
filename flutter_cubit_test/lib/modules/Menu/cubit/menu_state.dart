part of 'menu_cubit.dart';

class MenuState extends Equatable {
  const MenuState({
    this.status = MenuStatus.loading,
    this.lsMenusGrupos = const <GrupoMenuModel>[],
  });

  final MenuStatus status;
  final List<GrupoMenuModel> lsMenusGrupos;

  MenuState copyWith({
    MenuStatus? status,
    List<GrupoMenuModel>? lsMenusGrupos,
  }) {
    return MenuState(
      status: status ?? this.status,
      lsMenusGrupos: lsMenusGrupos ?? this.lsMenusGrupos,
    );
  }

  @override
  List<Object?> get props => [status, lsMenusGrupos];
}

enum MenuStatus { none, loading, success, failure }
