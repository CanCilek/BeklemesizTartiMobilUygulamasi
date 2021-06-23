import 'dart:convert';
import 'dart:io';
import 'package:beklemesiz_tarti/model/Istatistik_model/sut.dart';
import 'package:beklemesiz_tarti/model/veriler_model/sut.dart';
import 'package:http/http.dart' as http;

class GetSut {
  List<Sut> sut = List<Sut>();
  Future getSut(var responder) async {
    final response = await http
        .get("http://tarti.ekont.com/sutdetay_json.php?id=9840007" + responder);

    switch (response.statusCode) {
      case HttpStatus.ok:
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = map["veriler"];
        for (var noteJson in data) {
          sut.add(Sut.fromJson(noteJson));
        }
        return sut;
        break;
      default:
        throw Exception(response.body);
    }
  }
}

class GetSutIst {
  List<SutIst> sutIst = List<SutIst>();
  Future getSutIst(var responder) async {
    final response = await http.get(
        "http://tarti.ekont.com/sutdetay_json.php/istatistik?id=9840007" +
            responder);

    switch (response.statusCode) {
      case HttpStatus.ok:
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = map["istatistik"];
        for (var noteJson in data) {
          sutIst.add(SutIst.fromJson(noteJson));
        }
        return sutIst;
        break;
      default:
        throw Exception(response.body);
    }
  }
}
