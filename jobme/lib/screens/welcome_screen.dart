import 'package:flutter/material.dart';
import 'package:front/constants/colors.dart';
import 'package:front/widgets/home/welcome_app_bar.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: const WelcomeAppBar(),
      body: Center(
        child: Image.asset("assets/jobme.png"),
      ),
    );
  }
}
