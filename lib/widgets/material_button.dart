import 'package:flutter/material.dart';

import '../styles/app_text_style.dart';

class MButton extends StatelessWidget {
  const MButton(this.text, {super.key, required this.onTap});

  final String text;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.green,
          ),
          child: Center(
            child: Text(text, style: AppTextStyle.whiteTextStyle(20.0)),
          ),
        ),
      ),
    );
  }
}
