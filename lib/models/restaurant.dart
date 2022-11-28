// To parse this JSON data, do
//
//     final restaurant = restaurantFromJson(jsonString);

import 'dart:convert';

List<Restaurant> restaurantFromJson(String str) =>
    List<Restaurant>.from(json.decode(str).map((x) => Restaurant.fromJson(x)));

String restaurantToJson(List<Restaurant> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Restaurant {
  Restaurant({
    this.id,
    this.nombre,
    this.direccion,
    this.telefono,
    this.email,
    this.imagen,
    this.descripcion,
    this.latitud,
    this.longitud,
    this.etiquetas,
    this.nCalificaciones,
    this.promedio,
    this.totalPuntos,
    this.comentarios,
    this.calificaciones,
    this.v,
  });

  String? id;
  String? nombre;
  String? direccion;
  String? telefono;
  String? email;
  String? imagen;
  String? descripcion;
  double? latitud;
  double? longitud;
  List<String>? etiquetas;
  int? nCalificaciones;
  int? promedio;
  int? totalPuntos;
  List<Comentario>? comentarios;
  List<dynamic>? calificaciones;
  int? v;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["_id"],
        nombre: json["nombre"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        email: json["email"],
        imagen: json["imagen"],
        descripcion: json["descripcion"],
        latitud: json["latitud"].toDouble(),
        longitud: json["longitud"].toDouble(),
        etiquetas: List<String>.from(json["etiquetas"].map((x) => x)),
        nCalificaciones: json["N_calificaciones"],
        promedio: json["promedio"],
        totalPuntos: json["total_puntos"],
        comentarios: List<Comentario>.from(
            json["comentarios"].map((x) => Comentario.fromJson(x))),
        calificaciones:
            List<dynamic>.from(json["calificaciones"].map((x) => x)),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
        "direccion": direccion,
        "telefono": telefono,
        "email": email,
        "imagen": imagen,
        "descripcion": descripcion,
        "latitud": latitud,
        "longitud": longitud,
        "etiquetas": List<dynamic>.from(etiquetas!.map((x) => x)),
        "N_calificaciones": nCalificaciones,
        "promedio": promedio,
        "total_puntos": totalPuntos,
        "comentarios": List<dynamic>.from(comentarios!.map((x) => x.toJson())),
        "calificaciones": List<dynamic>.from(calificaciones!.map((x) => x)),
        "__v": v,
      };
}

class Comentario {
  Comentario({
    this.idUsuario,
    this.contenido,
    this.idRestaurante,
    this.id,
  });

  String? idUsuario;
  String? contenido;
  String? idRestaurante;
  String? id;

  factory Comentario.fromJson(Map<String, dynamic> json) => Comentario(
        idUsuario: json["idUsuario"],
        contenido: json["contenido"],
        idRestaurante: json["idRestaurante"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "idUsuario": idUsuario,
        "contenido": contenido,
        "idRestaurante": idRestaurante,
        "_id": id,
      };
}
