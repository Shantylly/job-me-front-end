import 'package:flutter/material.dart';
import 'package:front/constants/colors.dart';
import 'package:front/constants/regex.dart';
import 'package:front/services/api_service.dart';
import 'package:front/utils/exceptions.dart';
import 'package:front/utils/snackbars.dart';
import 'package:front/utils/local_storage.dart';
import 'package:front/utils/validator.dart';
import 'package:front/widgets/auth/account_type_button.dart';
import 'package:front/widgets/auth/auth_form_field.dart';
import 'package:front/utils/phone_case.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _user = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isApplicant = true;

  void _update(bool isApplicant) {
    // Find a solution to avoid callbacks (New design would be great)
    setState(() {
      _isApplicant = isApplicant;
    });
  }

  void _login(BuildContext context) async {
    String value = _user.text;
    String type = mailRegex.hasMatch(_user.text) ? "email" : "phone";
    String url = _isApplicant ? "applicant/login/$type" : "company/login/$type";

    if (type == "phone") {
      value = invertPhoneCase(value).toString();
    }
    try {
      Map<String, dynamic> body =
          await API.post(url, {type: value, 'password': _password.text});
      LocalStorage.setString('jwt', body['accessToken']);
      LocalStorage.setString(
          'type',
          _isApplicant
              ? 'applicant'
              : 'company'); // This one should be get from the API.
      Navigator.pushNamed(context, '/home');
    } on PermissionException {
      Navigator.pushNamed(context, '/account/confirmation',
          arguments: {'id': value, 'isApplicant': _isApplicant});
    } catch (e) {
      showErrorMessage(context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 100, maxWidth: 550),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        AccountTypeButton(
          update: _update,
          isApplicant: _isApplicant,
        ),
        const SizedBox(height: 50),
        Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const Text(
                      "Se connecter",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Connexion à un compte existant",
                      style: TextStyle(fontSize: 15, color: Colors.grey[650]),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                // Identifier input
                AuthFormField(
                    formText: "Mail ou téléphone",
                    isObscure: false,
                    controller: _user,
                    icon: const Icon(Icons.mail),
                    validator: idValidator),
                const SizedBox(height: 15),
                // Password input
                AuthFormField(
                    formText: "Mot de passe",
                    isObscure: true,
                    controller: _password,
                    icon: const Icon(Icons.lock),
                    validator: passwordValidator),
                /*Align(
                  alignment: Alignment.center,
                  heightFactor: 2.0,
                  child: InkWell(
                    onTap: () {},
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
                ),*/
                const SizedBox(height: 25),
                // Don't have an account ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Vous n'avez pas de compte ?"),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          "S'inscrire",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                // Login
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    padding: const EdgeInsets.only(top: 0, left: 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: MaterialButton(
                      child: const Text(
                        "Se connecter",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _login(context);
                        }
                      },
                      minWidth: MediaQuery.of(context).size.width / 6,
                      height: 60,
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ]),
    );
  }
}
