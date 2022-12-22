import 'package:flutter/material.dart';


class Logo extends StatelessWidget {
  const Logo({super.key, required this.titulo});

  final String titulo; 

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        width: size.width * 0.45,
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children:[
            const Image(image: AssetImage('assets/message.png')),
            Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),)
          ],
        ),
      ),
    );
  }
}