part of 'menu_cubit.dart';

class MenuState extends Equatable {
  const MenuState({
    this.status = MenuStatus.loading,
    this.lsMenusGrupos = const <MenuUsuarioModel>[],
    this.menu,
    this.grupoMenu,
  });

  final MenuStatus status;
  final List<MenuUsuarioModel> lsMenusGrupos;
  final MenuUsuarioModel? menu;
  final GrupoMenuModel? grupoMenu;

  MenuState copyWith({
    MenuStatus? status,
    List<MenuUsuarioModel>? lsMenusGrupos,
    MenuUsuarioModel? menu,
    GrupoMenuModel? grupoMenu,
  }) {
    return MenuState(
      status: status ?? this.status,
      lsMenusGrupos: lsMenusGrupos ?? this.lsMenusGrupos,
      menu: menu ?? this.menu,
      grupoMenu: grupoMenu ?? this.grupoMenu,
    );
  }

  @override
  List<Object?> get props => [status, lsMenusGrupos];
}

enum MenuStatus { none, loading, success, failure }
