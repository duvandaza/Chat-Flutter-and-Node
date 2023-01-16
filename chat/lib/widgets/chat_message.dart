import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {
  
  final String texto;
  final String uid;

  const ChatMessage({super.key, required this.texto, required this.uid});

  @override
  Widget build(BuildContext context) {

    final authservice = Provider.of<AuthService>(context, listen: false);

    return Container(
      child: uid == authservice.usuario.uid
      ? _myMessage()
      : _notMyMessage(),
    );
  }


  Widget _myMessage(){
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0xFF4D9EF6),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(texto, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
      ),
    );
  }

  Widget _notMyMessage(){
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0xFFE4E5E8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(texto, style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),),
      ),
    );
  }

}