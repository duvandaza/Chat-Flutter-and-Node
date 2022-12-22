import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                const Logo(titulo: 'Messenger',),
                _Form(),
                const Labels(ruta: 'register', subTitulo: '¿No tienes cuenta?', titulo: 'Crea una ahora!',),
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

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
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
          label: 'Ingresar',
          onPressed: (){},
        ),
      ],
    );
  }
}


