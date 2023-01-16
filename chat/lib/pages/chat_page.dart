import 'dart:io';

import 'package:chat/models/mensajes_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:chat/services/auth_service.dart';
import 'package:chat/services/chat_service.dart';
import 'package:chat/services/socket_service.dart';

import 'package:chat/widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  late ChatService chatService;
  late SocketService socketService;
  late AuthService authService;

  bool _isWriting = false;

  List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);

    socketService.socket.on('mensaje-personal', _escucharMensaje);

    _cargarHistorial( chatService.usuarioPara.uid! );
  }

  void _cargarHistorial( String usuarioID) async {

    List<Mensaje> chat = await chatService.getChat(usuarioID);

    final history = chat.map((m) => ChatMessage(texto: m.mensaje, uid: m.de));

    setState(() {
      _messages.insertAll(0, history);
    });
  }

  void _escucharMensaje(dynamic payload){

    ChatMessage message = ChatMessage(
      texto: payload['mensaje'],
      uid: payload['de'],
    );

    setState(() {
      _messages.insert(0, message);
    });
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final usuarioPara = chatService.usuarioPara;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Column(
          children: [
            const SizedBox(height: 6,),
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
              child: Text(usuarioPara.nombre.substring(0,2), style: const TextStyle(fontSize: 14),),
            ),
            const SizedBox(height: 4,),
            Text(usuarioPara.nombre, style: const TextStyle(color: Colors.black87, fontSize: 15),),
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

    _messages.insert(0, ChatMessage(texto: texto, uid: authService.usuario.uid!));

    setState(() {
      _isWriting = false;
    });

    socketService.emit('mensaje-personal', {
      'de': authService.usuario.uid,
      'para': chatService.usuarioPara.uid,
      'mensaje': texto
    });
  }

  @override
  void dispose() {
    socketService.socket.off('mesanje-personal', _escucharMensaje);
    super.dispose();
  }
}