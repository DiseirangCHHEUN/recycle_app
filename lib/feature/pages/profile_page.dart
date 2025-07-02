import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Page'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.point_of_sale_rounded, size: 100),
            SizedBox(height: 20),
            Text('Profile Page', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
