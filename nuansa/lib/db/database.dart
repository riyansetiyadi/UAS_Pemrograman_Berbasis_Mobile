import 'package:sqflite/sqflite.dart';
import 'dart:async';
//mendukug pemrograman asinkron
import 'dart:io';
//bekerja pada file dan directory
import 'package:path_provider/path_provider.dart';
import 'package:nuansa/models/user_model.dart';
import 'package:nuansa/models/wisata_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//pubspec.yml

class DatabaseManager {
  CollectionReference? wisata;
  initialise() {
    wisata = FirebaseFirestore.instance.collection('list_wisata');
  }
  
  Future<List> getWisataList() async {
    List wisataList = [];
    
    try {
      var coll = await FirebaseFirestore.instance.collection('list_wisata').get();
      coll.docs.forEach((item) {
        wisataList.add(WisataModel(item.id, item.data()['foto'], item.data()['nama'], item.data()['desa'], item.data()['kecamatan'], item.data()['jamOperasional'], item.data()['hargaTiket'], item.data()['deskripsi']));
      });
      return wisataList;
    } catch (e) {
      print(e);
      return wisataList;
    }
  }

  Future<List> getUserList() async {
    List userList = [];
    
    try {
      var coll = await FirebaseFirestore.instance.collection('list_user').get();
      coll.docs.forEach((item) {
        userList.add(UserModel(item.id, item.data()['foto'], item.data()['nama'], item.data()['email'], item.data()['password'], item.data()['wisataFavorite']));
      });
      return userList;
    } catch (e) {
      print(e);
      // print('get user list');
      return userList;
    }
  }

  // List? konversiFutureList(Future<List> data) {
  //   try {
  //     int count;
  //     data.then((item) {
  //       count = item.length;
  //       if (count != 0) {
  //         return item;
  //       }
  //       return [];
  //     });
  //   } catch (e) {
  //     print(e);
  //     return [];
  //   }
  // }

  // Future<bool?> emailAuthentication(String email) async {
  //   try {       
  //     getUserList().then((value) {
  //       for (var user in value) {
  //         if (user.email == email) {
  //           return true;
  //         }
  //       }
  //       return false;
  //     });
      
  //   } catch (e) {
  //     print('email autentikasi');
  //     return null;
  //   }
  // }

  UserModel signUp(String email, String password) {
    Map<String, dynamic> userMap = {
          'nama' : email,
          'email' : email,
          'password' : password,
          'foto' : 'default.png',
          'wisataFavorite' : [],
        };
    UserModel userModel = UserModel("", "error.png", "error", "error", "error", []);
    try {
      getUserList().then((value) {
        value.forEach((element) {
          if (element.email == email) {
            userModel = element;
          }
        });
      });
      var collUser = FirebaseFirestore.instance.collection('list_user');
      collUser.add(userMap);
      return userModel;
    } catch (e) {
      print('sign up');
      return userModel;
    }
  }

  Future<List> getUserFavorite(List userFavorite) async {
    List<WisataModel> listFavorite = [];
    await getWisataList().then((value) {
      for (var item in value) {
        if (userFavorite.contains(item.id)) {
          listFavorite.add(item);
        }
      }
    });
    print(listFavorite);
    return listFavorite;
  }
}

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
        desa TEXT,
        kecamatan TEXT,
        jamOperasional TEXT,
        hargaTiket TEXT,
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
      // simpanDataWisata();
    }
    return _database!;
  }

  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.database;
    var mapList = await db.query('user', orderBy: 'name');
    return mapList;
  }

  // void simpanDataWisata() {
  //   var _dataWisata = [
  //     WisataModel(null, "assets/images/papuma.jpg", "Pantai Papuma", "Lojejer", "Wuluhan", "24 jam", "Rp17.000", "Daya tarik pantainya adalah batu-batu karangnya yang berada di perairan, berpadu dengan birunya laut dan deburan ombak yang menghantamnya. Dari pusat kota, ambil arah menuju Kecamatan Wuluhan. Setibanya di perempatan Ambulu, ambil arah lurus dan ikuti jalan. Di sisi kanan nanti, ada sebuah gapura dengan tulisan Tanjung Papuma. Berbeloklah dan ikuti saja jalan berbatu yang diapit sawah dan hutan jati."),
  //     WisataModel(null, "assets/images/papuma.jpg", "Pantai Watu Ulo", "Sumberejo", "Ambulu", "24 jam", "Rp5.000 (parkir)", "Dalam bahasa Jawa, watu ulo berarti batu ular. Ini dikarenakan adanya susunan batu panjang yang memanjang dan menjorok ke pantai dengan bentuk menyerupai tubuh ular. Menurut mitos, batu-batu tersebut merupakan bagian dari penghuni pantai selatan pada masa lalu yang berwujud ular raksasa. Namun, terlepas benar atau tidaknya mitos tersebut, pantai ini memang menarik untung dikunjungi."),
  //     WisataModel(null, "assets/images/papuma.jpg", "Pantai Payangan", "Sumberejo", "Ambulu", "24 jam", "Rp5.000 (parkir)", "Tidak jauh dari Pantai Watu Ulo, Anda bisa melanjutkan perjalanan ke pantai lain yang tidak kalah menawan. Bahkan harus diakui, Pantai Payangan memang cukup instagrammable. Pasalnya, pantai ini dikelilingi oleh bukit-bukit hijau yang sangat memanjakan mata. Tidak jarang, pengunjung sengaja datang pada jam-jam khusus untuk menikmati momen matahari terbit dan tenggelam yang memesona di pantai ini. Dari arah Ambulu, terus saja menuju ke bagian selatan. Ikuti saja rute menuju Pantai Watu Ulo. Tidak terlalu jauh dari sana, Anda akan sampai di lokasi."),
  //     WisataModel(null, "assets/images/papuma.jpg", "Pantai Puger", "Puger", "Puger", "07.00-17.00", "Rp10.000", "Selain terkenal dengan hasil tangkapan lautnya, Puger juga memiliki pantai yang cantik. Namun, perlu diperhatikan, ombak Pantai Puger cukup tinggi, sehingga Anda perlu berhati-hati dan jangan terlalu terlena dengan keindahannya. Di pagi hari, kapal-kapal nelayan tampak di kejauhan tengah dalam perjalanan kembali ke darat. Sebaliknya, ketika langit mulai menggelap, kapal-kapal tersebut akan melawan gelombang dan bergerak ke tengah laut. Untuk rute menuju Pantai Puger, dari arah alun-alun kecamatan, Anda belok ke kanan. Setelah jembatan, berbeloklah ke arah kiri mengikuti papan penunjuk dan terus mengikuti jalan."),
  //     WisataModel(null, "assets/images/papuma.jpg", "Pantai Paseban", "Paseban", "Kencong", "07.00-23.00", "Rp10.000 (parkir)", "Pantai ini memiliki garis pantai sepanjang 2 km. Konon, Pantai Paseban adalah lokasi kerajaan Nyi Roro Kidul ini berbatasan langsung dengan Samudera Hindia. Uniknya, meski berbatasan dengan Samudera Hindia, ombak Pantai Paseban justru cenderung tenang dan tidak ganas."),
  //     WisataModel(null, "assets/images/papuma.jpg", "Pantai Bandealit", "Andongrejo", "Tempurejo", "24 jam", "-", "Pantai Bandealit termasuk dalam kawasan Taman Nasional Meru Betiri. Kecantikannya memang sudah termasyhur, tetapi tidak lantas membuat pantai ini menjadi banyak dikunjungi orang. Sebabnya tidak lain adalah akses jalan yang masih belum bersahabat. Namun, jika Anda menyukai tantangan, datanglah ke pantai ini. Keeksotisannya akan membuat perjalanan panjang Anda tidak sia-sia. Apalagi jika Anda menyukai olahraga bodysurfing, pantai ini adalah tempat yang pas untuk menyalurkan kegemaran Anda yang satu itu. Jika berangkat dari arah Talangsari, Anda lurus saja ke arah Tempurejo hingga menemukan Desa Andongrejo. Ketika tiba di persimpangan, pilihlah jalan yang lurus menuju pantai sebab jika berbelok ke kiri, Anda justru akan pergi ke Teluk Meru."),
  //     WisataModel(null, "assets/images/papuma.jpg", "Pantai Nanggelan", "Curahnongko", "Tempurejo", "24 jam", "Rp10.000 (parkir)", "Bagi Anda yang menginginkan pantai yang sepi dan jauh dari hiruk-pikuk kota, Pantai Nanggelan bisa jadi destinasi yang patut Anda kunjungi saat berada di Jember. Namun, dengan catatan, Anda gemar bertualang. Setidaknya, perjalanan sekitar satu setengah jam dari pusat kota menaiki sepeda motor di jalan dengan infrastruktur yang buruk dan trekking di hutan bukan merupakan suatu kendala bagi Anda. Sebab untuk mencapai pantai perawan ini, Anda harus lebih dulu menerobos hutan. Namun, percayalah, eksotisme pantai ini akan membuat rasa lelah perjalanan Anda terbayar tuntas. Dari pintu masuk perkebunan Blater, Anda lurus saja sampai menemukan pertigaan pertama. Ambil belokan ke kiri melalui jembatan, lalu kembali belok ke kiri saat menemukan pertigaan lainnya dan terus sampai menemukan portal ketiga. Anda akan menemukan pertigaan sekali lagi dan kembali belok kiri lalu lurus hingga mencapai perkampungan. Di ujung perkampungan, masuklah menuju hutan jati. Sekitar 1 km kemudian, Anda akan mendapati persimpangan untuk parkir motor. Kembali masuk ke dalam hutan dan sekitar 100 meter di depan, belok ke kanan dan seberangi sungai kecil menuju hutan. Mulailah mendaki bukit."),
  //     WisataModel(null, "assets/images/papuma.jpg", "Pantai Rowo Cangak", "Sabrang", "Ambulu", "24 jam", "-", "Selain Pantai Nanggelan, ada pula Pantai Rowo Cangak yang juga masih perawan. Sarana dan fasilitas menuju dan di kawasan pantai sendiri pun sangat minim. Untuk sampai di pantai ini, Anda perlu menerobos hutan karet—dengan jalan yang sama sekali tidak bisa dibilang ramah. Setelah itu, Anda masih harus melalui sebuah jembatan kecil yang membelah dua sungai. Akan tetapi, panorama garis pantai yang bersih, suasana syahdu dengan deburan ombak dan semilir angin akan memanjakan Anda setiap detik saat berada di sini. Rutenya sama seperti ke Pantai Nanggelan. Namun, ketika di persimpangan penitipan motor, ambil saja jalan kecil yang lurus."),
  //     WisataModel(null, "assets/images/papuma.jpg", "Teluk Love", "Sumberejo", "Ambulu", "06.00-23.00", "Rp5.000 (tiket)", "Nama Teluk Love yang merupakan bagian dari Pantai Payangan ini diambil secara harfiah lantaran bentuk dari teluk yang berbentuk seperti simbol cinta berbentuk hati. Surga kecil ini bisa Anda capai dengan mendaki Bukit Domba selama sekitar 15 menit. Ketika mencapai bagian puncak bukit, Anda bisa dengan sempurna melihat bentuk teluk yang unik secara natural ini. Waktunya akan lebih tepat jika Anda datang pada pagi atau sore hari, bersama dengan terbit dan tenggelamnya matahari. Apabila Anda telah berada di lokasi Pantai Payangan, Anda cukup mendaki bukit hijaunya saja. Jalannya tidak terlalu bahaya—relatif aman bahkan untuk pemula."),
  //     WisataModel(null, "assets/images/papuma.jpg", "Pulau Nusa Barong", "Puger Kulon", "Puger", "24 jam", "Rp1.500.000 (menyewa kapal menyeberang untuk delapan orang)", "Pulau Nusa Barong merupakan titik terluar dari Kabupaten Jember. Secara administratif, pulau tak berpenghuni ini masih termasuk dalam Kecamatan Puger. Pulau ini merupakan cagar budaya yang dikendalikan langsung oleh pemerintah pusat. Ekosistem hutan di pulau ini adalah hutan hujan tropis dengan tiga formasi, yakni hutan bakau (mangrove), hutan pantai, dan hutan dataran rendah. Tentu sebagai cagar budaya, pulau ini juga menjadi habitat bagi beberapa flora dan fauna, seperti pandan laut, ketapang, lutung, rusa jawa, babi hutan, walet sapi, dan masih banyak lainnya. Anda bisa memilih melalui Pantai Getem atau Pantai Puger. Di sana ada kapal-kapal yang disewakan untuk mengantar Anda menyeberangi perairan menuju Nusa Barong."),
  //     WisataModel(null, "assets/images/papuma.jpg", "Pusat Penelitian Kopi dan Kakao", "Kaliwining", "Rambipuji", "Senin-Jumat pukul 07.00-16.00, Sabtu-Minggu pukul 07.00-14.00", "- (kecuali tur Rp25.000)", "Satu-satunya pusat penelitian kopi dan kakao di Indonesia hanya ada di Kabupaten Jember, Jawa Timur. Dari sini, biji kopi dan kakao terbaik dihasilkan. Selain diekspor, bibit-bibit terbaik juga dikirim ke berbagai wilayah di nusantara untuk terus dikembangkan. Karena itu, sayang jika Anda melewatkan tempat wisata di Jember yang edukatif ini. Anda bisa mengikuti tur berkeliling kebun kopi dan kakao, memasuki pabrik dan melihat proses pengolahan kakao, dan mendapat segelas kopi atau cokelat panas di outlet setelah tur selesai. Namun, tidak masalah jika Anda hanya ingin bersantai di outlet dan berbelanja beragam olahan kopi dan kakao. Untuk mengunjungi Puslit Koka, dari arah Surabaya, ketika mencapai perempatan Mangli, berbeloklah ke kanan—menuju arah Jenggawah. Sekitar tiga ratus meter sebelum alun-alun kecamatan, berbeloklah ke jalan kecil di sebelah kanan (ada plang penunjuk). Anda cukup mengikuti jalan utama beraspal sepanjang 5 km untuk mencapai tempat ini."),
  //   ];

  //   for (final e in _dataWisata) {
  //     var collUser = FirebaseFirestore.instance.collection('list_wisata');
  //     collUser.add({
  //       'nama' : e.nama,
  //       'desa' : e.desa,
  //       'kecamatan' : e.kecamatan,
  //       'foto' : e.foto,
  //       'jamOperasional' : e.jamOperasional,
  //       'hargaTiket' : e.hargaTiket,
  //       'deskripsi' : e.deskripsi
  //     });
  //     insertWisata(e);
  //   }
  // }

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