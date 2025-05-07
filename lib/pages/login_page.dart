import 'package:flutter/material.dart';
import 'package:recycle_app/services/auth_service.dart';
import 'package:recycle_app/styles/app_text_style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/home0.jpeg',
              height: 250,
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/plastic.jpeg',
                    height: 150,
                    width: 150,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "Reduce. Reuse. Recycle. Repeat!",
                    style: AppTextStyle.headlineTextStyle(20.0),
                  ),
                  Text("Repeat!", style: AppTextStyle.greenTextStyle(30.0)),
                  SizedBox(height: 50.0),
                  Text(
                    "Every items you recycle\nmakes a difference!",
                    textAlign: TextAlign.center,
                    style: AppTextStyle.normalTextStyle(20.0),
                  ),
                  Text(
                    "Get Started!",
                    style: AppTextStyle.greenTextStyle(24.0),
                  ),
                  SizedBox(height: 30.0),
                  GestureDetector(
                    onTap: () {
                      AuthService().signinWithGoogle().then((value) {
                        Navigator.pushReplacementNamed(context, '/home');
                      });
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      elevation: 4.0,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Image.asset(
                                "assets/images/google.png",
                                height: 50.0,
                                width: 50.0,
                              ),
                            ),
                            SizedBox(width: 20.0),
                            Text(
                              'Sign in with Google',
                              style: AppTextStyle.whiteTextStyle(24.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
