import 'package:flutter/material.dart';
import 'login.dart';
import 'home.dart';
import 'detail_wisata.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  
  runApp(MyApp());
  }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nuansa.co',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff3D56B2),
      ),
      home: LoginScreen(),
    );
  }
}

