import 'dart:convert';
import 'dart:io';

import 'package:beklemesiz_tarti/model/Istatistik_model/adim.dart';
import 'package:beklemesiz_tarti/model/veriler_model/adim.dart';
import 'package:http/http.dart' as http;

class GetAdim {
  List<Adim> kilo = List<Adim>();
  Future getAdim(var responder) async {
    final response = await http.get(
        "http://tarti.ekont.com/adimdetay_json.php?id=9840007" + responder);

    switch (response.statusCode) {
      case HttpStatus.ok:
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = map["veriler"];
        for (var noteJson in data) {
          kilo.add(Adim.fromJson(noteJson));
        }
        return kilo;
        break;
      default:
        throw Exception(response.body);
    }
  }
}

class GetAdimIst {
  List<AdimIst> adimIst = List<AdimIst>();
  Future getAdimIst(var responder) async {
    final response = await http.get(
        "http://tarti.ekont.com/adimdetay_json.php?id=9840007" + responder);

    switch (response.statusCode) {
      case HttpStatus.ok:
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = map["istatistik"];
        for (var noteJson in data) {
          adimIst.add(AdimIst.fromJson(noteJson));
        }
        return adimIst;
        break;
      default:
        throw Exception(response.body);
    }
  }
}
