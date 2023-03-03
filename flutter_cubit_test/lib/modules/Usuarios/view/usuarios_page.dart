// ignore_for_file: inference_failure_on_instance_creation

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_test/modules/GruposMenu/grupo_menu_page.dart';
import 'package:flutter_cubit_test/modules/Usuarios/cubit/usuarios_cubit.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  late UsuariosCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Usuarios')),
      body: BlocProvider(
        create: (context) => UsuariosCubit()..getAll(),
        child: BlocBuilder<UsuariosCubit, UsuariosState>(
          builder: (context, state) {
            cubit = context.read<UsuariosCubit>();

            Widget child = const Center(child: Text('No hay datos'));
            if (state.status == UsuarioEstatus.success) {
              child = ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: state.lsUsuarios.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GruposMenuPage(
                            idUsuario: state.lsUsuarios[index].id,
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: const FlutterLogo(),
                      title: Text(state.lsUsuarios[index].name),
                    ),
                  );
                },
              );
            } else if (state.status == UsuarioEstatus.loading) {
              child = const Center(child: CircularProgressIndicator());
            } else {
              child = const Center(child: Text('No hay datos'));
            }

            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  formNuevoUsuario(cubit: cubit),
                  Expanded(child: child),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          cubit.getAll();
        },
        child: const Icon(
          Icons.refresh,
          color: Colors.white,
        ),
      ),
    );
  }

  //controlador para el nombre del usuario
  final controllerNombre = TextEditingController();
  Widget formNuevoUsuario({required UsuariosCubit cubit}) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Nombre',
          ),
          controller: controllerNombre,
        ),
        ElevatedButton(
          onPressed: () {
            cubit.save(controllerNombre.text);
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
