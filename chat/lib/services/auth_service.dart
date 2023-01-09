import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat/global/environment.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/models/login_response.dart';

class AuthService with ChangeNotifier {

  final dio = Dio();
  late Usuario usuario;

  bool _autenticando = false;

  final _storage = const FlutterSecureStorage();

  bool get autenticando => _autenticando;
  set autenticando(bool valor){
    _autenticando = valor;
    notifyListeners();
  }

  // Getters del token de forma estatica

  static Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }


  Future<bool> login(String email, String password) async {

    autenticando = true;

    try {
      
      final resp = await dio.post('${Environment.apiUrl}/login',
        data: {
          'email': email,
          'password': password
        },
      );
      final loginResponse = LoginResponse.fromJson(resp.data);
      autenticando = false;
      usuario = loginResponse.usuario;

      await _guardarToken(loginResponse.token);

      return true;

    } on DioError catch (e) {
      autenticando = false;
      return false;
    }
  }

  Future register(String nombre, String email, String password) async {
    
    autenticando = true;

    try {
      
      final res = await dio.post('${Environment.apiUrl}/login/new',
        data: {
          'email'   : email,
          'nombre'  : nombre,
          'password': password
        },
      );

      final registerResponse = LoginResponse.fromJson(res.data);
      autenticando = false;
      usuario = registerResponse.usuario;

      await _guardarToken(registerResponse.token);

      return true;

    } on DioError catch (e) {
      autenticando = false;
      return e.response!.data['msg'];
    }

  }

  Future<bool> isLoggedIn() async {

    final token = await _storage.read(key: 'token');

    try {
      
      final res = await dio.get('${Environment.apiUrl}/login/renew',
        options: Options(
          headers: {
            'x-token': token
          }
        )
      );

      final loginResponse = LoginResponse.fromJson(res.data);
      usuario = loginResponse.usuario;

      await _guardarToken(loginResponse.token);

      return true;

    } catch(e) {
      logout();
      return false;
    }
    
  }


  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout () async{
    await _storage.delete(key: 'token');
  }

  
}