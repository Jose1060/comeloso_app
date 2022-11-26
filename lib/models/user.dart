import 'package:cloud_firestore/cloud_firestore.dart';

class UserOso {
  String? nombre;
  DateTime? createdAt;
  String? email;
  String? genero;
  int? numero;
  int? pasos;
  List<String>? preferencias;
  int? puntos;
  List<String>? restVisitados;
  List<String>? restVisitadosFav;
  bool? terminos;
  bool? activo;
  String? fotoAvatar;

  UserOso({
    this.nombre,
    this.createdAt,
    this.email,
    this.genero,
    this.numero,
    this.pasos,
    this.restVisitados,
    this.restVisitadosFav,
    this.terminos,
    this.activo,
    this.preferencias,
    this.puntos,
    this.fotoAvatar,
  });

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'email': email,
      'genero': genero,
      'numero': numero,
      'pasos': pasos,
      'createdAt': Timestamp.now(),
      'restVisitados': restVisitados,
      'restVisitadosFav': restVisitadosFav,
      'terminos': terminos,
      'activo': activo,
      'preferencias': preferencias,
      'puntos': puntos,
      'fotoAvatar': fotoAvatar,
    };
  }

  Map<String, dynamic> toMapPull() {
    return {
      'nombre': nombre,
      'email': email,
      'fotoAvatar': fotoAvatar,
    };
  }

  UserOso.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : nombre = doc.data()!["nombre"],
        email = doc.data()!["email"],
        genero = doc.data()!["genero"],
        numero = doc.data()!['numero'],
        pasos = doc.data()!["pasos"],
        createdAt = doc.data()!["createdAt"].toDate(),
        restVisitados = doc.data()!["restVisitados"],
        restVisitadosFav = doc.data()!["restVisitadosFav"],
        terminos = doc.data()!["terminos"],
        activo = doc.data()!["activo"],
        preferencias = doc.data()!["preferencias"],
        puntos = doc.data()!["puntos"],
        fotoAvatar = doc.data()!["fotoAvatar"];
}
