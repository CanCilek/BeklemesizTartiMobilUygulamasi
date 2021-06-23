import 'dart:convert';
import 'dart:io';
import 'package:beklemesiz_tarti/model/veriler_model/tasma.dart';
import 'package:http/http.dart' as http;

class GetTasma {
  List<Tasma> tasma = List<Tasma>();
  Future getTasma(var responder) async {
    final response = await http
        .get("http://tarti.ekont.com/tasmakuperesp_json.php?id=2");

    switch (response.statusCode) {
      case HttpStatus.ok:
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = map["veriler"];
        for (var noteJson in data) {
          tasma.add(Tasma.fromJson(noteJson));
        }
        return tasma;
        break;
      default:
        throw Exception(response.body);
    }
  }
}
