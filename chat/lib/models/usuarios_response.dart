
import 'dart:convert';
import 'package:chat/models/usuario.dart';

UsuariosResponse? usuariosResponseFromJson(String str) => UsuariosResponse.fromJson(json.decode(str));

String usuariosResponseToJson(UsuariosResponse? data) => json.encode(data!.toJson());

class UsuariosResponse {
    UsuariosResponse({
        required this.ok,
        required this.usuarios,
        required this.desde,
    });

    bool? ok;
    List<Usuario?>? usuarios;
    int? desde;

    factory UsuariosResponse.fromJson(Map<String, dynamic> json) => UsuariosResponse(
        ok: json["ok"],
        usuarios: json["usuarios"] == null ? [] : List<Usuario?>.from(json["usuarios"]!.map((x) => Usuario.fromJson(x))),
        desde: json["desde"],
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuarios": usuarios == null ? [] : List<dynamic>.from(usuarios!.map((x) => x!.toJson())),
        "desde": desde,
    };
}
