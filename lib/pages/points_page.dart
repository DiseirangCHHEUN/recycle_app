import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
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
  String? id, name;
  Future getUserPoints() async {
    id = await SharedPreferencesHelper().getUserId();
    name = await SharedPreferencesHelper().getUserName();

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

  final pointsController = TextEditingController();
  final upiIDController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    return Scaffold(
      body:
          _points == null
              ? Center(child: CircularProgressIndicator(color: Colors.green))
              : SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Your Points',
                            style: AppTextStyle.boldTextStyle(20),
                          ),
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
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/coin.png',
                                    width: 70,
                                    height: 70,
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    children: [
                                      Text(
                                        'Points Earned',
                                        style: AppTextStyle.normalTextStyle(22),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        _points == null
                                            ? '0'
                                            : _points.toString(),
                                        style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                openBox();
                              },
                              child: Material(
                                elevation: 2.0,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 50,
                                  width: screenWidth / 1.5,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Redeem Points",
                                      style: AppTextStyle.whiteTextStyle(20),
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
                ),
              ),
    );
  }

  Future openBox() => showDialog(
    barrierDismissible: false,
    useSafeArea: true,
    useRootNavigator: false,
    context: context,
    builder: (buildContext) {
      return AlertDialog(
        title: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(Icons.cancel, color: Colors.red),
            ),
            Expanded(child: SizedBox()),
            Text('Redeem Points', style: AppTextStyle.greenTextStyle(24)),
            Expanded(child: SizedBox()),
          ],
        ),
        content: Wrap(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Add points', style: AppTextStyle.boldTextStyle(20)),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: pointsController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter points';
                      }
                      if (int.parse(value) > _points!) {
                        return 'You cannot redeem more points than you have';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter points',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  Text('Add UPI ID', style: AppTextStyle.boldTextStyle(20)),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: upiIDController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your UPI ID';
                      }
                      // You can add more validation for UPI ID format if needed
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter UPI ID',
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          // final upiID = upiIDController.text;

                          final redeemPoints = int.parse(pointsController.text);
                          final upiID = upiIDController.text;

                          final updatedPoints = _points! - redeemPoints;
                          DatabaseMethods()
                              .updateUserPoints(
                                uid: id!,
                                newPoints: updatedPoints,
                              )
                              .then((_) {
                                Map<String, dynamic> userRedeemMap = {
                                  'name': name,
                                  'redeemPoints': redeemPoints,
                                  'upiID': upiID,
                                  'status': 'pending',
                                  'timestamp': DateTime.now(),
                                };

                                final String redeemID = randomAlphaNumeric(10);

                                DatabaseMethods().addUserRedeemPoint(
                                  userRedeemMap,
                                  id!,
                                  redeemID,
                                );

                                DatabaseMethods().addAdminRedeemRequest(
                                  userRedeemMap,
                                  redeemID,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Redeem request sent successfully!',
                                      style: AppTextStyle.whiteTextStyle(16),
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              });
                        }
                        getUserPoints();
                        pointsController.clear();
                        upiIDController.clear();
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Add',
                            style: AppTextStyle.whiteTextStyle(22),
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
    },
  );
}
