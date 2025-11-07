import 'package:flutter/material.dart';
import 'package:laning_page/src/utils/color.dart';

class CustomScaffoldMessenger {
  message(BuildContext context, message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: kColorFondo,
          duration: Duration(seconds: 3),
        ),
      );
    });
  }
}
