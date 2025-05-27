import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final String appBarTitle;
  const MyAppBar({super.key, required this.appBarTitle});

  @override
  Widget build(BuildContext context) {
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
            appBarTitle,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
