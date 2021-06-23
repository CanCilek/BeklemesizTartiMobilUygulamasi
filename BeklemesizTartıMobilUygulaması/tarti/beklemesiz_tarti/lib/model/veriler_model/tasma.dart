class Tasma {
  String tasma;
  String kupe;
  String resp;
  String responder;
  String sonuc;

  Tasma({this.tasma, this.kupe, this.resp, this.responder, this.sonuc});

  Tasma.fromJson(Map<String, dynamic> json) {
    tasma = json['tasma'];
    kupe = json['kupe'];
    resp = json['resp'];
    responder = json['responder'];
    sonuc = json['sonuc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tasma'] = this.tasma;
    data['kupe'] = this.kupe;
    data['resp'] = this.resp;
    data['responder'] = this.responder;
    data['sonuc'] = this.sonuc;
    return data;
  }
}
