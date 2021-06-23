class Sut {
  String sut1;
  String sut2;
  String hayvanId;
  String zaman;
  String trend;
  String trendUstSinir;
  String trendAltSinir;

  Sut(
      {this.sut1,
      this.sut2,
      this.hayvanId,
      this.zaman,
      this.trend,
      this.trendUstSinir,
      this.trendAltSinir});
  Sut.chart({this.sut1, this.zaman});
  Sut.chartv1({this.sut2, this.zaman});
  Sut.chartv2({this.trend, this.zaman});
  Sut.chartv3({this.trendUstSinir, this.zaman});
  Sut.chartv4({this.trendAltSinir, this.zaman});

  Sut.fromJson(Map<String, dynamic> json) {
    sut1 = json['sut1'];
    sut2 = json['sut2'];
    hayvanId = json['hayvanId'];
    zaman = json['zaman'];
    trend = json['trend'];
    trendUstSinir = json['trendUstSinir'];
    trendAltSinir = json['trendAltSinir'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sut1'] = this.sut1;
    data['sut2'] = this.sut2;
    data['hayvanId'] = this.hayvanId;
    data['zaman'] = this.zaman;
    data['trend'] = this.trend;
    data['trendUstSinir'] = this.trendUstSinir;
    data['trendAltSinir'] = this.trendAltSinir;
    return data;
  }
}
