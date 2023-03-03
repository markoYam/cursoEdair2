part of 'grupos_menu_cubit.dart';

class GruposMenuState extends Equatable {
  const GruposMenuState({
    this.status = GrupoMenuEstatus.initial,
    this.lsGruposMenu = const [],
    this.usuario,
  });

  final GrupoMenuEstatus status;
  final List<GrupoMenuModel> lsGruposMenu;
  final UsuariosModel? usuario;

  GruposMenuState copyWith({
    GrupoMenuEstatus? status,
    List<GrupoMenuModel>? lsGruposMenu,
    UsuariosModel? usuario,
  }) {
    return GruposMenuState(
      status: status ?? this.status,
      lsGruposMenu: lsGruposMenu ?? this.lsGruposMenu,
      usuario: usuario ?? this.usuario,
    );
  }

  @override
  List<Object> get props => [status];
}

enum GrupoMenuEstatus { initial, loading, success, failure }
