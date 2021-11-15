// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jobme/authentification/login.dart';
import 'package:jobme/authentification/forgotten_password.dart';
import 'package:jobme/authentification/choose_register.dart';
import 'package:jobme/authentification/register_company.dart';
import 'package:jobme/authentification/register_jobbeur.dart';
import 'package:jobme/parameters/main_parameters.dart';
import 'package:jobme/profile/dashboard_company.dart';
import 'package:jobme/profile/dashboard_jobbeur.dart';
import 'package:jobme/profile/profile_company.dart';
import 'package:jobme/profile/profile_jobbeur.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => const MyLoginPage(),
        '/forgot': (context) => const PasswordForgotten(),
        '/register': (context) => const WhichUser(),
        '/register_jobbeur': (context) => const JobbeurRegisterPage(),
        '/register_company': (context) => const CompanyRegisterPage(),
        '/dashboard_jobbeur': (context) => const DashboardJobbeur(),
        '/dashboard_company': (context) => const DashboardCompany(),
        '/profile_jobbeur': (context) => const JobbeurProfile(),
        '/profile_company': (context) => const CompanyProfile(),
        '/settings': (context) => const MySettings(),
      },
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "Welcome",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "JobMe is awesome",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blueAccent[700],
                    fontSize: 20,
                  ),
                )
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/jobme.png"),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  //color: Color(0xff005267),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/register');
                  },
                  color: Color(0xffEB5E40),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    )));
  }
}
