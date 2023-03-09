import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_test/data/model/menu_grupo.dart';
import 'package:flutter_cubit_test/data/model/menu_usuario.dart';
import 'package:flutter_cubit_test/modules/GruposMenu/cubit/grupos_menu_cubit.dart';
import 'package:flutter_cubit_test/modules/Menu/menu_page.dart';

class GruposMenuPage extends StatefulWidget {
  const GruposMenuPage({super.key, required this.idUsuario});

  final int idUsuario;

  @override
  State<GruposMenuPage> createState() => _GruposMenuPageState();
}

class _GruposMenuPageState extends State<GruposMenuPage> {
  late GruposMenuCubit _cubit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grupos de Menú'),
      ),
      body: BlocProvider(
        create: (context) => GruposMenuCubit()
          ..init(
            idUsuario: widget.idUsuario,
          ),
        child: BlocBuilder<GruposMenuCubit, GruposMenuState>(
          builder: (context, state) {
            _cubit = context.read<GruposMenuCubit>();
            Widget child = const Center(child: Text('No hay datos1'));
            if (state.status == GrupoMenuEstatus.loading) {
              child = const Center(child: CircularProgressIndicator());
            } else if (state.status == GrupoMenuEstatus.success) {
              child = ListView.separated(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => MenuPage(
                            idGrupoMenu: state.lsGruposMenu[index].id,
                          ),
                        ),
                      ).then((value) => _cubit.getAll());
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const FlutterLogo(),
                          title: Text(
                            state.lsGruposMenu[index].name,
                          ),
                        ),
                        listMenusGrupo(
                          lsMenus: state.lsGruposMenu[index].lsMenus,
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: state.lsGruposMenu.length,
              );
            } else {
              child = const Center(child: Text('No hay datos2'));
            }

            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    'Usuario ${state.usuario!.name}',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 10),
                  formNewGroup(),
                  const SizedBox(height: 10),
                  Expanded(child: child),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget listMenusGrupo({required List<MenuUsuarioModel> lsMenus}) {
    //list litle menus
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 50),
          child: InkWell(
            onTap: () {},
            child: ListTile(
              //leading: const FlutterLogo(),
              title: Text(
                lsMenus[index].name,
              ),
            ),
          ),
        );
      },
      itemCount: lsMenus.length,
    );
  }

  final controllerNombre = TextEditingController();
  Widget formNewGroup() {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Nombre del Grupo',
          ),
          controller: controllerNombre,
        ),
        ElevatedButton(
          onPressed: () {
            _cubit.insert(grupoMenu: controllerNombre.text, context: context);
            controllerNombre.clear();
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
