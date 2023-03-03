// ignore_for_file: cascade_invocations

import 'package:flutter_cubit_test/core/data_base_controller.dart';
import 'package:flutter_cubit_test/data/model/usuarios_model.dart';

class UsuariosController {
  Future<List<UsuariosModel>> getAll() async {
    final box = DataBaseController.store.box<UsuariosModel>();
    final lsUsuarios = box.getAll();
    return lsUsuarios;
  }

  void save(UsuariosModel usuario) {
    final box = DataBaseController.store.box<UsuariosModel>();
    box.put(usuario);
  }

  UsuariosModel? getById(int id) {
    final box = DataBaseController.store.box<UsuariosModel>();
    final usuario = box.get(id);
    return usuario;
  }
}
