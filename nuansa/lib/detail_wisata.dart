import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'models/wisata_model.dart';

class DetailWisata extends StatefulWidget {
  const DetailWisata({Key? key}) : super(key: key);

  @override
  _DetailWisataState createState() => _DetailWisataState();
}

class _DetailWisataState extends State<DetailWisata> {
  WisataModel? _wisata;

  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    if (args.containsKey('wisata')) {
      var wisata = args['wisata'];
      if (wisata is WisataModel) {
        _wisata = wisata;
      }
    }
    

    return (
      Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    _wisata?.foto ?? "error.jpg",
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
                padding: EdgeInsets.fromLTRB(35, 10, 35, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: _wisata?.nama ?? "Error",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        children: const [
                          TextSpan(
                            text: "   (100 Km)",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.white54
                            )
                          )
                        ]
                      )
                    ),
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
                            fontSize: 23,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Text(
                "${_wisata?.kota}, ${_wisata?.negara}",
              )
            ],
          ),
        )
      )
    );
  }
}