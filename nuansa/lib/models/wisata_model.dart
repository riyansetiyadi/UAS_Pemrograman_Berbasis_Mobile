class WisataModel{
  String _id = "";
  String _foto = "";
  String _nama = "";
  String _desa = "";
  String _kecamatan = "";
  String _jamOperasional = "";
  String _hargaTiket = "";
  int _jumlahFavorite = 0;
  String _deskripsi = "";
  double _latitude = 0;
  double _longitude = 0;
  

  WisataModel(this._id, this._foto, this._nama, this._desa, this._kecamatan, this._jamOperasional, this._hargaTiket, this._jumlahFavorite, this._deskripsi, this._latitude, this._longitude);

  WisataModel.fromMap(Map<String, dynamic> map){
    this._id=map['id'];
    this._foto=map['foto'] ?? "";
    this._nama=map['nama'] ?? "";
    this._desa=map['desa'] ?? "";
    this._kecamatan=map['kecamatan'] ?? "";
    this._jamOperasional=map['jamOperasional'] ?? "";
    this._hargaTiket=map['hargaTiket'] ?? "";
    this._jumlahFavorite=map['jumlahFavorite'] ?? 0;
    this._deskripsi=map['deskripsi'] ?? "";
    this._latitude=map['latitude'] ?? 0;
    this._longitude=map['longitude'] ?? 0;
  }
  String get id => _id;
  String get foto => _foto;
  String get nama => _nama;
  String get desa => _desa;
  String get kecamatan => _kecamatan;
  String get jamOperasional => _jamOperasional;
  String get hargaTiket => _hargaTiket;
  int get jumlahFavorite => _jumlahFavorite;
  String get deskripsi => _deskripsi;
  double get latitude => _latitude;
  double get longitude => _longitude;

  set foto(String value){
    _foto=value;
  }
  set nama(String value){
    _nama=value;
  }
  set desa(String value) {
    _desa = value;
  }
  set kecamatan(String value) {
    _kecamatan = value;
  }
  set jamOperasional(String value) {
    _jamOperasional = value;
  }
  set hargaTiket(String value) {
    _hargaTiket = value;
  }
  set jumlahFavorite(int value) {
    _jumlahFavorite = value;
  }
  set deskripsi(String value) {
    _deskripsi = value;
  }
  set latitude(double value) {
    _latitude = value;
  }
  set longitude(double value) {
    _longitude = value;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['foto'] = foto;
    map['nama'] = nama;
    map['desa'] = desa;
    map['kecamatan'] = kecamatan;
    map['jamOperasional'] = jamOperasional;
    map['hargaTiket'] = hargaTiket;
    map['jumlahFavorite'] = jumlahFavorite;
    map['deskripsi'] = deskripsi;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    return map;
  } 
}