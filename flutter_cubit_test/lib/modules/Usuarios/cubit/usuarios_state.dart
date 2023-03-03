part of 'usuarios_cubit.dart';

class UsuariosState extends Equatable {
  const UsuariosState({
    this.status = UsuarioEstatus.none,
    this.lsUsuarios = const <UsuariosModel>[],
  });

  final UsuarioEstatus status;
  final List<UsuariosModel> lsUsuarios;

  UsuariosState copyWith({
    UsuarioEstatus? status,
    List<UsuariosModel>? lsUsuarios,
  }) {
    return UsuariosState(
      status: status ?? this.status,
      lsUsuarios: lsUsuarios ?? this.lsUsuarios,
    );
  }

  @override
  List<Object> get props => [status];
}

enum UsuarioEstatus { none, loading, success, failure, saveOk, saveError }
