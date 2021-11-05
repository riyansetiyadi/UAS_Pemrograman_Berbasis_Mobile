import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/wisata_model.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Text(
                "My Profil",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(80.0),
                child: Image.asset(
                  'assets/images/home_bg.jpg',
                  width: 150.0,
                  height: 150.0,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3))
                    
                  ],
                ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Nama Lengkap",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: 10,),
              Text(
                "Naufal Zakly S.",
                style: TextStyle(
                    fontSize: 20
                ),
              ),
              SizedBox(
                height: 20,),
              Text(
                "Alamat",
                  style: TextStyle(
                    fontSize: 30
                  ),
                ),
              SizedBox(
                height: 10,),
              Text(
                "Jl. Kalimantan, Jember",
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(
                height: 20,),
              Text(
                "Email",
                  style: TextStyle(
                    fontSize: 30
                  ),
                ),
              SizedBox(
                height: 10,),
              Text(
                "Iniemail@gmail.com",
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(height: 20,),
              Text(
                "Ketentuan Layanan",
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(height: 10,),
              Text(
                "Logout",
                style: TextStyle(
                  fontSize: 20
                ),
              ),
            ],
          ),
        ),
            ]),
    )));
  }
}

