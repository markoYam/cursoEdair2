import 'package:flutter_cubit_test/data/model/menu_grupo.dart';
import 'package:flutter_cubit_test/data/model/menu_usuario.dart';
import 'package:flutter_cubit_test/data/model/usuarios_model.dart';

class MockDataHelper {
  static List<UsuariosModel> getMockDataListUsuarios({int count = 10}) {
    final mockDataList = <UsuariosModel>[];
    for (var i = 0; i < count; i++) {
      mockDataList.add(
        UsuariosModel(
          name: 'Usuario $i',
        ),
      );
    }
    return mockDataList;
  }

  //get list menu grupo
  static List<GrupoMenuModel> getMockDataListMenuGrupo({int count = 10}) {
    final mockDataList = <GrupoMenuModel>[];
    for (var i = 0; i < count; i++) {
      mockDataList.add(
        GrupoMenuModel(
          name: 'Grupo $i',
        ),
      );
    }
    return mockDataList;
  }

  //get list menu usuario
  static List<MenuUsuarioModel> getMockDataListMenuUsuario({int count = 10}) {
    final mockDataList = <MenuUsuarioModel>[];
    for (var i = 0; i < count; i++) {
      mockDataList.add(
        MenuUsuarioModel(
          name: 'Menú $i',
        ),
      );
    }
    return mockDataList;
  }

  static Future<void> initMockData() async {
    final mockDataListUsuarios = getMockDataListUsuarios();
    final mockDataListMenuGrupo = getMockDataListMenuGrupo();
    final mockDataListMenuUsuario = getMockDataListMenuUsuario();
  }
}
