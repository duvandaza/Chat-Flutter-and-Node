import 'package:flutter/material.dart';

class ButtonBlue extends StatelessWidget {
  const ButtonBlue({super.key, required this.label, required this.onPressed});

  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.8,
      height: size.height * 0.06,
      margin: EdgeInsets.only(top: size.height * 0.02),
      child: MaterialButton(
        color: Colors.blue,
        disabledColor: Colors.grey,
        elevation: 2,
        highlightElevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: onPressed,
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),),
      ),
    );
  }
}