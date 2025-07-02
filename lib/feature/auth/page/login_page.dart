import 'package:flutter/material.dart';
import 'package:recycle_app/core/consts/app_routes.dart';
import 'package:recycle_app/core/consts/app_strings.dart';
import 'package:recycle_app/services/auth_service.dart';
import 'package:recycle_app/styles/app_text_style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image.asset(
          //   'assets/images/home0.jpeg',
          //   height: 250,
          //   width: double.maxFinite,
          //   fit: BoxFit.cover,
          // ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    'assets/images/plastic.jpeg',
                    height: 150,
                    width: 150,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  "Reduce. Reuse. Recycle. Repeat!",
                  style: AppTextStyle.headlineTextStyle(25.0),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 35.0),
                Text(
                  AppStrings.welcomeText,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.normalLightTextStyle(20.0),
                ),
                Text(
                  AppStrings.getStarted,
                  style: AppTextStyle.greenTextStyle(24.0),
                ),
                SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLoading = true;
                    });
                    if (isLoading) {
                      AuthService().signinWithGoogle();
                      Navigator.pushNamed(context, AppRoutes.authCheck).then((
                        value,
                      ) {
                        setState(() {
                          isLoading = false;
                        });
                      });
                    }
                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.green,
                    elevation: 4.0,

                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child:
                            isLoading
                                ? CircularProgressIndicator()
                                : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      maxRadius: 18,
                                      backgroundColor: Colors.white,
                                      child: Image.asset(
                                        "assets/images/google.png",
                                        height: 25.0,
                                        width: 25.0,
                                      ),
                                    ),
                                    SizedBox(width: 16.0),
                                    Text(
                                      'Sign in with Google',
                                      style: AppTextStyle.whiteTextStyle(
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                      ),
                                    ),
                                  ],
                                ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
