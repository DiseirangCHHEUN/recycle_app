import 'package:flutter/material.dart';
import 'package:recycle_app/styles/app_text_style.dart';

class AdminApproval extends StatefulWidget {
  const AdminApproval({super.key});

  @override
  State<AdminApproval> createState() => _UploadItemState();
}

class _UploadItemState extends State<AdminApproval> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30.0),
          buildUploadAppBar(),
          const SizedBox(height: 10.0),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              decoration: BoxDecoration(
                color: Color(0xFFE9E9F9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildApprovalItem(),
                    buildApprovalItem(),
                    buildApprovalItem(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildApprovalItem() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
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
                  Text('Requester Name', style: AppTextStyle.boldTextStyle(14)),
                ],
              ),
              const SizedBox(height: 5.0),
              Row(
                children: [
                  Icon(Icons.location_pin, color: Colors.green, size: 20),
                  SizedBox(width: 4.0),
                  Text('Psar Tmey', style: AppTextStyle.normalTextStyle(14)),
                ],
              ),
              const SizedBox(height: 5.0),
              Row(
                children: [
                  Icon(Icons.inventory_rounded, color: Colors.green, size: 20),
                  SizedBox(width: 4.0),
                  Text('5', style: AppTextStyle.normalTextStyle(14)),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildAdminActionButton(
                    onTap: () {
                      // Handle approve action
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
