import 'dart:ffi';

import 'package:flutter_cubit_test/data/model/menu_grupo.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class MenuUsuarioModel {
  MenuUsuarioModel({this.id = 0, required this.name});

  @Id(assignable: true)
  int id;
  final String name;

  final grupo = ToOne<GrupoMenuModel>();
}
