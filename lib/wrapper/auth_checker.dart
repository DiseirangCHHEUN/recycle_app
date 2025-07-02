import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recycle_app/feature/pages/bottom_nav.dart';
import 'package:recycle_app/feature/auth/page/login_page.dart';

class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // print("My connection states : ${snapshot.connectionState}");

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        return (snapshot.hasData) ? BottomNav() : LoginPage();
      },
    );
  }
}
