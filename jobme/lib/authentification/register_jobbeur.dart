import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jobme/authentification/login.dart';
import 'package:jobme/profile/dashboard_jobbeur.dart';
import 'package:http/http.dart' as http;
import 'package:jobme/utils/space.dart';

class JobbeurRegisterPage extends StatefulWidget {
  const JobbeurRegisterPage({Key? key}) : super(key: key);

  @override
  _MyRegisterPageState createState() => _MyRegisterPageState();
}

class _MyRegisterPageState extends State<JobbeurRegisterPage> {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  bool isPhone = false;
  String mailOrPhone = 'Email';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/register');
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: AutofillGroup(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Top Text
                    Column(
                      children: const <Widget>[
                        Text("Register",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                      ],
                    ),
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
                    // Email input
                    TextFormField(
                      controller: userController,
                      decoration: InputDecoration(
                          labelText: mailOrPhone + ' *',
                          border: const OutlineInputBorder(),
                          suffixIcon: const Icon(Icons.account_circle_rounded)),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    space(15),
                    TextFormField(
                      controller: firstnameController,
                      decoration: const InputDecoration(
                          labelText: "First name",
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.badge)),
                    ),
                    space(15),
                    TextFormField(
                      controller: lastnameController,
                      decoration: const InputDecoration(
                          labelText: "Last name",
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.badge_outlined)),
                    ),
                    space(15),
                    // Password input
                    TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                          labelText: "Password *",
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.lock)),
                      obscureText: true,
                    ),
                    space(25),
                    // Don't have an account ?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("Already have an account ?"),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    space(25),
                    // Login
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Container(
                        padding: const EdgeInsets.only(top: 0, left: 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            border: const Border(
                              bottom: BorderSide(color: Colors.black),
                              top: BorderSide(color: Colors.black),
                              left: BorderSide(color: Colors.black),
                              right: BorderSide(color: Colors.black),
                            )),
                        child: MaterialButton(
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            register();
                          },
                          minWidth: double.infinity,
                          height: 60,
                          color: const Color(0xff005267),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool emailValid(String email) {
    RegExp regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(email)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Invalid mail')));
      return false;
    }
    return true;
  }

  bool phoneValid(String phone) {
    RegExp regPhone = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
    phone = phone.replaceAll(RegExp(r' '), '');
    if (phone[0] == "0") {
      phone = phone.replaceFirst(RegExp(r'0'), '33');
    }
    if (phone.length != 11 || !regPhone.hasMatch(phone)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Invalid phone')));
      return false;
    }
    userController.text = phone;
    return true;
  }

  bool check() {
    if (passwordController.text.isEmpty || userController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Required field empty")));
      return (false);
    }
    if (isPhone == false) {
      return (emailValid(userController.text));
    } else {
      return (phoneValid(userController.text));
    }
  }

  Future<void> register() async {
    if (check() == true) {
      if (isPhone == true) {
        try {
          var response = await http.post(
              Uri.parse('http://10.0.2.2:8080/applicant/register/phone'),
              body: ({
                'phone': userController.text,
                'password': passwordController.text,
                'firstName': firstnameController.text,
                'lastName': lastnameController.text,
              }));
          if (response.statusCode == 200) {
            isJobbeur = true;
            token = fetchToken(response.body);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DashboardJobbeur()),
            );
          } else {
            print(response.body);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('An error occured while trying to register')));
          }
        } catch (err) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('An error occured while trying to register')));
        }
      } else {
        try {
          var response = await http.post(
              Uri.parse('http://10.0.2.2:8080/applicant/register/email'),
              body: ({
                'email': userController.text,
                'password': passwordController.text,
                'firstName': firstnameController.text,
                'lastName': lastnameController.text,
              }));
          if (response.statusCode == 200) {
            isJobbeur = true;
            token = fetchToken(response.body);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DashboardJobbeur()),
            );
          } else {
            print(response.body);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('An error occured while trying to register')));
          }
        } catch (err) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('An error occured while trying to register')));
        }
      }
    }
  }
}
