class Adim {
  String adimSayisi;
  String hayvanId;
  String zaman;
  String trend;
  String trendUstSinir;
  String trendAltSinir;

  Adim(
      {this.adimSayisi,
      this.hayvanId,
      this.zaman,
      this.trend,
      this.trendUstSinir,
      this.trendAltSinir});
  Adim.chart({this.adimSayisi, this.zaman});
  Adim.chartv2({this.trend, this.zaman});
  Adim.chartv3({this.trendUstSinir, this.zaman});
  Adim.chartv4({this.trendAltSinir, this.zaman});

  Adim.fromJson(Map<String, dynamic> json) {
    adimSayisi = json['adimSayisi'];
    hayvanId = json['hayvanId'];
    zaman = json['zaman'];
    trend = json['trend'];
    trendUstSinir = json['trendUstSinir'];
    trendAltSinir = json['trendAltSinir'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adimSayisi'] = this.adimSayisi;
    data['hayvanId'] = this.hayvanId;
    data['zaman'] = this.zaman;
    data['trend'] = this.trend;
    data['trendUstSinir'] = this.trendUstSinir;
    data['trendAltSinir'] = this.trendAltSinir;
    return data;
  }
}
