import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_test/modules/Menu/cubit/menu_cubit.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key, required this.idGrupoMenu});

  final int idGrupoMenu;

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late MenuCubit _cubit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: BlocProvider(
        create: (context) => MenuCubit()..init(idGrupoMenu: widget.idGrupoMenu),
        child: BlocBuilder<MenuCubit, MenuState>(
          builder: (context, state) {
            _cubit = context.read<MenuCubit>();
            Widget childWidget = const Center(child: Text('No hay datos'),);
            if (state.status == MenuStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status == MenuStatus.success) {
              childWidget = ListView.separated(itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    
                  },
                  child: ListTile(leading: const FlutterLogo(), title: Text(state.lsMenusGrupos[index].name,),),
                );
              }, separatorBuilder: (context, index) => const Divider(), itemCount: state.lsMenusGrupos.length,);
            } else {
              childWidget = const Center(child: Text('No hay datos'),);
            }
            return Padding(padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text('Usuario ${state.grupoMenu!.name}', style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),),
                    formNewGroup(),
                    Expanded(child: childWidget),


              ],
            ),);
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
            _cubit.insert(menuUsuario: controllerNombre.text, context: context);
            controllerNombre.clear();
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}

