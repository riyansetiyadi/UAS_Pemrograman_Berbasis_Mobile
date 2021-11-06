class WisataModel{
  int? _id;
  String _foto = "";
  String _nama = "";
  String _kota = "";
  String _negara = "";
  String _deskripsi = "";

  WisataModel(this._id, this._foto, this._nama, this._kota, this._negara, this._deskripsi);

  WisataModel.fromMap(Map<String, dynamic> map){
    this._id=map['id'];
    this._foto=map['foto'];
    this._nama=map['nama'] ?? "";
    this._kota=map['kota'] ?? "";
    this._negara=map['negara'] ?? "";
    this._deskripsi=map['deskripsi'] ?? "";
  }
  int? get id => _id;
  String get foto => _foto;
  String get nama => _nama;
  String get kota => _kota;
  String get negara => _negara;
  String get deskripsi => _deskripsi;

  set foto(String value){
    _foto=value;
  }
  set nama(String value){
    _nama=value;
  }
  set kota(String value) {
    _kota = value;
  }
  set negara(String value) {
    _negara = value;
  }
  set deskripsi(String value) {
    _deskripsi = value;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['foto'] = foto;
    map['nama'] = nama;
    map['kota'] = kota;
    map['negara'] = negara;
    map['deskripsi'] = deskripsi;
    return map;
  } 
}