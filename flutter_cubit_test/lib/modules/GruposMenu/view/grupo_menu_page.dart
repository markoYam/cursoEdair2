import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_test/data/model/usuarios_model.dart';
import 'package:flutter_cubit_test/modules/GruposMenu/cubit/grupos_menu_cubit.dart';

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
                separatorBuilder: (context, index) => const Divider(),
                itemCount: state.lsGruposMenu.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: ListTile(
                      leading: const FlutterLogo(),
                      title: Text(state.lsGruposMenu[index].name),
                    ),
                  );
                },
              );
            } else {
              child = const Center(child: Text('No hay datos2'));
            }

            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    'Usuario: ${state.usuario!.name}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  formNewGroup(),
                  Expanded(child: child)
                ],
              ),
            );
          },
        ),
      ),
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
