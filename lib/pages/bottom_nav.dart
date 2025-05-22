import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:recycle_app/pages/home_page.dart';
import 'package:recycle_app/pages/profile_page.dart';

import 'points_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late final List<Widget> _pages;
  late HomePage homePage;
  late PointsPage pointsPage;
  late ProfilePage profilePage;
  int _selectedIndex = 0;

  @override
  void initState() {
    homePage = const HomePage();
    pointsPage = const PointsPage();
    profilePage = const ProfilePage();

    _pages = [homePage, pointsPage, profilePage];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Colors.green,
        height: 60,
        items: const <Widget>[
          Icon(Icons.home_rounded, size: 30, color: Colors.white),
          Icon(Icons.point_of_sale_rounded, size: 30, color: Colors.white),
          Icon(Icons.person_rounded, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
