class UserModel{
  int? _id = 0;
  String _nama = "";
  String _email = "";
  String _kataSandi = "";

  UserModel(this._id, this._nama, this._email, this._kataSandi);

  UserModel.fromMap(Map<String, dynamic> map){
    this._id=map['id'];
    this._nama=map['nama'];
    this._email=map['email'];
    this._kataSandi=map['kataSandi'];
  }
  int? get id => _id;
  String get nama => _nama;
  String get email => _email;
  String get kataSandi => _kataSandi;

  set nama(String value){
    _nama=value;
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
    map['nama'] = nama;
    map['email'] = email;
    map['kataSandi'] = kataSandi;
    return map;
  } 
}