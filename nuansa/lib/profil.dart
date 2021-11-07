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
          child: Column(
            children: [
            SizedBox(height: 15,),
            Text(
              "Pengaturan",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
            SizedBox(height: 30,),
            SizedBox(
              height: 90,
              width: 90,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/home_bg.jpg"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            
          Container(
            
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Text(" "),
                      SizedBox(width: 30,),
                      Text("Account",
                      style: TextStyle(
                        color:Colors.white,
                        fontSize: 20 ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        
            Padding(
              padding:const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Container(
                width:double.infinity ,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:BorderRadius.circular(15),
                  
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Icon(Icons.account_circle_outlined),
                          SizedBox(height: 10,width: 15,),
                          Text(
                            "Naufal Zakly S."),
                          
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      child: Row(
                        children: [
                          Icon(Icons.add_location_outlined),
                          SizedBox(height: 10,width: 15,),
                          Text("Jl. Kalimantan, Jember"),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      child: Row(
                        children: [
                          Icon(Icons.alternate_email_outlined),
                          SizedBox(height: 10,width: 15,),
                          Text("dribbble@gmail.com")
                        ],),
                    )
                  ],
                ),

              ),
            ),
          Container(
            
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      SizedBox(width:30 ,),
                      Text("General",
                      style: TextStyle(
                        color:Colors.white,
                        fontSize: 20 ),),
                    
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.privacy_tip_outlined),
                        SizedBox(height: 10,width: 15,),
                        Text("Privacy and Policy"),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.help_outline),
                        SizedBox(height: 10,width: 15,),
                        Text("Help"),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.logout_outlined),
                        SizedBox(height: 10,width: 15,),
                        Text("Logout")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

            ]),
    )));
  }
}
