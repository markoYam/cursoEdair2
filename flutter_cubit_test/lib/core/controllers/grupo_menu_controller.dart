import 'package:flutter_cubit_test/core/data_base_controller.dart';
import 'package:flutter_cubit_test/data/model/menu_grupo.dart';
import 'package:flutter_cubit_test/data/objectbox.g.dart';

class GrupoMenuController {
  Future<List<GrupoMenuModel>> getAll({required int idUsuario}) async {
    final box = DataBaseController.store.box<GrupoMenuModel>();
    final query = box.query()
      ..link(GrupoMenuModel_.usuario, UsuariosModel_.id.equals(idUsuario));

    final lsGrupoMenu = query.build().find();

    return lsGrupoMenu;
  }

  Future<bool> insert({required GrupoMenuModel grupoMenu}) async {
    final box = DataBaseController.store.box<GrupoMenuModel>();
    final id = box.put(grupoMenu);
    return id > 0;
  }

  Future<bool> update({required GrupoMenuModel grupoMenu}) async {
    final box = DataBaseController.store.box<GrupoMenuModel>();
    final id = box.put(grupoMenu);
    return id > 0;
  }

  Future<bool> delete({required GrupoMenuModel grupoMenu}) async {
    final box = DataBaseController.store.box<GrupoMenuModel>();
    final result = box.remove(grupoMenu.id);
    return result;
  }
}
