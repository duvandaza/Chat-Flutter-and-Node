
import 'package:chat/global/environment.dart';
import 'package:chat/models/mensajes_response.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ChatService with ChangeNotifier {

  final dio = Dio();
  late Usuario usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioID) async {

    final resp = await dio.get('${Environment.apiUrl}/mensajes/$usuarioID',
      options: Options(
        headers: {
          'x-token' : await AuthService.getToken()
        }
      )
    );

    final mensajesResp = MensajesResponse.fromJson(resp.data);

    return mensajesResp.mensajes;  

  }
  

}