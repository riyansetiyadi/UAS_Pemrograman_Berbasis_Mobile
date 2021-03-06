import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nuansa/login.dart';
import 'package:nuansa/models/user_model.dart';
import 'models/wisata_model.dart';


class ProfilScreen extends StatefulWidget {
  final UserModel userData;
  const ProfilScreen({Key? key,  required this.userData}) : super(key: key);

  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {

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
                    backgroundImage: AssetImage("assets/images/${widget.userData.foto}"),
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
                            widget.userData.nama
                          ),
                          
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      child: Row(
                        children: [
                          Icon(Icons.alternate_email_outlined),
                          SizedBox(height: 10,width: 15,),
                          Text(
                            widget.userData.email
                          )
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
                    child: InkWell(
                      onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                      child: Row(
                        children: [
                          Icon(Icons.logout_outlined),
                          SizedBox(height: 10,width: 15,),
                          Text("Logout")
                        ],
                      ),
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
