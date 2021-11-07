import 'package:flutter/material.dart';
import 'models/wisata_model.dart';
import 'db/database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DbHelper dbHelper = DbHelper();

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
            _listWisataScroller(context, "Destinasi Terdekat", _dataWisata),
            _listWisataScroller(context, "Destinasi Terpopuler", _dataWisata),
          ],
        ),
    );
  }

  Widget _listWisataScroller(BuildContext context, String titlePage, List dataWisata) {
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
                children: dataWisata.map((wisata) {
                  return InkWell(
                    onTap: () async {
                                await Navigator.of(context).pushNamed(
                                  '/detail',
                                  arguments: {
                                    'wisata': wisata,
                                  },
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
                              wisata.kota,
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ]
                      )
                    ),
                  );
                }).toList()
              ),
            ),
          ),
        ],
      ),
    );
  }
}
