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
  final List<Widget> _pages = [
    const HomePage(),
    const PointsPage(),
    const ProfilePage(),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  _buildBottomNavBar() {
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      color: Colors.green,
      animationDuration: const Duration(milliseconds: 300),
      height: 60,
      items: _bottomNavBarItem,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }

  final List<Widget> _bottomNavBarItem = [
    Icon(Icons.home_rounded, size: 30, color: Colors.white),
    Icon(Icons.point_of_sale_rounded, size: 30, color: Colors.white),
    Icon(Icons.person_rounded, size: 30, color: Colors.white),
  ];
}
