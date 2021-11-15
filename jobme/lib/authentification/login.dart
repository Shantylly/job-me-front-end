import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jobme/utils/space.dart';
import 'package:http/http.dart' as http;

String token = "null";
bool isJobbeur = true;

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key}) : super(key: key);

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.white,
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Top Text
                  Column(
                    children: <Widget>[
                      const Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      space(15),
                      Text(
                        "Login to your account",
                        style: TextStyle(fontSize: 15, color: Colors.grey[650]),
                      )
                    ],
                  ),
                  space(20),
                  // Email input
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.email)),
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                  ),
                  space(15),
                  // Password input
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.lock)),
                    obscureText: true,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    heightFactor: 2.0,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/forgot');
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          "Mot de passe oublié ?",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ),
                  space(25),
                  // Don't have an account ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Don't have an account ?"),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/register');
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            "Sign Up",
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
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      padding: const EdgeInsets.only(top: 0, left: 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: const Border(
                            bottom: BorderSide(color: Colors.black),
                            top: BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),
                          )),
                      child: MaterialButton(
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          login();
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
    );
  }

// API management

  Future<void> login() async {
    try {
      if (passwordController.text.isNotEmpty &&
          emailController.text.isNotEmpty) {
        var response = await http.post(
            Uri.parse('http://10.0.2.2:8080/applicant/login/email'),
            body: ({
              'email': emailController.text,
              'password': passwordController.text
            }));
        if (response.statusCode == 200) {
          print(response.body);
          token = fetchToken(response.body);
          isJobbeur = true;
          Navigator.pushReplacementNamed(context, '/dashboard_jobbeur');
        } else {
          var response = await http.post(
              Uri.parse('http://10.0.2.2:8080/company/login/email'),
              body: ({
                'email': emailController.text,
                'password': passwordController.text
              }));
          if (response.statusCode == 200) {
            print(response.body);
            token = fetchToken(response.body);
            isJobbeur = false;
            Navigator.pushReplacementNamed(context, '/dashboard_company');
          } else {
            print(response.body);
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Invalid mail or password")));
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Empty field not allowed")));
      }
    } catch (err) {}
  }
}

//Function "fetchToken" is to fetch token from response body

String fetchToken(String responseBody) {
  String res = responseBody;

  String result =
      res.replaceRange(res.indexOf('"m'), res.lastIndexOf(':"'), "");
  result = result.replaceAll(RegExp(':'), '');
  result = result.replaceAll(RegExp('"'), '');
  result = result.replaceAll(RegExp('{'), '');
  result = result.replaceAll(RegExp('}'), '');
  print(result);
  return (result);
}
