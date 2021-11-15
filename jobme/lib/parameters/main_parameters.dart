import 'package:flutter/material.dart';
import 'package:jobme/company/job_remove.dart';
import 'package:jobme/authentification/login.dart';
import 'package:jobme/parameters/change_password.dart';
import 'package:jobme/profile/profile_company.dart';
import 'package:jobme/profile/profile_jobbeur.dart';
import 'package:http/http.dart' as http;

class MySettings extends StatefulWidget {
  const MySettings({Key? key}) : super(key: key);

  @override
  _MySettingsState createState() => _MySettingsState();
}

class _MySettingsState extends State<MySettings> {
  deleteAccount() async {
    try {
      var response;
      if (isJobbeur == true) {
        response = await http.delete(
          Uri.parse('http://10.0.2.2:8080/applicant/delete'),
          headers: {'Authorization': 'Bearer $token'},
        );
      } else {
        response = await http.delete(
          Uri.parse('http://10.0.2.2:8080/company/delete'),
          headers: {'Authorization': 'Bearer $token'},
        );
      }
      print(response.body);
    } catch (err) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            if (isJobbeur == true) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const JobbeurProfile()));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CompanyProfile()));
            }
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChangeMyPassword()));
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.blue,
            ),
            child: const Text("Change password"),
          ),
          ElevatedButton(
            onPressed: () {
              token = '';
              editId = '';
              Navigator.pushReplacementNamed(context, '/home');
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.red,
            ),
            child: const Text("Logout"),
          ),
          ElevatedButton(
            onPressed: () {
              deleteAccount();
              token = '';
              editId = '';
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Account successfully deleted")));
              Navigator.pushReplacementNamed(context, '/home');
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.red,
            ),
            child: const Text("Delete account"),
          ),
        ],
      )),
    );
  }
}
