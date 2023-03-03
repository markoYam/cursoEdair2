import 'dart:ffi';

import 'package:flutter_cubit_test/data/model/menu_usuario.dart';
import 'package:flutter_cubit_test/data/model/usuarios_model.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class GrupoMenuModel {
  GrupoMenuModel({this.id = 0, required this.name});

  @Id(assignable: true)
  int id;
  final String name;
  final lsMenus = ToMany<MenuUsuarioModel>();
  final usuario = ToOne<UsuariosModel>();
}
