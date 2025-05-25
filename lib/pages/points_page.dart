import 'package:flutter/material.dart';
import 'package:recycle_app/styles/app_text_style.dart';

import '../services/database.dart';
import '../services/shared_pref.dart';

class PointsPage extends StatefulWidget {
  const PointsPage({super.key});

  @override
  State<PointsPage> createState() => _PointsPageState();
}

class _PointsPageState extends State<PointsPage> {
  int? _points;
  Future getUserPoints() async {
    final id = await SharedPreferencesHelper().getUserId();

    final points = await DatabaseMethods().getUserPoints(id!);
    setState(() {
      _points = points;
    });
  }

  @override
  void initState() {
    getUserPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final double appBarHeight = AppBar().preferredSize.height;
    final double bottomNavBarHeight = kBottomNavigationBarHeight;
    final double availableHeight =
        screenHeight -
        appBarHeight -
        bottomNavBarHeight -
        MediaQuery.of(context).padding.top;
    final double availableWidth = screenWidth;
    // final double availableWidthForPoints = availableWidth * 0.8;
    // final double availableHeightForPoints = availableHeight * 0.8;
    // final double pointsIconSize = availableWidthForPoints * 0.2;
    // final double pointsTextSize = availableWidthForPoints * 0.1;
    // final double pointsTextPadding = availableHeightForPoints * 0.05;
    // final double pointsIconPadding = availableHeightForPoints * 0.1;
    // final double pointsTextHeight = availableHeightForPoints * 0.1;
    // final double pointsIconHeight = availableHeightForPoints * 0.2;
    // final double pointsIconWidth = availableWidthForPoints * 0.2;
    // final double pointsTextWidth = availableWidthForPoints * 0.8;
    // final double pointsTextMargin = availableHeightForPoints * 0.05;
    // final double pointsIconMargin = availableHeightForPoints * 0.1;
    // final double pointsTextFontSize = availableHeightForPoints * 0.05;
    // final double pointsIconFontSize = availableHeightForPoints * 0.1;
    // final double pointsTextLineHeight = availableHeightForPoints * 0.1;
    // final double pointsIconLineHeight = availableHeightForPoints * 0.2;
    // final double pointsTextLetterSpacing = availableHeightForPoints * 0.01;
    // final double pointsIconLetterSpacing = availableHeightForPoints * 0.01;
    // final double pointsTextWordSpacing = availableHeightForPoints * 0.01;
    // final double pointsIconWordSpacing = availableHeightForPoints * 0.01;

    return Scaffold(
      // appBar: AppBar(title: const Text('Points Page'), centerTitle: true),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('User Points', style: AppTextStyle.boldTextStyle(20)),
              ],
            ),
            Container(
              width: availableWidth,
              height: availableHeight,
              decoration: BoxDecoration(
                color: const Color(0xFFF8F8F8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/coin.png',
                    width: availableWidth * 0.3,
                    height: availableHeight * 0.2,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _points == null ? '0' : _points.toString(),
                    style: AppTextStyle.boldTextStyle(40),
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
