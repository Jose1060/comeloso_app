import 'dart:convert';
import 'dart:ffi';

import 'package:comeloso_app/models/restaurant.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Restaurant>?> getRestaurants() async {
    var client = http.Client();
    var uri = Uri.parse(
        "https://restaurantes-production.up.railway.app/GetAllrestaurants");
    print(uri);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return restaurantFromJson(json);
    }
    return null;
  }

  Future<List<Restaurant>?> getRestaurantsCerca(
      {required double lat,
      required double long,
      required List etiquetas}) async {
    final queryParameters = {
      "latitud": lat.toString(),
      "longitud": long.toString(),
      "etiquetas": etiquetas
    };

    print(queryParameters);

    var client = http.Client();
    var uriCerca = Uri.https("restaurantes-production.up.railway.app",
        "/restaurantescerca", queryParameters);
    print("🧔 ----> $uriCerca");
    var response = await client.get(uriCerca);
    if (response.statusCode == 200) {
      var json = response.body;
      print("🐵  ----> " + restaurantFromJson(json).toString());
      return restaurantFromJson(json);
    } else if (response.statusCode == 400 || response.statusCode == 400) {
      print("Error");
    }
    return null;
  }
}
