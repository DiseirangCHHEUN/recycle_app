import 'package:flutter/material.dart';
import 'package:recycle_app/styles/app_text_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text(
                    '👋Hello, ',
                    style: AppTextStyle.headlineTextStyle(25.0),
                  ),
                  Text('Diseirang ', style: AppTextStyle.greenTextStyle(24.0)),
                  Spacer(),
                  _buildAvatarProfile(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 25.0,
              ),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(25.0),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Image.asset("assets/images/home0.jpeg"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, top: 25),
                      child: Column(
                        children: [
                          Text(
                            "Earn Points",
                            style: AppTextStyle.headlineTextStyle(40.0),
                          ),
                          Text(
                            "for discarded trash",
                            style: AppTextStyle.normalTextStyle(24.0),
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
                style: AppTextStyle.headlineTextStyle(24.0),
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
                    style: AppTextStyle.headlineTextStyle(24.0),
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
      ),
    );
  }

  SizedBox _buildAvatarProfile() {
    return SizedBox(
      height: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.asset("assets/images/profile.jpg"),
      ),
    );
  }

  Container _buildCategoryList() {
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          _buildCategoryCard(image: 'assets/images/glass.jpeg', text: "Glas"),
          SizedBox(width: 30),
          _buildCategoryCard(
            image: 'assets/images/battery.jpeg',
            text: "Battery",
          ),
          SizedBox(width: 30),
          _buildCategoryCard(
            image: 'assets/images/plastic.jpeg',
            text: "Plastic",
          ),
          SizedBox(width: 30),
          _buildCategoryCard(
            image: 'assets/images/papper.jpeg',
            text: "Papper",
          ),
        ],
      ),
    );
  }

  Column _buildCategoryCard({required String image, required String text}) {
    return Column(
      children: [
        Container(
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
        SizedBox(height: 5.0),
        Text(text, style: AppTextStyle.normalTextStyle(18.0)),
      ],
    );
  }
}
