import 'dart:io';

import 'package:chat/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  bool _isWriting = false;

  List<ChatMessage> _messages = [
    ChatMessage(texto: 'Hola Mundo', uid: '12343'),
    ChatMessage(texto: 'Hola Mundo', uid: '123'),
    ChatMessage(texto: 'Hola Mundo', uid: '12324'),
    ChatMessage(texto: 'Hola Mundo', uid: '123'),
    ChatMessage(texto: 'Hola Mundo', uid: '12321'),
  ];

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Column(
          children: [
            const SizedBox(height: 6,),
            CircleAvatar(
              child: Text('Te', style: TextStyle(fontSize: 14),),
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
            ),
            const SizedBox(height: 4,),
            Text('Melissa Florez', style: TextStyle(color: Colors.black87, fontSize: 15),),
            const SizedBox(height: 6,),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _messages.length,
                reverse: true,
                itemBuilder: ( _, i ) => _messages[i], 
              ) 
            ),
            const Divider(height: 1,),
            Container(
              color: Colors.white,
              child: _inputChat()
            )
          ],
        ),
      )
   );
  }

  Widget _inputChat() {
    return SafeArea(
      child:  Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmint,
                onChanged: (value){
                  setState(() {
                    value.trim().isNotEmpty ? _isWriting = true : _isWriting = false;
                  });
                },
                focusNode: _focusNode,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Enviar mensaje'
                ),
              ) 
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Platform.isIOS 
              ? CupertinoButton(
                onPressed: _isWriting 
                  ? () => _handleSubmint(_textController.text)
                  : null,
                child: const Text('Enviar'),
              )
              : IconTheme(
                data: IconThemeData(color: Colors.blue[400]),
                child: IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: const FaIcon(FontAwesomeIcons.solidPaperPlane),
                  onPressed: _isWriting 
                    ? () => _handleSubmint(_textController.text)
                    : null,
                ),
              )
            )
          ],
        ),
      )
    );
  }

  _handleSubmint(String texto){

    if(texto.isEmpty) return; 

    print(texto);
    _textController.clear();
    _focusNode.requestFocus();

    _messages.insert(0, ChatMessage(texto: texto, uid: '123'));

    setState(() {
      _isWriting = false;
    });
  }
}