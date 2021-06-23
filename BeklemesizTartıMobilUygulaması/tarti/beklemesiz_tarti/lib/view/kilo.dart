import 'dart:convert';
import 'dart:io';
import 'package:beklemesiz_tarti/model/Istatistik_model/kilo.dart';
import 'package:beklemesiz_tarti/model/veriler_model/kilo.dart';
import 'package:http/http.dart' as http;

class GetKilo {
  List<Kilo> kilo = List<Kilo>();
  Future getKilo(var responder) async {
    final response = await http
        .get("http://tarti.ekont.com/detay_json.php/veriler?id=9840007" + responder);

    switch (response.statusCode) {
      case HttpStatus.ok:
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = map["veriler"];
        for (var noteJson in data) {
          kilo.add(Kilo.fromJson(noteJson));
        }
        return kilo;
        break;
      default:
        throw Exception(response.body);
    }
  }
}

class GetKiloIst {
  List<KiloIst> kiloIst = List<KiloIst>();
  Future getKiloIst(var responder) async {
    final response = await http.get(
        "http://tarti.ekont.com/detay_json.php/istatistik?id=9840007" +
            responder);

    switch (response.statusCode) {
      case HttpStatus.ok:
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = map["istatistik"];
        for (var noteJson in data) {
          kiloIst.add(KiloIst.fromJson(noteJson));
        }
        return kiloIst;
        break;
      default:
        throw Exception(response.body);
    }
  }
}
