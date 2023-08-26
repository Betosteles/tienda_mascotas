import 'dart:convert';

List<Usuario> productoFromJson(String str) =>
    List<Usuario>.from(json.decode(str).map((x) => Usuario.fromJson(x)));

String productoToJson(List<Usuario> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Usuario {
  String correo;
  String nombreCompleto;
  String identidad;
  String telefono;
  String direccion;
  String referencia;
  String tipoUsuario;

  Usuario({
    required this.correo,
    required this.nombreCompleto,
    required this.identidad,
    required this.telefono,
    required this.direccion,
    required this.referencia,
    required this.tipoUsuario,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        correo: json["correo"],
        nombreCompleto: json["nombreCompleto"],
        identidad: json["identidad"],
        telefono: json["telefono"],
        direccion: json["direccion"],
        referencia: json["referencia"],
        tipoUsuario: json["tipoUsuario"],
      );

  Map<String, dynamic> toJson() => {
        "correo": correo,
        "nombreCompleto": nombreCompleto,
        "identidad": identidad,
        "telefono": telefono,
        "direccion": direccion,
        "referencia": referencia,
        "tipoUsuario": tipoUsuario,
      };
}
