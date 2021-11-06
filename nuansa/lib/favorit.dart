import 'package:flutter/material.dart';
import 'models/wisata_model.dart';
import 'db/database.dart';

class FavoritScreen extends StatefulWidget {
  const FavoritScreen({Key? key}) : super(key: key);

  @override
  FavoritScreenState createState() => FavoritScreenState();
}

class FavoritScreenState extends State<FavoritScreen> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<WisataModel> listWisata = []; 

  @override
  Widget build(BuildContext context) {
    Future<List<WisataModel>> listWisataFuture = dbHelper.getWisataList();
    listWisataFuture.then((listWisata) {
      this.count = listWisata.length;
      if (this.count != 0) {
        this.listWisata = listWisata;
      }
    });

    return SingleChildScrollView(
      child: Column(
        children: listWisata.map((wisata) {
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
              margin: EdgeInsets.all(10),
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  SizedBox(
                    height: 120,
                    width: double.infinity,
                    child: Image(
                      image: AssetImage(wisata.foto),
                      fit: BoxFit.cover,
                    )
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
                ],
              ),
            ),
          );
        }).toList()
      ),
    );
  }
}