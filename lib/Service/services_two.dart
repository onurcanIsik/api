import 'dart:convert';

import 'package:gun_haberleri/Model/model_two.dart';
import 'package:http/http.dart' as http;

class VeriCevap2 {
  Future getEvent2() async {
    var endpoint = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=tr&apiKey=31f1535a0ca04a77b9294f4256ceaf1a");
    var response = await http.get(endpoint);

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      Iterable list = body["articles"];
      List<Articles> data =
          list.map((todo) => Articles.fromJson(todo)).toList();
      return data;
    } else {
      throw Exception("Failed to load data");
    }
  }
}
