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
    this.latitud,
    this.longitud,
    this.etiquetas,
    this.nCalificaciones,
    this.promedio,
    this.totalPuntos,
    this.comentarios,
    this.calificaciones,
    this.v,
    this.carta,
    this.descripcion,
  });

  String? id;
  String? nombre;
  String? direccion;
  String? telefono;
  String? email;
  String? imagen;
  double? latitud;
  double? longitud;
  List<String>? etiquetas;
  int? nCalificaciones;
  double? promedio;
  int? totalPuntos;
  List<Calificacione>? comentarios;
  List<Calificacione>? calificaciones;
  int? v;
  List<Carta>? carta;
  String? descripcion;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["_id"],
        nombre: json["nombre"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        email: json["email"],
        imagen: json["imagen"],
        latitud: json["latitud"].toDouble(),
        longitud: json["longitud"].toDouble(),
        etiquetas: List<String>.from(json["etiquetas"].map((x) => x)),
        nCalificaciones: json["N_calificaciones"],
        promedio: json["promedio"].toDouble(),
        totalPuntos: json["total_puntos"],
        comentarios: List<Calificacione>.from(
            json["comentarios"].map((x) => Calificacione.fromJson(x))),
        calificaciones: List<Calificacione>.from(
            json["calificaciones"].map((x) => Calificacione.fromJson(x))),
        v: json["__v"],
        carta: List<Carta>.from(json["carta"].map((x) => Carta.fromJson(x))),
        descripcion: json["descripcion"] == null ? null : json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
        "direccion": direccion,
        "telefono": telefono,
        "email": email,
        "imagen": imagen,
        "latitud": latitud,
        "longitud": longitud,
        "etiquetas": List<dynamic>.from(etiquetas!.map((x) => x)),
        "N_calificaciones": nCalificaciones,
        "promedio": promedio,
        "total_puntos": totalPuntos,
        "comentarios": List<dynamic>.from(comentarios!.map((x) => x.toJson())),
        "calificaciones":
            List<dynamic>.from(calificaciones!.map((x) => x.toJson())),
        "__v": v,
        "carta": List<dynamic>.from(carta!.map((x) => x.toJson())),
        "descripcion": descripcion == null ? null : descripcion,
      };
}

class Calificacione {
  Calificacione({
    this.idUsuario,
    this.calificacion,
    this.idRestaurante,
    this.id,
    this.contenido,
  });

  String? idUsuario;
  double? calificacion;
  String? idRestaurante;
  String? id;
  String? contenido;

  factory Calificacione.fromJson(Map<String, dynamic> json) => Calificacione(
        idUsuario: json["idUsuario"],
        calificacion: json["calificacion"] == null
            ? null
            : json["calificacion"].toDouble(),
        idRestaurante: json["idRestaurante"],
        id: json["_id"],
        contenido: json["contenido"] == null ? null : json["contenido"],
      );

  Map<String, dynamic> toJson() => {
        "idUsuario": idUsuario,
        "calificacion": calificacion == null ? null : calificacion,
        "idRestaurante": idRestaurante,
        "_id": id,
        "contenido": contenido == null ? null : contenido,
      };
}

class Carta {
  Carta({
    this.nombre,
    this.detalle,
    this.imagen,
    this.precio,
    this.ranking,
    this.id,
  });

  String? nombre;
  String? detalle;
  String? imagen;
  double? precio;
  double? ranking;
  String? id;

  factory Carta.fromJson(Map<String, dynamic> json) => Carta(
        nombre: json["nombre"],
        detalle: json["detalle"],
        imagen: json["imagen"],
        precio: json["precio"].toDouble(),
        ranking: json["ranking"].toDouble(),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "detalle": detalle,
        "imagen": imagen,
        "precio": precio,
        "ranking": ranking,
        "_id": id,
      };
}
