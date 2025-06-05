import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  Stream? getUserRedeemRequestStream;
  Future getUserRedeemRequest() async {
    getUserRedeemRequestStream = await DatabaseMethods().getUserRedeemRequest(
      id!,
    );
    setState(() {});
  }

  @override
  void initState() {
    getUserPoints();
    getUserRedeemRequest();
    super.initState();
  }

  allApprovalItems() {
    return StreamBuilder(
      stream: getUserRedeemRequestStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final item = snapshot.data!.docs[index];
              final itemAddress = item['address'];
              final itemQuantity = item['quantity'];
              final itemRequesterName = item['username'];
              final itemStatus = item['status'];
              final docId = item.id;
              final userId = item['userId'];
              return buildApprovalItem(
                requesterName: itemRequesterName,
                address: itemAddress,
                quantity: itemQuantity,
                status: itemStatus,
                id: docId,
                userID: userId,
              );
            },
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Loading...', style: AppTextStyle.normalTextStyle(16)),
                const SizedBox(height: 15.0),
                CircularProgressIndicator(color: Colors.green, strokeWidth: 2),
              ],
            ),
          );
        } else {
          return Center(child: Text('No data available'));
        }
      },
    );
  }

  final pointsController = TextEditingController();
  final upiIDController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Your Points')),
        body: Container(
          color: Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: screenSize.width,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4E0FF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
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
                                _points == null
                                    ? Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.green,
                                      ),
                                    )
                                    : Text(
                                      _points.toString(),
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
                            width: screenSize.width / 1.5,
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
                      SizedBox(height: 15),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Text(
                                'Last Transactions',
                                style: AppTextStyle.boldTextStyle(16),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(5),

                                width: screenSize.width,
                                decoration: BoxDecoration(
                                  color: Color(0xFFD4E0FF),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        '04\nMay',
                                        style: AppTextStyle.whiteTextStyle(16),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Column(
                                      children: [
                                        Text(
                                          'Redeem points',
                                          style: AppTextStyle.boldTextStyle(16),
                                        ),
                                        Text(
                                          '100',
                                          style: AppTextStyle.greenTextStyle(
                                            22,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(child: SizedBox()),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.red.withOpacity(0.3),
                                      ),
                                      child: Text(
                                        'Peending',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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

                          DateTime now = DateTime.now();
                          String formatedDate = DateFormat('d MMM').format(now);

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
                                  'date': formatedDate,
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
