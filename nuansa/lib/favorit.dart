import 'package:flutter/material.dart';
import 'models/wisata_model.dart';

class FavoritScreen extends StatefulWidget {
  final List<WisataModel> listWisata;
  const FavoritScreen({Key? key, required this.listWisata}) : super(key: key);

  @override
  FavoritScreenState createState() => FavoritScreenState();
}

class FavoritScreenState extends State<FavoritScreen> {

  @override
  Widget build(BuildContext context) {
    

    return SingleChildScrollView(
      child: Column(
        children: widget.listWisata.map((wisata) {
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