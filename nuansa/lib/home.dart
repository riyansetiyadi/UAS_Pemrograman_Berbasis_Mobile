import 'package:flutter/material.dart';
import 'package:nuansa/detail_wisata.dart';
import 'package:nuansa/models/user_model.dart';
import 'models/wisata_model.dart';
import 'db/database.dart';

class HomeScreen extends StatefulWidget {
  final UserModel userData;
  const HomeScreen({Key? key, required this.userData}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseManager database = DatabaseManager();

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Image.asset(
                  "assets/images/home_bg.jpg",
                  fit: BoxFit.cover,
                ),
                FractionallySizedBox(
                  widthFactor: 0.75,
                  child: Material(
                    borderRadius: BorderRadius.circular(25.0),
                    elevation: 10.0,
                    shadowColor: Colors.blue,
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            width: 0, 
                            style: BorderStyle.none,
                          ),
                        ),
                        prefixIcon: Icon(Icons.search),
                        hintText: "Kemana?",
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                )
              ],
            ),
            _listWisataScroller(context, "Destinasi Terdekat", database.getWisataList()),
            _listWisataScroller(context, "Destinasi Terpopuler", database.getWisataList(sortKolom: 'jumlahFavorite', descending: true)),
          ],
        ),
    );
  }

  Widget _listWisataScroller(BuildContext context, String titlePage, Future<List> dataWisata) {
    return FutureBuilder(
      future: dataWisata,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: [
                FractionallySizedBox(
                  widthFactor: 1,
                  child: Text(
                    titlePage,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      height: 2,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    alignment: Alignment.topCenter,
                    child: Row(
                      children: [for (var wisata in (snapshot.data as List)) InkWell(
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DetailWisata(),
                                settings: RouteSettings(
                                  arguments: {
                                    'wisata': wisata,
                                    'user': widget.userData,
                                  },
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 200,
                            margin: EdgeInsets.only(right: 20),
                            height: 200,
                            child: Stack(
                              alignment: AlignmentDirectional.bottomStart,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.luminosity),
                                    child: Image.asset(
                                      wisata.foto,
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 40),
                                  child: Text(
                                    wisata.nama,
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    wisata.kecamatan,
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ]
                            )
                          ),
                        )
                      ])
                    ),
                  ),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
