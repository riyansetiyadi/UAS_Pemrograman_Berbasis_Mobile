import 'package:flutter/material.dart';
import 'package:nuansa/models/user_model.dart';
import 'package:nuansa/profil.dart';
import 'favorit.dart';
import 'home.dart';
import 'db/database.dart';
import 'models/wisata_model.dart';

class Navigation extends StatefulWidget {
  final UserModel userData;
  const Navigation({Key? key, required this.userData}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  DatabaseManager database = DatabaseManager();
  
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nuansa.co"),
        toolbarHeight: kToolbarHeight,
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: Icon(Icons.notifications_none)
          )
        ],
      ),
      body: <Widget>[HomeScreen(userData: widget.userData,), FavoritScreen(userData: widget.userData,), ProfilScreen(),].elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}

