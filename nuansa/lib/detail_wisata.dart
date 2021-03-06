import 'package:flutter/material.dart';
import 'package:nuansa/controller/weather_service.dart';
import 'package:nuansa/db/database.dart';
import 'package:nuansa/map_wisata.dart';
import 'package:nuansa/models/user_model.dart';
import 'models/wisata_model.dart';

class DetailWisata extends StatefulWidget {
  const DetailWisata({Key? key}) : super(key: key);

  @override
  _DetailWisataState createState() => _DetailWisataState();
}

class _DetailWisataState extends State<DetailWisata> {
  WisataModel _wisata = WisataModel("", "error.png", "error", "error", "error", "error", "error", 0, "error", 0, 0);
  UserModel _userData = UserModel("", "error.png", "error", "error", "error", []);
  DatabaseManager database = DatabaseManager();
  
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    if (args.containsKey('wisata')) {
      _wisata = args['wisata'];
    }
    if (args.containsKey('user')) {
      _userData = args['user'];
    }
    if (_userData.wisataFavorite.contains(_wisata.id)) {
      favorite = true;
    }
    

    // final listDesc = <Widget>[];
    // String textDesc = "";
    // for (var i in _wisata['deskripsi'].toString().split(" ")) {
    //   textDesc = textDesc + i + " ";
    //   if (textDesc.length > 400 && textDesc.contains('.')) {
    //     listDesc.add(Text(textDesc));
    //     textDesc = "";
    //   }
    // }
    return (
      Scaffold(
        // appBar: AppBar(
        //   toolbarHeight: kToolbarHeight,
        //   backgroundColor: Colors.transparent,
        //   foregroundColor: Colors.transparent,
        // ),
        bottomNavigationBar: Container(
          height: 60,
          color: Colors.green,
          child: InkWell(
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MapWisata(),
                  settings: RouteSettings(
                    arguments: {
                      'wisata': _wisata,
                    },
                  ),
                ),
              );
            },
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.map,
                    color: Colors.white,
                  ),
                  Text(
                    ' Kunjungi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25
                    ),
                  ),
                ],
              ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            
            children: [
              Stack(
                children: [
                  Image.asset(
                    _wisata.foto,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 30,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      }, 
                      icon: Icon(Icons.arrow_back),
                      color: Colors.white,
                      iconSize: 40,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      child: Container(
                        color: Color(0xff3D56B2),
                        height: 20,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 30,
                    child: ClipOval(
                      child: Container(
                        width: 60,
                        height: 60,
                        color: Color(0xff3D56B2),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              favorite = !favorite;
                              if (favorite) {
                                if (!_userData.wisataFavorite.contains(_wisata.id)); {
                                  _userData.wisataFavorite.add(_wisata.id);
                                  database.updateUser(_userData);
                                  _wisata.jumlahFavorite += 1;
                                  database.updateWisata(_wisata);
                                }
                              } else {
                                if (_userData.wisataFavorite.remove(_wisata.id)) {
                                  database.updateUser(_userData);
                                  _wisata.jumlahFavorite -= 1;
                                  database.updateWisata(_wisata);
                                }
                              }
                            });
                          },
                          icon: Icon(Icons.favorite),
                          color: favorite ? Colors.red : Colors.grey,
                          iconSize: 35,
                        ),
                      ),
                    )
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            _wisata.nama.toUpperCase(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        // Flexible(
                        //   child: Text(
                        //     " (100 Km)",
                        //     style: TextStyle(
                        //       fontSize: 16,
                        //           fontWeight: FontWeight.normal,
                        //           color: Colors.white54
                        //     ),
                        //   ),
                        // ),
                        Row(
                          children: [
                            Icon(
                              Icons.star_rate,
                              color: Colors.yellow,
                              size: 23,
                            ),
                            Text(
                              "5.0",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Text(
                      "${_wisata.desa}, ${_wisata.kecamatan}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Deskripsi",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      _wisata.deskripsi,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    cuacaWisata(context),
                  ],
                ),
              ),
              
            ],
          ),
        )
      )
    );
  }

  FutureBuilder cuacaWisata(BuildContext context) {
    DateTime now = new DateTime.now();
    return FutureBuilder(
      future: getCuacaWisata(_wisata.latitude, _wisata.longitude),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
                    children: [
                      Text(
                        "Cuaca ${_wisata.nama}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        "Hari ini, ${now.day} ${now.month} ${now.year}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Center(
                        child: Image.network(
                          "http://openweathermap.org/img/wn/${snapshot.data.icon}@4x.png",
                          width: MediaQuery.of(context).size.width * 0.8,
                        ),
                      ),
                      Text(
                        snapshot.data.description.toString().toUpperCase(),
                        style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "Angin",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${(snapshot.data.windSpeed * 3.6).toStringAsFixed(1)} km/j",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                          ),
                          Text(
                            "|",
                            style: TextStyle(
                              fontSize: 75,
                              color: Colors.white30
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "Suhu",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${(snapshot.data.temp - 273.15).toStringAsFixed(0)}\u2103",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                          ),
                          Text(
                            "|",
                            style: TextStyle(
                              fontSize: 75,
                              color: Colors.white30
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "Kelembapan",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${snapshot.data.humidity}%",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 260,
                      ),
                    ],
                  );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}