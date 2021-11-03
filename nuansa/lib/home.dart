import 'package:flutter/material.dart';
import 'models/wisata_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
            _listWisataScroller(context, "Destinasi Terdekat", dataWisata),
            _listWisataScroller(context, "Destinasi Terpopuler", dataWisata),
          ],
        ),
    );
  }


  get dataWisata => [
    ModelWisata(id: 0, foto: "assets/images/papuma.jpg", nama: "Papuma", lokasi: "Jember", deskripsi: "deskripsi"),
    ModelWisata(id: 1, foto: "assets/images/papuma.jpg", nama: "Papuma", lokasi: "Jember", deskripsi: "deskripsi"),
    ModelWisata(id: 2, foto: "assets/images/papuma.jpg", nama: "Papuma", lokasi: "Jember", deskripsi: "deskripsi"),
    ModelWisata(id: 3, foto: "assets/images/papuma.jpg", nama: "Papuma", lokasi: "Jember", deskripsi: "deskripsi"),
    ModelWisata(id: 4, foto: "assets/images/papuma.jpg", nama: "Papuma", lokasi: "Jember", deskripsi: "deskripsi"),
    ModelWisata(id: 5, foto: "assets/images/papuma.jpg", nama: "Papuma", lokasi: "Jember", deskripsi: "deskripsi"),
    ModelWisata(id: 6, foto: "assets/images/papuma.jpg", nama: "Papuma", lokasi: "Jember", deskripsi: "deskripsi"),
    ModelWisata(id: 7, foto: "assets/images/papuma.jpg", nama: "Papuma", lokasi: "Jember", deskripsi: "deskripsi"),
    ModelWisata(id: 8, foto: "assets/images/papuma.jpg", nama: "Papuma", lokasi: "Jember", deskripsi: "deskripsi"),
    ModelWisata(id: 9, foto: "assets/images/papuma.jpg", nama: "Papuma", lokasi: "Jember", deskripsi: "deskripsi"),
    ModelWisata(id: 10, foto: "assets/images/papuma.jpg", nama: "Papuma", lokasi: "Jember", deskripsi: "deskripsi"),
  ];

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
                                var result = await Navigator.of(context).pushNamed(
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
                              wisata.lokasi,
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
