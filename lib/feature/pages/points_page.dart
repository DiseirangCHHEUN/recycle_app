import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import 'package:recycle_app/styles/app_text_style.dart';
import '../../services/database.dart';
import '../../services/shared_pref.dart';

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
    if (points == null) {
      // If points are null, initialize to 0
      await DatabaseMethods().updateUserPoints(uid: id!, newPoints: 0);
    }
    getUserRedeemRequest(id!);
    setState(() {
      _points = points;
    });
  }

  Stream? getUserRedeemRequestStream;
  Future getUserRedeemRequest(String uid) async {
    getUserRedeemRequestStream = await DatabaseMethods().getUserRedeemRequest(
      uid,
    );
    setState(() {});
  }

  @override
  void initState() {
    getUserPoints();
    super.initState();
  }

  allUserRedeemRequests(Size screenSize) {
    if (getUserRedeemRequestStream == null) {
      return Center(child: CircularProgressIndicator(color: Colors.green));
    }
    return StreamBuilder(
      stream: getUserRedeemRequestStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
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

  final pointsController = TextEditingController();
  final upiIDController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      color: Colors.green,
      child: SafeArea(
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
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                            ),
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
                                    style: AppTextStyle.boldTextStyle(22),
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
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            openBox();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Material(
                              elevation: 2.0,
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                height: 50,

                                // width: screenSize.width / 1.5,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(100),
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
                        ),
                        SizedBox(height: 15),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,

                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50),
                                topLeft: Radius.circular(50),
                              ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  'Last Transactions',
                                  style: AppTextStyle.boldTextStyle(20),
                                ),
                                SizedBox(height: 10),
                                Expanded(
                                  child: allUserRedeemRequests(screenSize),
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
      ),
    );
  }

  Container buildUserRedeemRequestItem(
    Size screenSize, {
    required String date,
    required int redeemPoints,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.all(5),

      width: screenSize.width,
      decoration: BoxDecoration(
        color: Color(0xFFD4E0FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
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
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.red.withValues(alpha: 200),
            ),
            child: Text(
              'Pending',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 10),
        ],
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
                          String formattedDate = DateFormat(
                            'd MMM',
                          ).format(now);

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
                                  'date': formattedDate,
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
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Redeem request sent successfully!',
                                        style: AppTextStyle.whiteTextStyle(16),
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                }
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
