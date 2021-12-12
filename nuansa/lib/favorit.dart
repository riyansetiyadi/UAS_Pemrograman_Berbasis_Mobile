import 'package:flutter/material.dart';
import 'package:nuansa/models/user_model.dart';
import 'models/wisata_model.dart';

class FavoritScreen extends StatefulWidget {
  final Future<List> listWisata;
  final UserModel userData;
  const FavoritScreen({Key? key, required this.listWisata, required this.userData}) : super(key: key);

  @override
  FavoritScreenState createState() => FavoritScreenState();
}

class FavoritScreenState extends State<FavoritScreen> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.listWisata,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Column(
              children: [
                for (var wisata in (snapshot.data as List)) InkWell(
                  onTap: () async {
                    await Navigator.of(context).pushNamed(
                      '/detail',
                      arguments: {
                        'wisata': wisata,
                        'user': widget.userData,
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
                            wisata.kecamatan,
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ]
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      }
    );
    

    
  }
}