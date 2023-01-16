import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/services/auth_service.dart';
import '../services/socket_service.dart';


class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});


  @override
  Widget build(BuildContext context) {

    

    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return const Center(
            child: Text('Espere....'),
          );
        },
      )
   );

   
  }

  Future checkLoginState(BuildContext context) async {

    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);
    
    final autenticado = await authService.isLoggedIn();

    if(autenticado){
      socketService.connect();
      Navigator.pushReplacementNamed(context, 'usuarios');
    }else{
      Navigator.pushReplacementNamed(context, 'login');
    }

  }
}