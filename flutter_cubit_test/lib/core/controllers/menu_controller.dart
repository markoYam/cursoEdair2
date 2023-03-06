import 'package:flutter_cubit_test/core/data_base_controller.dart';
import 'package:flutter_cubit_test/data/model/menu_usuario.dart';
import 'package:flutter_cubit_test/data/objectbox.g.dart';

class MenuController {
  Future<List<MenuUsuarioModel>> getAll({required int idGrupoMenu}) async{
    final box = DataBaseController.store.box<MenuUsuarioModel>();
    final query = box.query()..link(MenuUsuarioModel_.grupo, GrupoMenuModel_.id.equals(idGrupoMenu));
    final lsMenu = query.build().find();

    return lsMenu;
  }
  Future<bool> insert({required MenuUsuarioModel menuUsuario}) async {
    final box = DataBaseController.store.box<MenuUsuarioModel>();
    final id = box.put(menuUsuario);
    return id > 0;
  }

  Future<bool> update({required MenuUsuarioModel menuUsuario}) async {
    final box = DataBaseController.store.box<MenuUsuarioModel>();
    final id = box.put(menuUsuario);
    return id > 0;
  }

  Future<bool> delete({required MenuUsuarioModel menuUsuario}) async {
    final box = DataBaseController.store.box<MenuUsuarioModel>();
    final result = box.remove(menuUsuario.id);
    return result;
  }
}
