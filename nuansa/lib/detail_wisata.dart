import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'models/wisata_model.dart';

class DetailWisata extends StatefulWidget {
  const DetailWisata({Key? key}) : super(key: key);

  @override
  _DetailWisataState createState() => _DetailWisataState();
}

class _DetailWisataState extends State<DetailWisata> {
  ModelWisata? _wisata;

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    if (args.containsKey('wisata')) {
      var wisata = args['wisata'];
      if (wisata is ModelWisata) {
        _wisata = wisata;
      }
    }

    return (
      Scaffold(
        body: Container()
      )
    );
  }
}