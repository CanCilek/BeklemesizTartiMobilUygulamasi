import 'dart:convert';
import 'package:beklemesiz_tarti/model/veriler_model/kupe.dart';
import 'package:http/http.dart' as http;
import 'package:beklemesiz_tarti/model/veriler_model/tasma.dart';
import 'package:beklemesiz_tarti/view/detay.dart';
import 'package:flutter/material.dart';

class AnaSayfaView extends StatefulWidget {
  AnaSayfaView({Key key}) : super(key: key);

  @override
  _AnaSayfaViewState createState() => _AnaSayfaViewState();
}

class _AnaSayfaViewState extends State<AnaSayfaView> {
  TextEditingController _responderNo;

  List<Tasma> tasma = List<Tasma>();
  List<Kupe> kupe = List<Kupe>();

  Future<List<Tasma>> getTasma(var tasma) async {
    var url = "http://tarti.ekont.com/tasmakuperesp_json.php?id=" + tasma;

    var response = await http.get(url);

    var notes = List<Tasma>();

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> data = map["veriler"];
      for (var noteJson in data) {
        notes.add(Tasma.fromJson(noteJson));
      }
    }
    return notes;
  }

  Future<List<Kupe>> getKupe(var kupe) async {
    var url = "http://tarti.ekont.com/tasmakuperesp_json.php?id=" + kupe;

    var response = await http.get(url);

    var notes = List<Kupe>();

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> data = map["veriler"];
      for (var noteJson in data) {
        notes.add(Kupe.fromJson(noteJson));
      }
    }
    return notes;
  }

  @override
  void initState() {
    _responderNo = TextEditingController();
    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.red,
              title: Center(
                child: Text(
                  "Akıllı Kilo Takip Sistemi",
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/cow_amud3.png"),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Responder, Tasma Numarası veya Küpe Numarası Giriniz",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Container(
                      color: Colors.red,
                      height: 60,
                      width: 330,
                      child: Card(
                        elevation: 5,
                        child: TextField(
                          cursorColor: Colors.red,
                          controller: _responderNo,
                          decoration: InputDecoration(
                            labelText: "Responder",
                            labelStyle: TextStyle(color: Colors.red),
                            focusedBorder: new UnderlineInputBorder(
                                borderSide: new BorderSide(color: Colors.red)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: 320,
                      child: RaisedButton(
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.red,
                        onPressed: () async {
                          await getTasma(_responderNo.text).then((value) {
                            setState(() {
                              tasma.addAll(value);
                            });
                          });
                          await getKupe(_responderNo.text).then((value) {
                            setState(() {
                              kupe.addAll(value);
                            });
                          });
                          getIndex(_responderNo.text.length.compareTo(0));
                        },
                        child: Text(
                          "GİT",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }

  getIndex(var uzunluk) async {
    if (uzunluk <= 3) {
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetayView(
                  responder: tasma[0].resp,
                  kupe: tasma[0].kupe,
                  tasma: tasma[0].tasma)));
    } else if (uzunluk == 8) {
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetayView(
                  responder: _responderNo.text,
                  kupe: tasma[0].kupe,
                  tasma: tasma[0].tasma)));
    } else if (uzunluk >= 14) {
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetayView(
                  responder: kupe[0].resp,
                  kupe: kupe[0].kupe,
                  tasma: kupe[0].tasma)));
    }
  }
}
