import 'package:flutter/material.dart';

void showErrorMessage(
    {required BuildContext context, String content = "Something went wrong."}) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: Colors.red, content: Text(content)));
}

void showSuccessfulMessage(
    {required BuildContext context, String content = ""}) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: Colors.green, content: Text(content)));
}
