


import 'dart:developer';

import 'package:chat/global/environment.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/models/usuarios_response.dart';
import 'package:chat/services/auth_service.dart';
import 'package:dio/dio.dart';

class UsuariosService {

  Future<List<Usuario?>?> getUsuarios() async{
    
    final dio = Dio();

    try {

      final resp = await dio.get('${Environment.apiUrl}/usuarios',
      options: Options(
        headers: {
          'x-token': await AuthService.getToken(),
        }
      ));

      final usuariosResponse = UsuariosResponse.fromJson(resp.data);

      return usuariosResponse.usuarios;
    }on DioError catch (e) {
      log(e.message);
    }

  }



}