class UserModel{
  String _id = "";
  String _foto = "";
  String _nama = "";
  String _email = "";
  String _kataSandi = "";
  List _wisataFavorite = [];

  UserModel(this._id, this._foto, this._nama, this._email, this._kataSandi, this._wisataFavorite);

  UserModel.fromMap(Map<String, dynamic> map){
    this._id=map['id'];
    this._foto=map['foto'];
    this._nama=map['nama'];
    this._email=map['email'];
    this._kataSandi=map['kataSandi'];
    this._wisataFavorite=map['wisataFavorite'];
  }
  String get id => _id;
  String get foto => _foto;
  String get nama => _nama;
  String get email => _email;
  String get kataSandi => _kataSandi;
  List get wisataFavorite => _wisataFavorite;

  set nama(String value){
    _nama=value;
  }
  set foto(String value){
    _foto=value;
  }
  set email(String value) {
    _email = value;
  }
  set kataSandi(String value) {
    _kataSandi = value;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['foto'] = foto;
    map['nama'] = nama;
    map['email'] = email;
    map['kataSandi'] = kataSandi;
    map['wisataFavorite'] = wisataFavorite;
    return map;
  } 
}