import 'dart:convert';
import 'dart:ffi';

import 'package:comeloso_app/models/restaurant.dart';
import 'package:http/http.dart' as http;

final String GlobalURL = "restaurantes-1-restaurantes-pr-2.up.railway.app";

class RemoteService {
  Future<List<Restaurant>?> getRestaurants() async {
    var client = http.Client();
    var uri = Uri.parse("https://$GlobalURL/GetAllrestaurants");
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
    var uriCerca =
        Uri.https("$GlobalURL", "/restaurantescerca", queryParameters);
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

  Future<List<Restaurant>?> getRestaurantsCercaPOST(
      {required double lat,
      required double long,
      required List etiquetas}) async {
    final body = {
      "latitud": lat.toString(),
      "longitud": long.toString(),
      "etiquetas": etiquetas
    };

    print(body);
    final jsonString = json.encode(body);

    var client = http.Client();
    var uriCerca = Uri.https("$GlobalURL", "/restaurantescerca");
    print("🧔 ----> $uriCerca");
    var response = await client.post(uriCerca, body: jsonString);
    print("🐼 ----> ${response.statusCode}");
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
