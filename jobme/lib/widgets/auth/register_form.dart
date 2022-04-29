import 'package:front/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:front/constants/regex.dart';
import 'package:front/widgets/auth/account_type_button.dart';
import 'package:front/widgets/auth/auth_form_field.dart';
import 'package:front/services/api_service.dart';
import 'package:front/utils/snackbars.dart';
import 'package:front/utils/validator.dart';
import 'package:front/utils/phone_case.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _user = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isApplicant = true;
  String fieldName = "Prénom"; // FIX

  void _update(bool isApplicant) {
    setState(() {
      _isApplicant = isApplicant;
      _isApplicant ? fieldName = "Prénom" : fieldName = "Nom de la compagnie";
    });
  }

  void _register(BuildContext context) async {
    String value = _user.text;
    String type = mailRegex.hasMatch(_user.text) ? "email" : "phone";
    String url =
        _isApplicant ? "applicant/register/$type" : "company/register/$type";

    if (type == "phone") {
      value = invertPhoneCase(value).toString();
    }
    Map<String, String> body = _isApplicant
        ? {
            type: value,
            'password': _password.text,
            'firstName': _name.text,
            'lastName': _lastName.text
          }
        : {type: value, 'password': _password.text, 'name': _name.text};
    try {
      await API.post(url, body);
      Navigator.pushReplacementNamed(context, '/account/confirmation',
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Top Text
              Column(
                children: <Widget>[
                  const Text(
                    "S'inscrire",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Créer un nouveau compte",
                    style: TextStyle(fontSize: 15, color: Colors.grey[650]),
                  )
                ],
              ),
              const SizedBox(height: 20),
              // Email input
              AuthFormField(
                formText: "Email ou téléphone",
                isObscure: false,
                controller: _user,
                icon: const Icon(Icons.mail),
                validator: idValidator,
              ),
              const SizedBox(height: 15),
              AuthFormField(
                formText: fieldName,
                isObscure: false,
                controller: _name,
                icon: const Icon(Icons.account_circle),
                validator: defaultValidator,
              ),
              const SizedBox(height: 15),
              _isApplicant
                  ? AuthFormField(
                      formText: "Nom",
                      isObscure: false,
                      controller: _lastName,
                      icon: const Icon(Icons.account_circle),
                      validator: defaultValidator,
                    )
                  : const SizedBox(height: 15),
              // Password input
              const SizedBox(height: 15),
              AuthFormField(
                formText: "Mot de passe",
                isObscure: true,
                controller: _password,
                icon: const Icon(Icons.lock),
                validator: defaultValidator,
              ),
              const SizedBox(height: 25),
              // Already have an account ?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Vous avez déjà un compte ?"),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "Se connecter.",
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
              // Register
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  padding: const EdgeInsets.only(top: 0, left: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: MaterialButton(
                    child: const Text(
                      "S'inscrire",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      // FIX
                      if (_formKey.currentState!.validate()) {
                        _register(context);
                      }
                    },
                    minWidth: MediaQuery.of(context).size.width / 2,
                    height: 60,
                    color: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
