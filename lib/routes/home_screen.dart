import 'package:flutter/material.dart';
import 'package:habitrush/routes/coins_screen.dart';
import 'package:habitrush/routes/profile_screen.dart';
import 'package:habitrush/routes/public_challenges_screen.dart';
import 'package:habitrush/routes/store_screen.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    PublicChallengesPage(),
    Icon(
      Icons.camera,
      size: 150,
    ),
    StorePage(),
    CoinsPage(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.amberAccent,
        unselectedFontSize: 15,
        unselectedIconTheme:
            const IconThemeData(color: Colors.amberAccent, size: 32),
        selectedFontSize: 15,
        selectedIconTheme:
            const IconThemeData(color: Colors.deepOrange, size: 32),
        selectedItemColor: Colors.deepOrange,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),

        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'Habits',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lock),
            label: 'Challenges',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Coins',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
    );
  }
}
