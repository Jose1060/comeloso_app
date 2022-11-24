import 'dart:ffi';

class UserOso {
  String nombre;
  String apellido;
  DateTime createdAt;
  String email;
  String genero;
  int numero;
  int pasos;
  List<String> preferencias;
  int puntos;
  List<String> restVisitados;
  List<String> restVisitadosFav;
  Bool terminos;
  Bool activo;

  UserOso({
    required this.nombre,
    required this.apellido,
    required this.createdAt,
    required this.email,
    required this.genero,
    required this.numero,
    required this.pasos,
    required this.restVisitados,
    required this.restVisitadosFav,
    required this.terminos,
    required this.activo,
    required this.preferencias,
    required this.puntos,
  });
}
