import 'package:beklemesiz_tarti/model/Istatistik_model/adim.dart';
import 'package:beklemesiz_tarti/model/Istatistik_model/kilo.dart';
import 'package:beklemesiz_tarti/model/Istatistik_model/sut.dart';
import 'package:beklemesiz_tarti/model/veriler_model/adim.dart';
import 'package:beklemesiz_tarti/model/veriler_model/kilo.dart';
import 'package:beklemesiz_tarti/model/veriler_model/sut.dart';
import 'package:beklemesiz_tarti/view/kilo.dart';
import 'package:beklemesiz_tarti/view/sut.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'adim.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}

class DetayView extends StatefulWidget {
  final responder, tasma, kupe;
  DetayView({this.responder, this.kupe, this.tasma});

  @override
  DetayViewState createState() =>
      DetayViewState(responder: responder, kupe: kupe, tasma: tasma);
}

class DetayViewState extends State<DetayView> {
  var responder, tasma, kupe;
  DetayViewState({this.responder, this.kupe, this.tasma});

  List<Kilo> kilo = List<Kilo>();
  List<KiloIst> kiloIst = List<KiloIst>();
  List<Sut> sut = List<Sut>();
  List<SutIst> sutIst = List<SutIst>();
  List<Adim> adim = List<Adim>();
  List<AdimIst> adimIst = List<AdimIst>();
  List<String> split1 = new List<String>();

  String errorMessage = "";
  bool isLoading = false;
  var deneme;

  GetKilo jsonPlaseService;
  GetSut jsonPlaseService2;
  GetAdim jsonPlaseService3;
  GetKiloIst jsonPlaseServicev1;
  GetSutIst jsonPlaseServicev2;
  GetAdimIst jsonPlaseServicev3;

  @override
  void initState() {
    super.initState();
    jsonPlaseService = GetKilo();
    jsonPlaseService2 = GetSut();
    jsonPlaseService3 = GetAdim();
    jsonPlaseServicev1 = GetKiloIst();
    jsonPlaseServicev2 = GetSutIst();
    jsonPlaseServicev3 = GetAdimIst();
    getKilo(responder);
    getSut(responder);
    getAdim(responder);
    getKiloIst(responder);
    getSutIst(responder);
    getAdimIst(responder);
  }

  Future getKilo(var responder2) async {
    changeLoading();
    try {
      kilo = await jsonPlaseService.getKilo(responder2);
    } on Exception catch (e) {
      showErrorDialog(e.toString());
    }
    changeLoading();
  }

  Future getKiloIst(var responder) async {
    changeLoading();
    try {
      kiloIst = await jsonPlaseServicev1.getKiloIst(responder);
    } on Exception catch (e) {
      showErrorDialog(e.toString());
    }
    changeLoading();
  }

  Future getSut(var responder) async {
    changeLoading();
    try {
      sut = await jsonPlaseService2.getSut(responder);
    } on Exception catch (e) {
      showErrorDialog(e.toString());
    }
    changeLoading();
  }

  Future getSutIst(var responder) async {
    changeLoading();
    try {
      sutIst = await jsonPlaseServicev2.getSutIst(responder);
    } on Exception catch (e) {
      showErrorDialog(e.toString());
    }
    changeLoading();
  }

  Future getAdim(var responder) async {
    changeLoading();
    try {
      adim = await jsonPlaseService3.getAdim(responder);
    } on Exception catch (e) {
      showErrorDialog(e.toString());
    }
    changeLoading();
  }

  Future getAdimIst(var responder) async {
    changeLoading();
    try {
      adimIst = await jsonPlaseServicev3.getAdimIst(responder);
    } on Exception catch (e) {
      showErrorDialog(e.toString());
    }
    changeLoading();
  }

  void showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              child: Text(message),
            ));
  }

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: buildTitleAppBar(),
            bottom: TabBar(
              tabs: [
                Text("Kilo Bilgileri"),
                Text(
                  "Süt Bilgileri",
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Adım Bilgileri",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          //Text(split1[1]),
                          Text(
                            "Tasma Numarası : " + tasma,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Responder : " + responder,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Küpe Numarası : " + kupe,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          getGraphKilo(
                            kiloIst[0],
                          ),
                          getTableKiloIst(kiloIst[0]),
                          SizedBox(
                            height: 15,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: kilo.length,
                        itemBuilder: (context, index) =>
                            getCardKilo(kilo[index], kiloIst[0]),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              "Tasma Numarası : " + tasma,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Responder : " + responder,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Küpe Numarası : " + kupe,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            getGraphSut(sutIst[0]),
                            getTableSutIst(sutIst[0]),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: sut.length,
                        itemBuilder: (context, index) => getCardSut(sut[index]),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            "Tasma Numarası : " + tasma,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Responder : " + responder,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Küpe Numarası : " + kupe,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          getGraphAdim(adimIst[0]),
                          getTableAdimIst(adimIst[0]),
                          SizedBox(
                            height: 15,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: adim.length,
                        itemBuilder: (context, index) =>
                            getCardAdim(adim[index]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget getCardKilo(Kilo kilo, KiloIst kiloIst) {
    return Card(
      child: ListTile(
        leading: Container(
            width: 120,
            child: Text(
              "Tarih: " + kilo.zaman,
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        title: Text(
          "Kilo: " + kilo.kilo,
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        trailing: Container(
          width: 110,
          child: Image.asset(resimGetir(double.tryParse(kiloIst.skor))),
        ),
      ),
    );
  }

  Widget getCardSut(Sut sut) {
    return Card(
      child: ListTile(
        leading: Container(
            width: 120,
            child: Text(
              "Tarih: " + sut.zaman,
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        title: Text(
          "Sut: " + sut.sut1 + " Litre",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("Süt İletkenliği: " + sut.sut2),
        trailing: Container(width: 120, child: getGaugeSut(sut)),
      ),
    );
  }

// Image.asset("assets/sut1.png")
  getGaugeSut(Sut sut) {
    return Container(
      width: 120,
      height: 250,
      child: SfRadialGauge(
        backgroundColor: Colors.white,
        axes: <RadialAxis>[
          RadialAxis(
              startAngle: 180,
              endAngle: 0,
              showLabels: false,
              showAxisLine: false,
              showTicks: false,
              minimum: 0,
              maximum: 30,
              ranges: <GaugeRange>[
                GaugeRange(
                    startValue: 0,
                    endValue: 9,
                    color: Color(0xFFFE2A25),
                    label: 'Az',
                    sizeUnit: GaugeSizeUnit.factor,
                    labelStyle:
                        GaugeTextStyle(fontFamily: 'Times', fontSize: 10),
                    startWidth: 0.65,
                    endWidth: 0.65),
                GaugeRange(
                  startValue: 9,
                  endValue: 20,
                  color: Color(0xFFFFBA00),
                  label: 'Orta',
                  labelStyle: GaugeTextStyle(fontFamily: 'Times', fontSize: 10),
                  startWidth: 0.65,
                  endWidth: 0.65,
                  sizeUnit: GaugeSizeUnit.factor,
                ),
                GaugeRange(
                  startValue: 20,
                  endValue: 30,
                  color: Color(0xFF00AB47),
                  label: 'Çok',
                  labelStyle: GaugeTextStyle(fontFamily: 'Times', fontSize: 10),
                  sizeUnit: GaugeSizeUnit.factor,
                  startWidth: 0.65,
                  endWidth: 0.65,
                ),
              ],
              pointers: <GaugePointer>[
                NeedlePointer(
                    value: double.tryParse(sut.sut1),
                    needleLength: 0.3,
                    needleStartWidth: 2,
                    needleEndWidth: 2)
              ])
        ],
      ),
    );
  }

  Widget getCardAdim(Adim adim) {
    return Card(
      child: ListTile(
        leading: Container(
            width: 120,
            child: Text(
              "Tarih: " + adim.zaman,
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        title: Text(
          "Adım Sayısı: " + adim.adimSayisi,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Container(width: 110, child: getGaugeAdim(adim)),
      ),
    );
  }

  getGaugeAdim(Adim adim) {
    return Container(
      width: 120,
      height: 250,
      child: SfRadialGauge(
        backgroundColor: Colors.white,
        axes: <RadialAxis>[
          RadialAxis(
              startAngle: 180,
              endAngle: 0,
              showLabels: false,
              showAxisLine: false,
              showTicks: false,
              minimum: 0,
              maximum: 30,
              ranges: <GaugeRange>[
                GaugeRange(
                    startValue: 0,
                    endValue: 9,
                    color: Color(0xFFFE2A25),
                    label: 'Az',
                    sizeUnit: GaugeSizeUnit.factor,
                    labelStyle:
                        GaugeTextStyle(fontFamily: 'Times', fontSize: 10),
                    startWidth: 0.65,
                    endWidth: 0.65),
                GaugeRange(
                  startValue: 9,
                  endValue: 20,
                  color: Color(0xFFFFBA00),
                  label: 'Orta',
                  labelStyle: GaugeTextStyle(fontFamily: 'Times', fontSize: 10),
                  startWidth: 0.65,
                  endWidth: 0.65,
                  sizeUnit: GaugeSizeUnit.factor,
                ),
                GaugeRange(
                  startValue: 20,
                  endValue: 30,
                  color: Color(0xFF00AB47),
                  label: 'Çok',
                  labelStyle: GaugeTextStyle(fontFamily: 'Times', fontSize: 10),
                  sizeUnit: GaugeSizeUnit.factor,
                  startWidth: 0.65,
                  endWidth: 0.65,
                ),
              ],
              pointers: <GaugePointer>[
                NeedlePointer(
                    value: double.tryParse(adim.adimSayisi),
                    needleLength: 0.3,
                    needleStartWidth: 2,
                    needleEndWidth: 2)
              ])
        ],
      ),
    );
  }

  Widget buildTitleAppBar() {
    return isLoading
        ? CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        : Text(
            "Akıllı Kilo Takip Sistemi",
            style: TextStyle(color: Colors.black),
          );
  }

  Widget getTableKiloIst(KiloIst kiloIst) {
    return Table(
      border: TableBorder.all(width: 0),
      children: [
        TableRow(children: [
          Column(children: [
            Text("En Yüksek"),
          ]),
          Column(children: [
            Text("En Düşük"),
          ]),
          Column(children: [
            Text("Ortalama"),
          ]),
          Column(children: [
            Text("Standart Sapma"),
          ]),
          Column(children: [
            Text("Varyans"),
          ]),
        ]),
        TableRow(children: [
          Text(kiloIst.enYuksek, textAlign: TextAlign.center),
          Text(kiloIst.enDusuk, textAlign: TextAlign.center),
          Text(kiloIst.ortalama, textAlign: TextAlign.center),
          Text(kiloIst.stdSapma, textAlign: TextAlign.center),
          Text(kiloIst.varyans, textAlign: TextAlign.center),
        ]),
      ],
    );
  }

  Widget getTableSutIst(SutIst sutIst) {
    return Table(
      border: TableBorder.all(width: 0),
      children: [
        TableRow(children: [
          Column(children: [
            Text("En Yüksek"),
          ]),
          Column(children: [
            Text("En Düşük"),
          ]),
          Column(children: [
            Text("Ortalama"),
          ]),
          Column(children: [
            Text("Standart Sapma"),
          ]),
          Column(children: [
            Text("Varyans"),
          ]),
        ]),
        TableRow(children: [
          Text(sutIst.enYuksek, textAlign: TextAlign.center),
          Text(sutIst.enDusuk, textAlign: TextAlign.center),
          Text(sutIst.ortalama, textAlign: TextAlign.center),
          Text(sutIst.stdSapma, textAlign: TextAlign.center),
          Text(sutIst.varyans, textAlign: TextAlign.center),
        ]),
      ],
    );
  }

  Widget getTableAdimIst(AdimIst adimIst) {
    return Table(
      border: TableBorder.all(width: 0),
      children: [
        TableRow(children: [
          Column(children: [
            Text("En Yüksek"),
          ]),
          Column(children: [
            Text("En Düşük"),
          ]),
          Column(children: [
            Text("Ortalama"),
          ]),
          Column(children: [
            Text("Standart Sapma"),
          ]),
          Column(children: [
            Text("Varyans"),
          ]),
        ]),
        TableRow(children: [
          Text(adimIst.enYuksek, textAlign: TextAlign.center),
          Text(adimIst.enDusuk, textAlign: TextAlign.center),
          Text(adimIst.ortalama, textAlign: TextAlign.center),
          Text(adimIst.stdSapma, textAlign: TextAlign.center),
          Text(adimIst.varyans, textAlign: TextAlign.center),
        ]),
      ],
    );
  }

  Widget getGraphKilo(KiloIst kiloIst) {
    return SfCartesianChart(
        zoomPanBehavior: ZoomPanBehavior(
          enableDoubleTapZooming: true,
          enablePinching: true,
          zoomMode: ZoomMode.x,
          enablePanning: true,
        ),
        primaryYAxis: NumericAxis(
          interval: 50,
          minimum: double.tryParse(kiloIst.enDusuk) - 30,
          maximum: double.tryParse(kiloIst.enYuksek) + 100,
        ),
        primaryXAxis: CategoryAxis(),
        // Chart title
        title: ChartTitle(text: 'MAKÜ Çiftlik Beklemesiz tartı ölçüm verileri'),
        // Enable legend
        legend: Legend(isVisible: true, position: LegendPosition.bottom),
        // Enable tooltip
        tooltipBehavior: TooltipBehavior(
            enable: true,
            // format: '${tarihSplit()} = point.y'
            builder: (dynamic data, dynamic point, dynamic series,
                int pointIndex, int seriesIndex) {
              return Container(
                  child: Text(
                      '${kilo[pointIndex].zaman.split(" ")[0]} = ${kilo[pointIndex].kilo}'));
            }),
        series: <LineSeries<Kilo, num>>[
          LineSeries<Kilo, double>(
              color: Colors.blue,
              enableTooltip: true,
              animationDuration: 2500,
              dataSource: <Kilo>[
                for (var i = 0; i < kilo.length; i++)
                  Kilo.chart(kilo: kilo[i].kilo.toString(), zaman: i.toString())
              ],
              xValueMapper: (Kilo cow, _) => double.tryParse(cow.zaman),
              yValueMapper: (Kilo cow, _) => int.tryParse(cow.kilo),
              // Enable data label
              markerSettings: MarkerSettings(isVisible: false),
              name: "Kilo"),
          LineSeries<Kilo, double>(
              color: Colors.red,
              enableTooltip: true,
              animationDuration: 2500,
              dataSource: <Kilo>[
                for (var i = 0; i < kilo.length; i++)
                  Kilo.chartv2(
                      trend: kilo[i].trend.toString(), zaman: i.toString())
              ],
              xValueMapper: (Kilo cow, _) => double.tryParse(cow.zaman),
              yValueMapper: (Kilo cow, _) => double.tryParse(cow.trend),
              // Enable data label
              markerSettings: MarkerSettings(isVisible: false),
              name: "Trend"),
          LineSeries<Kilo, double>(
              color: Colors.orange,
              enableTooltip: true,
              animationDuration: 2500,
              dataSource: <Kilo>[
                for (var i = 0; i < kilo.length; i++)
                  Kilo.chartv4(
                      trendAltSinir: kilo[i].trendAltSinir.toString(),
                      zaman: i.toString())
              ],
              xValueMapper: (Kilo cow, _) => double.tryParse(cow.zaman),
              yValueMapper: (Kilo cow, _) => double.tryParse(cow.trendAltSinir),
              // Enable data label
              markerSettings: MarkerSettings(isVisible: false),
              name: "Alt Sınır"),
          LineSeries<Kilo, double>(
              color: Colors.green,
              enableTooltip: true,
              animationDuration: 2500,
              dataSource: <Kilo>[
                for (var i = 0; i < kilo.length; i++)
                  Kilo.chartv3(
                      trendUstSinir: kilo[i].trendUstSinir.toString(),
                      zaman: i.toString())
              ],
              xValueMapper: (Kilo cow, _) => double.tryParse(cow.zaman),
              yValueMapper: (Kilo cow, _) => double.tryParse(cow.trendUstSinir),
              // Enable data label
              markerSettings: MarkerSettings(isVisible: false),
              name: "Üst Sınır"),
        ]);
  }

  Widget getGraphSut(SutIst sutIst) {
    return SfCartesianChart(
        zoomPanBehavior: ZoomPanBehavior(
          enableDoubleTapZooming: true,
          enablePinching: true,
          zoomMode: ZoomMode.x,
          enablePanning: true,
        ),
        primaryYAxis: NumericAxis(
          interval: 5,
          minimum: double.tryParse(sutIst.enDusuk) - 10,
          maximum: double.tryParse(sutIst.enYuksek) + 15,
        ),
        primaryXAxis: CategoryAxis(),
        // Chart title
        title: ChartTitle(text: 'MAKÜ Çiftlik Süt ölçüm verileri'),
        // Enable legend
        legend: Legend(isVisible: true, position: LegendPosition.bottom),
        // Enable tooltip
        tooltipBehavior: TooltipBehavior(
            enable: true,
            builder: (dynamic data, dynamic point, dynamic series,
                int pointIndex, int seriesIndex) {
              return Container(
                  child: Text(
                      '${sut[pointIndex].zaman} = ${sut[pointIndex].sut1}'));
            }),
        series: <LineSeries<Sut, num>>[
          LineSeries<Sut, double>(
              color: Colors.blue,
              enableTooltip: true,
              animationDuration: 2500,
              dataSource: <Sut>[
                for (var i = 0; i < sut.length; i++)
                  Sut.chart(sut1: sut[i].sut1.toString(), zaman: i.toString())
              ],
              xValueMapper: (Sut cow1, _) => double.tryParse(cow1.zaman),
              yValueMapper: (Sut cow1, _) => int.tryParse(cow1.sut1),

              // Enable data label
              markerSettings: MarkerSettings(isVisible: false),
              name: "Süt LT"),
          LineSeries<Sut, double>(
              color: Colors.red,
              enableTooltip: true,
              animationDuration: 2500,
              dataSource: <Sut>[
                for (var i = 0; i < sut.length; i++)
                  Sut.chartv2(
                      trend: sut[i].trend.toString(), zaman: i.toString())
              ],
              xValueMapper: (Sut cow1, _) => double.tryParse(cow1.zaman),
              yValueMapper: (Sut cow1, _) => double.tryParse(cow1.trend),
              // Enable data label
              markerSettings: MarkerSettings(isVisible: false),
              name: "Trend"),
          LineSeries<Sut, double>(
              color: Colors.orange,
              enableTooltip: true,
              animationDuration: 2500,
              dataSource: <Sut>[
                for (var i = 0; i < sut.length; i++)
                  Sut.chartv4(
                      trendAltSinir: sut[i].trendAltSinir.toString(),
                      zaman: i.toString())
              ],
              xValueMapper: (Sut cow1, _) => double.tryParse(cow1.zaman),
              yValueMapper: (Sut cow1, _) =>
                  double.tryParse(cow1.trendAltSinir),
              // Enable data label
              markerSettings: MarkerSettings(isVisible: false),
              name: "Alt Sınır"),
          LineSeries<Sut, double>(
              color: Colors.green,
              enableTooltip: true,
              animationDuration: 2500,
              dataSource: <Sut>[
                for (var i = 0; i < sut.length; i++)
                  Sut.chartv3(
                      trendUstSinir: sut[i].trendUstSinir.toString(),
                      zaman: i.toString())
              ],
              xValueMapper: (Sut cow1, _) => double.tryParse(cow1.zaman),
              yValueMapper: (Sut cow1, _) =>
                  double.tryParse(cow1.trendUstSinir),
              // Enable data label
              markerSettings: MarkerSettings(isVisible: false),
              name: "Üst Sınır"),
        ]);
  }

  Widget getGraphAdim(AdimIst adimIst) {
    return SfCartesianChart(
        zoomPanBehavior: ZoomPanBehavior(
          enableDoubleTapZooming: true,
          enablePinching: true,
          zoomMode: ZoomMode.x,
          enablePanning: true,
        ),
        primaryYAxis: NumericAxis(
          interval: 30,
          minimum: double.tryParse(adimIst.enDusuk) - 35,
          maximum: double.tryParse(adimIst.enYuksek) + 50,
        ),
        primaryXAxis: CategoryAxis(),
        // Chart title
        title: ChartTitle(text: 'MAKÜ Çiftlikdeki Sığırların Adım Verileri'),
        // Enable legend
        legend: Legend(isVisible: true, position: LegendPosition.bottom),
        // Enable tooltip
        tooltipBehavior: TooltipBehavior(
            enable: true,
            builder: (dynamic data, dynamic point, dynamic series,
                int pointIndex, int seriesIndex) {
              return Container(
                  child: Text(
                      '${adim[pointIndex].zaman.split(" ")[0]} = ${adim[pointIndex].adimSayisi}'));
            }),
        series: <LineSeries<Adim, num>>[
          LineSeries<Adim, double>(
              color: Colors.blue,
              enableTooltip: true,
              animationDuration: 2500,
              dataSource: <Adim>[
                for (var i = 0; i < adim.length; i++)
                  Adim.chart(
                      adimSayisi: adim[i].adimSayisi.toString(),
                      zaman: i.toString())
              ],
              xValueMapper: (Adim cow1, _) => double.tryParse(cow1.zaman),
              yValueMapper: (Adim cow1, _) => int.tryParse(cow1.adimSayisi),
              // Enable data label
              markerSettings: MarkerSettings(isVisible: false),
              name: "Adim Sayısı"),
          LineSeries<Adim, double>(
              color: Colors.red,
              enableTooltip: true,
              animationDuration: 2500,
              dataSource: <Adim>[
                for (var i = 0; i < adim.length; i++)
                  Adim.chartv2(
                      trend: adim[i].trend.toString(), zaman: i.toString())
              ],
              xValueMapper: (Adim cow1, _) => double.tryParse(cow1.zaman),
              yValueMapper: (Adim cow1, _) => double.tryParse(cow1.trend),
              // Enable data label
              markerSettings: MarkerSettings(isVisible: false),
              name: "Trend"),
          LineSeries<Adim, double>(
              color: Colors.orange,
              enableTooltip: true,
              animationDuration: 2500,
              dataSource: <Adim>[
                for (var i = 0; i < adim.length; i++)
                  Adim.chartv4(
                      trendAltSinir: adim[i].trendAltSinir.toString(),
                      zaman: i.toString())
              ],
              xValueMapper: (Adim cow1, _) => double.tryParse(cow1.zaman),
              yValueMapper: (Adim cow1, _) =>
                  double.tryParse(cow1.trendAltSinir),
              // Enable data label
              markerSettings: MarkerSettings(isVisible: false),
              name: "Alt Sınır"),
          LineSeries<Adim, double>(
              color: Colors.green,
              enableTooltip: true,
              animationDuration: 2500,
              dataSource: <Adim>[
                for (var i = 0; i < adim.length; i++)
                  Adim.chartv3(
                      trendUstSinir: adim[i].trendUstSinir.toString(),
                      zaman: i.toString())
              ],
              xValueMapper: (Adim cow1, _) => double.tryParse(cow1.zaman),
              yValueMapper: (Adim cow1, _) =>
                  double.tryParse(cow1.trendUstSinir),
              // Enable data label
              markerSettings: MarkerSettings(isVisible: false),
              name: "Üst Sınır"),
        ]);
  }

  resimGetir(double skor) {
    skor = skor * -1;
    if (skor < 0) {
      String url = "assets/no-succ.fw.png";
      return url;
    } else {
      String url = "assets/succ.fw.png";
      return url;
    }
  }
}
