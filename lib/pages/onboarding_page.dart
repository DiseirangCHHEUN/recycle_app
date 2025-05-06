import 'package:flutter/material.dart';
import 'package:recycle_app/styles/app_style.dart';
import 'package:recycle_app/widgets/material_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset('assets/images/onboarding.jpeg'),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recycle your waste products!',
                  style: AppStyle.headlineTextStyle(30.0),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Easily collect household waste and generate less waste.',
                  style: AppStyle.normalTextStyle(20.0),
                ),
                SizedBox(height: 100.0),
                MButton('Get Started'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
