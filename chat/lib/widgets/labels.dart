import 'package:flutter/material.dart';


class Labels extends StatelessWidget {
  const Labels({super.key, required this.ruta, required this.subTitulo, required this.titulo});

  final String ruta;
  final String subTitulo;
  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(subTitulo, style: TextStyle(color: Colors.grey[600], fontSize: 14),),
        const SizedBox(height: 10,),
        InkWell(
          onTap: () {
            Navigator.pushReplacementNamed(context, ruta);
          },
          child: Text(titulo, style: TextStyle(color: Colors.blue[600], fontSize: 18, fontWeight: FontWeight.bold),)
        )
      ],
    );
  }
}