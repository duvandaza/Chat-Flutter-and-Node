import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import '../services/socket_service.dart';

import '../services/auth_service.dart';
import '../widgets/widgets.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: SizedBox(
            height: size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Logo(titulo: 'Registro'),
                _Form(),
                const Labels(ruta: 'login', subTitulo: '¿Ya tienes cuenta?', titulo: 'Ingresa ahora!',),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: const Text('Términos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w200),)
                ),
              ],
            ),
          ),
        ),
      )
   );
  }
}


class _Form extends StatefulWidget {

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Column(
      children: [
        CustomInput(
          icon: Icons.person_outline,
          keyboardType: TextInputType.name,
          placeholder: 'Nombre',
          textController: nameCtrl,
        ),
        CustomInput(
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          placeholder: 'Email',
          textController: emailCtrl,
        ),
        CustomInput(
          icon: Icons.lock_outline,
          keyboardType: TextInputType.text,
          placeholder: 'Contraseña',
          textController: passwordCtrl,
          isPassword: true,
        ),
        ButtonBlue(
          label: 'Crear cuenta',
          onPressed: authService.autenticando ? null : () async{
            
            FocusScope.of(context).unfocus();
            final registerOk = await authService.register(nameCtrl.text.trim(), emailCtrl.text.trim(), passwordCtrl.text.trim());
            if(registerOk == true){
              socketService.connect();
              Navigator.pushReplacementNamed( context, 'usuarios');
            }else{
              QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'error',
                text: registerOk.toString()
              );
            }
          },
        ),
      ],
    );
  }
}




