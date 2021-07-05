import 'package:flutter/material.dart';
import 'package:football_fields_system/screens/home_screen.dart';
import 'package:football_fields_system/screens/owner_profile_screen.dart';
import 'package:football_fields_system/screens/player_profile_screen.dart';
import 'package:football_fields_system/screens/search_screen.dart';
import 'package:football_fields_system/services/Provider.dart';
import 'package:provider/provider.dart';

class NavigationCenter extends StatefulWidget {

  @override
  _NavigationCenterState createState() => _NavigationCenterState();
}

class _NavigationCenterState extends State<NavigationCenter> {

  int currentIndex = 0;

  final playerScreens = [
    HomeScreen(),
    SearchScreen(),
    PlayerProfileScreen(),
  ];

  final ownerScreens = [
    HomeScreen(),
    SearchScreen(),
    OwnerProfile(),
  ];

  final bottomBarItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: 'Search'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.person,),
        label: 'Profile',
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Provider.of<Indicator>(context).isOwner==false?playerScreens[currentIndex]:ownerScreens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.teal,
        currentIndex: currentIndex,
        onTap: (index){
          setState(() {
            currentIndex =index;
          });
        },
        items: bottomBarItems,
      ),
    );
  }
}
