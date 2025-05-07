import 'package:flutter/material.dart';

import '../styles/app_text_style.dart';

class MButton extends StatelessWidget {
  const MButton(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.green,
        ),
        child: Text(text, style: AppTextStyle.whiteTextStyle(24.0)),
      ),
    );
  }
}
