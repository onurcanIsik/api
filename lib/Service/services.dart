import 'dart:convert';

import 'package:gun_haberleri/Model/model.dart';
import 'package:http/http.dart' as http;

class VeriCevap {
  Future getEvent() async {
    var endpoint = Uri.parse("https://api.ubilisim.com/tarihtebugun/");
    var response = await http.get(endpoint);

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      Iterable list = body["tarihtebugun"];
      List<Tarihtebugun> data =
          list.map((todo) => Tarihtebugun.fromJson(todo)).toList();
      return data;
    } else {
      throw Exception("Failed to load data");
    }
  }
}




