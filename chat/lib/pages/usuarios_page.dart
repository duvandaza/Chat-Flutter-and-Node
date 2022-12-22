import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../models/usuario.dart';


class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(uid: '1', nombre: 'María', email: 'test1@test.com', online: true ),
    Usuario(uid: '2', nombre: 'Melissa', email: 'test2@test.com', online: false ),
    Usuario(uid: '3', nombre: 'Fernando', email: 'test3@test.com', online: true ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi nombre', style: TextStyle(color: Colors.black87),),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.rightFromBracket, color: Colors.black87, ),
          onPressed: () {},
        ),
        actions: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(right: 15),
              child: const FaIcon(FontAwesomeIcons.plugCircleExclamation, color: Colors.red,),
              // FaIcon(FontAwesomeIcons.plugCircleCheck, color: Colors.green,),
            ),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete: FaIcon(FontAwesomeIcons.check, color: Colors.blue[400],),
          waterDropColor: Colors.blue[400]!,
        ),
        child: _listViewUsuarios(),
      )
   );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: usuarios.length,
      separatorBuilder: (_, i) => const Divider(), 
      itemBuilder: (_, i) => _usuarioListTile(usuarios[i]),
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
        title: Text(usuario.nombre),
        leading: CircleAvatar(
          child: Text(usuario.nombre.substring(0,2)),
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: usuario.online ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      );
  }

  void _cargarUsuarios() async{
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }
}

