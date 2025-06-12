import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:recycle_app/core/utils/app_bar.dart';

import '../services/database.dart';
import '../styles/app_text_style.dart';

class RedeemRequest extends StatefulWidget {
  const RedeemRequest({super.key});

  @override
  State<RedeemRequest> createState() => _RedeemRequestState();
}

class _RedeemRequestState extends State<RedeemRequest> {
  Stream? getAllUserRedeemRequestStream;
  Future getAllUserRedeemRequest() async {
    getAllUserRedeemRequestStream =
        await DatabaseMethods().getAllUserRedeemRequest();
    setState(() {});
  }

  @override
  void initState() {
    getAllUserRedeemRequest();
    super.initState();
  }

  allUserRedeemRequests(Size screenSize) {
    if (getAllUserRedeemRequestStream == null) {
      return Center(child: CircularProgressIndicator(color: Colors.green));
    }
    return StreamBuilder(
      stream: getAllUserRedeemRequestStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final data =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                final date = data['date'] ?? 'Unknown Date';
                final redeemPoints = data['redeemPoints'] ?? 0;
                return buildUserRedeemRequestItem(
                  screenSize,
                  date: date,
                  redeemPoints: redeemPoints,
                );
              },
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Loading...', style: AppTextStyle.normalTextStyle(16)),
                const SizedBox(height: 15.0),
                CircularProgressIndicator(
                  color: Colors.green,
                  // strokeWidth: 2,
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: Text(
              'No data available',
              style: AppTextStyle.greyTextStyle(18),
            ),
          );
        }
      },
    );
  }

  Container buildUserRedeemRequestItem(
    Size screenSize, {
    required String date,
    required int redeemPoints,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(5),

      width: screenSize.width,
      decoration: BoxDecoration(
        color: Color(0xFFD4E0FF),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Text(
              textAlign: TextAlign.center,
              date.replaceAllMapped(
                " ",
                (match) => "\n",
              ), // Display only the date part
              style: AppTextStyle.whiteTextStyle(16),
            ),
          ),
          SizedBox(width: 20),
          Column(
            children: [
              Text('Redeem points', style: AppTextStyle.boldTextStyle(16)),
              Text(
                redeemPoints.toString(),
                style: AppTextStyle.greenTextStyle(22),
              ),
            ],
          ),
          Expanded(child: SizedBox()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.green,
            ),
            child: Text(
              'Approve',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30),
          MyAppBar(appBarTitle: 'User Redeem Request'),
          SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: BackdropFilter(

              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.red.withAlpha(500),
                  gradient: LinearGradient(
                    colors: [
                      Colors.red.withOpacity(0.25),
                      Colors.white.withOpacity(0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1.2,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Glass UI',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.9),
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: Offset(1, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: allUserRedeemRequests(screenSize),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
