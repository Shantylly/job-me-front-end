import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PasswordForgotten extends StatefulWidget {
  const PasswordForgotten({Key? key}) : super(key: key);

  @override
  _PasswordForgottenState createState() => _PasswordForgottenState();
}

class _PasswordForgottenState extends State<PasswordForgotten> {
  TextEditingController mailController = TextEditingController();
  bool isPhone = false;
  String mailOrPhone = 'Email';

  forgotPassword(String email) async {
    if (isPhone == true) {
      try {
        var response = await http.post(
          Uri.parse('http://10.0.2.2:8080/applicant/password/forgot/phone'),
          body: {"phone": email},
        );
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("A message has been sent")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  "An error has occured, please verify your phone number")));
        }
      } catch (err) {}
    } else {
      try {
        var response = await http.post(
          Uri.parse('http://10.0.2.2:8080/applicant/password/forgot/email'),
          body: {"email": email},
        );
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("An email has been sent")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("An error has occured, please verify your mail")));
        }
      } catch (err) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
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
            Switch(
              value: isPhone,
              onChanged: (value) {
                print("is phone ? : $value");
                setState(() {
                  isPhone = value;
                  if (isPhone == true) {
                    mailOrPhone = "Phone";
                  } else {
                    mailOrPhone = "Email";
                  }
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: mailOrPhone + ' de récupération'),
              controller: mailController,
            ),
            ElevatedButton(
                onPressed: () {
                  forgotPassword(mailController.text);
                },
                child: const Text("Submit"))
          ]),
        ),
      ),
    );
  }
}
