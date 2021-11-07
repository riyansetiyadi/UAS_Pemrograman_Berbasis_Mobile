import 'package:sqflite/sqflite.dart';
import 'dart:async';
//mendukug pemrograman asinkron
import 'dart:io';
//bekerja pada file dan directory
import 'package:path_provider/path_provider.dart';
import 'package:nuansa/models/user_model.dart';
import 'package:nuansa/models/wisata_model.dart';
//pubspec.yml

//kelass Dbhelper
class DbHelper {
  static DbHelper? _dbHelper;
  static Database? _database;  

  DbHelper._createObject();

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper!;
  }

  static const tableUser = '''
      CREATE TABLE user (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT,
        email TEXT,
        kataSandi TEXT
      )
    ''';

    static const tableWisata = '''
      CREATE TABLE wisata (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        foto TEXT,
        nama TEXT,
        kota TEXT,
        negara TEXT,
        deskripsi TEXT
      )
    ''';

  Future<Database> initDb() async {

  //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'nuansa.db';

    // await deleteDatabase(path);

   //create, read databases
    var todoDatabase = openDatabase(
      path, 
      version: 1, 
      onCreate: (Database db, int version) async {
        await db.execute(tableUser);
        await db.execute(tableWisata);
      }
    );

    //mengembalikan nilai object sebagai hasil dari fungsinya
    return todoDatabase;
  }


  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
      simpanDataWisata();
    }
    return _database!;
  }

  // Future<List<Map<String, dynamic>>> select() async {
  //   Database db = await this.database;
  //   var mapList = await db.query('user', orderBy: 'name');
  //   return mapList;
  // }

  void simpanDataWisata() {
    var _dataWisata = [
      WisataModel(null, "assets/images/papuma.jpg", "Papuma", "Jember", "Indonesia", "deskripsi"),
      WisataModel(null, "assets/images/papuma.jpg", "Papuma", "Jember", "Indonesia", "deskripsi"),
      WisataModel(null, "assets/images/papuma.jpg", "Papuma", "Jember", "Indonesia", "deskripsi"),
      WisataModel(null, "assets/images/papuma.jpg", "Papuma", "Jember", "Indonesia", "deskripsi"),
      WisataModel(null, "assets/images/papuma.jpg", "Papuma", "Jember", "Indonesia", "deskripsi"),
      WisataModel(null, "assets/images/papuma.jpg", "Papuma", "Jember", "Indonesia", "deskripsi"),
      WisataModel(null, "assets/images/papuma.jpg", "Papuma", "Jember", "Indonesia", "deskripsi"),
      WisataModel(null, "assets/images/papuma.jpg", "Papuma", "Jember", "Indonesia", "deskripsi"),
      WisataModel(null, "assets/images/papuma.jpg", "Papuma", "Jember", "Indonesia", "deskripsi"),
      WisataModel(null, "assets/images/papuma.jpg", "Papuma", "Jember", "Indonesia", "deskripsi"),
      WisataModel(null, "assets/images/papuma.jpg", "Papuma", "Jember", "Indonesia", "deskripsi"),
    ];

    for (final e in _dataWisata) {
      insertWisata(e);
    }
  }

//create databases
  Future<int> insertUser(UserModel object) async {
    Database db = await this.database;
    int count = await db.insert('user', object.toMap());
    return count;
  }
  Future<int> insertWisata(WisataModel object) async {
    Database db = await this.database;
    int count = await db.insert('wisata', object.toMap());
    return count;
  }
//update databases
  Future<int> updateUser(UserModel object) async {
    Database db = await this.database;
    int count = await db.update('user', object.toMap(), 
                                where: 'id=?',
                                whereArgs: [object.id]);
    return count;
  }

  Future<List<UserModel>> getUserByEmail(String email) async {
    Database db = await this.database;
    var mapList = await db.query('user', where: 'email=?', whereArgs: [email]);
    int count = mapList.length;
    List<UserModel> userList = <UserModel>[];
    for (int i=0; i<count; i++) {
      userList.add(UserModel.fromMap(mapList[i]));
    }
    return userList;
  }

// //delete databases
//   Future<int> delete(int id) async {
//     Database db = await this.database;
//     int count = await db.delete('contact', 
//                                 where: 'id=?', 
//                                 whereArgs: [id]);
//     return count;
//   }

  Future<List<WisataModel>> getWisataList() async {
    Database db = await this.database;
    var mapList = await db.query('wisata');
    int count = mapList.length;
    List<WisataModel> wisataList = <WisataModel>[];
    if (count != 0) {
      for (int i=0; i<count; i++) {
        wisataList.add(WisataModel.fromMap(mapList[i]));
      }
    }
    return wisataList;
  }

}