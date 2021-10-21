import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: kToolbarHeight,
          child: Image.asset("assets/images/nuansa.png"),
        ),
        toolbarHeight: kToolbarHeight,
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: Icon(Icons.notifications_none)
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
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
            ],
          ),
        )
      ),
    );
  }
}