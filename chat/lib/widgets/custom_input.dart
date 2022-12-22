import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({super.key,
    required this.icon, 
    required this.placeholder, 
    required this.textController, 
    required this.keyboardType, 
    this.isPassword = false,
  });

  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.height * 0.05, vertical: size.width * 0.025),
      padding: EdgeInsets.symmetric(horizontal: size.height * 0.012),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0,5),
            blurRadius: 5
          )
        ]
      ),
      child: TextField(
        autocorrect: false,
        keyboardType: keyboardType,
        controller: textController,
        obscureText: isPassword,
        decoration: InputDecoration(
          icon: Icon(icon),
          border: InputBorder.none,
          hintText: placeholder,
        ),
      )
    );
  }
}