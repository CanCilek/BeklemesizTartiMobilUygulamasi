class Kilo {
  String kilo;
  String hayvanId;
  String zaman;
  String trend;
  String trendUstSinir;
  String trendAltSinir;

  Kilo(
      {this.kilo,
      this.hayvanId,
      this.zaman,
      this.trend,
      this.trendUstSinir,
      this.trendAltSinir});


  Kilo.chart({this.kilo,this.zaman});
  Kilo.chartv2({this.trend,this.zaman});
  Kilo.chartv3({this.trendUstSinir,this.zaman});
  Kilo.chartv4({this.trendAltSinir,this.zaman});

  Kilo.fromJson(Map<String, dynamic> json) {
    kilo = json['kilo'];
    hayvanId = json['hayvanId'];
    zaman = json['zaman'];
    trend = json['trend'];
    trendUstSinir = json['trendUstSinir'];
    trendAltSinir = json['trendAltSinir'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kilo'] = this.kilo;
    data['hayvanId'] = this.hayvanId;
    data['zaman'] = this.zaman;
    data['trend'] = this.trend;
    data['trendUstSinir'] = this.trendUstSinir;
    data['trendAltSinir'] = this.trendAltSinir;
    return data;
  }
}
