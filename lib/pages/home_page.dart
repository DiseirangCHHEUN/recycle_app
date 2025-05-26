import 'package:flutter/material.dart';
import 'package:recycle_app/services/shared_pref.dart';
import 'package:recycle_app/services/auth_service.dart';
import 'package:recycle_app/styles/app_text_style.dart';

import '../core/consts/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final User? user = FirebaseAuth.instance.currentUser;

  String? uid, username, userEmail, userImage;

  Future getUserInfoFromSharedPref() async {
    username = await SharedPreferencesHelper().getUserName();
    uid = await SharedPreferencesHelper().getUserId();
    userImage = await SharedPreferencesHelper().getUserImage();
    userEmail = await SharedPreferencesHelper().getUserEmail();

    print("Home Loaded");
    print('$uid $username $userImage $userEmail');

    setState(() {});
  }

  @override
  void initState() {
    getUserInfoFromSharedPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: _buildDrawer(context),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 20.0),
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(25.0),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Image.asset("assets/images/tash_bin.jpeg"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 25),
                    child: Column(
                      children: [
                        Text(
                          "Earn Points",
                          style: AppTextStyle.whiteTextStyle(40.0),
                        ),
                        Text(
                          "for discarded trash",
                          style: AppTextStyle.whiteTextStyle(24.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Categories",
              style: AppTextStyle.headlineTextStyle(20.0),
            ),
          ),
          _buildCategoryList(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  "Pending Requests",
                  style: AppTextStyle.headlineTextStyle(20.0),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    border: Border.all(width: 2.0, color: Colors.blueGrey),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.green,
                            size: 30.0,
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            "Main market, Phnom Penh",
                            style: AppTextStyle.normalTextStyle(20),
                          ),
                        ],
                      ),
                      Divider(),
                      Image.asset(
                        "assets/images/home3.jpeg",
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.layers, color: Colors.green, size: 30.0),
                          SizedBox(width: 10.0),
                          Text('3', style: AppTextStyle.normalTextStyle(20)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      foregroundColor: Colors.white,
      title: Text("សម្រាមកែឆ្នៃ", style: AppTextStyle.boldTextStyle(16)),
      centerTitle: true,
      backgroundColor: Colors.green,
      actions: [
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {
            // Handle notification action
          },
        ),
      ],
    );
  }

  _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.green),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                _buildAvatarProfile(),
                SizedBox(height: 10),
                Text(
                  username ?? 'Anonymous',
                  style: AppTextStyle.whiteTextStyle(20),
                ),
                Text(
                  userEmail ?? 'No email',
                  style: AppTextStyle.whiteTextStyle(14),
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
          SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.home_rounded),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
            trailing: Icon(Icons.arrow_forward_ios, size: 15),
          ),
          ListTile(
            leading: Icon(Icons.approval_rounded),
            title: Text('Admin Approval'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.adminApproval);
            },
            trailing: Icon(Icons.arrow_forward_ios, size: 15),
          ),
          ListTile(
            leading: Icon(Icons.cancel_rounded),
            title: Text('Rejected Request'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.adminRejected);
            },
            trailing: Icon(Icons.arrow_forward_ios, size: 15),
          ),
          ListTile(
            leading: Icon(Icons.settings_rounded),
            title: Text('Settings'),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.settings);
            },
            trailing: Icon(Icons.arrow_forward_ios, size: 15),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Divider(thickness: .5),
          ),
          Spacer(),
          Divider(thickness: .5),
          GestureDetector(
            onTap: () {
              AuthService().signOut();
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout_rounded, color: Colors.red, size: 20),
                  SizedBox(width: 10),
                  Text("Log Out", style: AppTextStyle.dangerTextStyle(16.0)),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Version 1.0.0\nDeveloped by Recycle Team",
              style: AppTextStyle.normalTextStyle(10.0),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  _buildAvatarProfile() {
    return SizedBox(
      height: 80,
      width: 80,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child:
            userImage == null
                ? Image.asset("assets/images/profile.jpg")
                : Image.network(
                  userImage!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "assets/images/profile.jpg",
                      fit: BoxFit.cover,
                    );
                  },
                ),
      ),
    );
  }

  _buildCategoryList() {
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          _buildCategoryCard(image: 'assets/images/glass.jpeg', text: "Glass"),
          SizedBox(width: 20),
          _buildCategoryCard(
            image: 'assets/images/battery.jpeg',
            text: "Battery",
          ),
          SizedBox(width: 20),
          _buildCategoryCard(
            image: 'assets/images/plastic.jpeg',
            text: "Plastic",
          ),
          SizedBox(width: 20),
          _buildCategoryCard(image: 'assets/images/papper.jpeg', text: "Paper"),
        ],
      ),
    );
  }

  _buildCategoryCard({required String image, required String text}) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/uploadItem',
              arguments: {'categories': text, 'userId': uid},
              // Pass the category name to the upload item page
            );
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(width: 2.0, color: Colors.black54),
              color: Colors.blue[50],
            ),
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(image: AssetImage(image)),
              ),
            ),
          ),
        ),
        SizedBox(height: 5.0),
        Text(text, style: AppTextStyle.normalTextStyle(18.0)),
      ],
    );
  }
}
