import 'package:flutter/material.dart';
import 'package:recycle_app/services/shared_pref.dart';
import 'package:recycle_app/styles/app_text_style.dart';

import '../core/utils/app_bar.dart';
import '../services/database.dart';

class AdminReject extends StatefulWidget {
  const AdminReject({super.key});

  @override
  State<AdminReject> createState() => _UploadItemState();
}

class _UploadItemState extends State<AdminReject> {
  Stream? adminRejectStream;
  Future getAdminRejectItems(String uid) async {
    adminRejectStream = await DatabaseMethods().getAdminRejectedItems(uid);
  }

  getUserID() async {
    final userId = await SharedPreferencesHelper().getUserId();
    getAdminRejectItems(userId!);
    setState(() {});
  }

  @override
  void initState() {
    getUserID();
    super.initState();
  }

  allRejectedItems() {
    return StreamBuilder(
      stream: adminRejectStream,
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
              return buildRejectedItem(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyAppBar(appBarTitle: 'Rejected Items'),
            const SizedBox(height: 8.0),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Color(0xFFE9E9F9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                ),
                child: allRejectedItems(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildRejectedItem({
    required String requesterName,
    required String address,
    required int quantity,
    required String status,
    required String id,
    required String userID,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: AssetImage('assets/images/plastic.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.person_rounded, color: Colors.green, size: 20),
                  SizedBox(width: 4.0),
                  Text(requesterName, style: AppTextStyle.boldTextStyle(14)),
                ],
              ),
              const SizedBox(height: 5.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.location_pin, color: Colors.green, size: 20),
                  SizedBox(width: 4.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Text(
                      address,
                      style: AppTextStyle.normalTextStyle(14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              Row(
                children: [
                  Icon(Icons.inventory_rounded, color: Colors.green, size: 20),
                  SizedBox(width: 4.0),
                  Text(
                    quantity.toString(),
                    style: AppTextStyle.normalTextStyle(14),
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              Row(
                children: [
                  Icon(
                    Icons.online_prediction_rounded,
                    color: Colors.green,
                    size: 20,
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    status == "rejected" ? "Rejected" : "Undefinded",
                    style: AppTextStyle.dangerTextStyle(14),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     adminActionButton(
              //       onTap: () async {
              //         int? userPoints = await getUserPoints(userID);
              //         int newPoints = userPoints! + 100;
              //         await DatabaseMethods().updateUserPoints(
              //           userID,
              //           newPoints,
              //         );
              //         // Handle approve action
              //         await DatabaseMethods().adminApproveRequestItem(id);
              //         await DatabaseMethods().approveUserRequestItem(
              //           userID,
              //           id,
              //         );
              //         // Optionally, show a success message or navigate to another screen
              //       },
              //       buttonText: 'Approve',
              //       color: Colors.green,
              //     ),
              //     const SizedBox(width: 10.0),
              //     adminActionButton(
              //       onTap: () async {
              //         // Handle reject action
              //         await DatabaseMethods().adminRejectRequestItem(id);
              //         await DatabaseMethods().rejectUserRequestItem(userID, id);
              //         // Optionally, show a success message or navigate to another screen
              //       },
              //       buttonText: 'Reject',
              //       color: const Color(0xFFFF6363),
              //     ),
              //   ],
              // ),
            ],
          ),
        ],
      ),
    );
  }

  adminActionButton({
    required VoidCallback onTap,
    required String buttonText,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Text(buttonText, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
