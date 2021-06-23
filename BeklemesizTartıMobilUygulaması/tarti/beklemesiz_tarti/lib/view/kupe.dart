import 'dart:convert';
import 'dart:io';
import 'package:beklemesiz_tarti/model/veriler_model/kupe.dart';
import 'package:http/http.dart' as http;

class GetKupe {
  List<Kupe> kupe = List<Kupe>();
  Future getKupe(var responder) async {
    final response = await http
        .get("http://tarti.ekont.com/tasmakuperesp_json.php?id=" + responder);

    switch (response.statusCode) {
      case HttpStatus.ok:
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = map["veriler"];
        for (var noteJson in data) {
          kupe.add(Kupe.fromJson(noteJson));
        }
        return kupe;
        break;
      default:
        throw Exception(response.body);
    }
  }
}
