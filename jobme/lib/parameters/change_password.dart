import 'package:flutter/material.dart';
import 'package:jobme/authentification/login.dart';
import 'package:jobme/parameters/main_parameters.dart';
import 'package:http/http.dart' as http;
import 'package:jobme/utils/space.dart';

class ChangeMyPassword extends StatefulWidget {
  const ChangeMyPassword({Key? key}) : super(key: key);

  @override
  _MySettingsState createState() => _MySettingsState();
}

class _MySettingsState extends State<ChangeMyPassword> {
  TextEditingController oldPsdController = TextEditingController();
  TextEditingController newPsdController = TextEditingController();

  changePassword(String oldPsd, String newPsd) async {
    try {
      var response;
      if (isJobbeur == true) {
        response = await http.put(
          Uri.parse('http://10.0.2.2:8080/applicant/modify/password'),
          headers: {'Authorization': 'Bearer $token'},
          body: {"password": oldPsd, "newPassword": newPsd},
        );
      } else {
        response = await http.put(
          Uri.parse('http://10.0.2.2:8080/company/modify/password'),
          headers: {'Authorization': 'Bearer $token'},
          body: {"password": oldPsd, "newPassword": newPsd},
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
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const MySettings()));
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(children: [
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter password here'),
              controller: oldPsdController,
            ),
            space(10),
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter new password here'),
              controller: newPsdController,
            ),
            ElevatedButton(
                onPressed: () async {
                  String oldpsd = oldPsdController.text;
                  String newpsd = newPsdController.text;
                  changePassword(oldpsd, newpsd);
                  oldPsdController.text = '';
                  newPsdController.text = '';
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Password successfully changed")));
                },
                child: const Text("Submit")),
          ]),
        ),
      ),
    );
  }
}
