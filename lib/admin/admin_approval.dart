import 'package:flutter/material.dart';
import 'package:recycle_app/styles/app_text_style.dart';

import '../services/database.dart';

class AdminApproval extends StatefulWidget {
  const AdminApproval({super.key});

  @override
  State<AdminApproval> createState() => _UploadItemState();
}

class _UploadItemState extends State<AdminApproval> {
  Stream? adminApprovalStream;
  Future getAdminApprovalItems() async {
    adminApprovalStream = await DatabaseMethods().getAdminApprovalItems();
    setState(() {});
  }

  Future<int?> getUserPoints(String docId) async {
    return await DatabaseMethods().getUserPoints(docId);
  }

  @override
  void initState() {
    super.initState();
    getAdminApprovalItems();
  }

  allApprovalItems() {
    return StreamBuilder(
      stream: adminApprovalStream,
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
                const SizedBox(height: 10.0),
                CircularProgressIndicator(),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: AppTextStyle.normalTextStyle(16),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30.0),
          buildUploadAppBar(),
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
              child: allApprovalItems(),
            ),
          ),
        ],
      ),
    );
  }

  Container buildApprovalItem({
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
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildAdminActionButton(
                    onTap: () async {
                      int? userPoints = await getUserPoints(userID);
                      int newPoints = userPoints! + 100;
                      await DatabaseMethods().updateUserPoints(
                        userID,
                        newPoints,
                      );
                      // Handle approve action
                      await DatabaseMethods().adminApproveRequestItem(id);
                      await DatabaseMethods().approveUserRequestItem(
                        userID,
                        id,
                      );
                      // Optionally, show a success message or navigate to another screen
                    },
                    buttonText: 'Approve',
                    color: Colors.green,
                  ),
                  const SizedBox(width: 10.0),
                  buildAdminActionButton(
                    onTap: () {
                      // Handle reject action
                    },
                    buttonText: 'Reject',
                    color: const Color(0xFFFF6363),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  GestureDetector buildAdminActionButton({
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

  buildUploadAppBar() {
    return SizedBox(
      height: 50.0,
      child: Row(
        children: [
          const SizedBox(width: 20.0),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(100.0),
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 24.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20.0),
          Text(
            'Admin Approval',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
