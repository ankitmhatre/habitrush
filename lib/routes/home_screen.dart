import 'package:flutter/material.dart';
import 'package:habitrush/routes/challenges_screen.dart';
import 'package:habitrush/routes/coins_screen.dart';
import 'package:habitrush/routes/habits_screen.dart';
import 'package:habitrush/routes/profile_screen.dart';
import 'package:habitrush/routes/public_challenges_screen.dart';
import 'package:habitrush/routes/store_screen.dart';
import 'package:habitrush/utilities/colors.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedIndex = 1;

  static const List<Widget> _pages = <Widget>[
    ChallengesPage(),
    HabitsPage(),
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
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey,
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedIconTheme:
              const IconThemeData(color: Colors.grey, size: 36),
          selectedFontSize: 12,
          selectedIconTheme: const IconThemeData(color: rushYellow, size: 36),
          selectedItemColor: rushYellow,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),

          currentIndex: _selectedIndex, //New
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.lock),
              label: 'Challenges',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.public),
              label: 'Habits',
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
      ),
    );
  }
}
