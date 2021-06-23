class AdimIst {
  String enDusuk;
  String enYuksek;
  String ortalama;
  String stdSapma;
  String varyans;
  String skor;
  String guvenEndeksi;

  AdimIst(
      {this.enDusuk,
      this.enYuksek,
      this.ortalama,
      this.stdSapma,
      this.varyans,
      this.skor,
      this.guvenEndeksi});

  AdimIst.fromJson(Map<String, dynamic> json) {
    enDusuk = json['enDusuk'];
    enYuksek = json['enYuksek'];
    ortalama = json['ortalama'];
    stdSapma = json['stdSapma'];
    varyans = json['varyans'];
    skor = json['skor'];
    guvenEndeksi = json['guvenEndeksi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enDusuk'] = this.enDusuk;
    data['enYuksek'] = this.enYuksek;
    data['ortalama'] = this.ortalama;
    data['stdSapma'] = this.stdSapma;
    data['varyans'] = this.varyans;
    data['skor'] = this.skor;
    data['guvenEndeksi'] = this.guvenEndeksi;
    return data;
  }
}
