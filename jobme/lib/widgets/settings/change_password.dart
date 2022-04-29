import 'package:flutter/material.dart';
import 'package:front/constants/colors.dart';
import 'package:front/services/api_service.dart';
import 'package:front/utils/exceptions.dart';
import 'package:front/utils/local_storage.dart';
import 'package:front/utils/snackbars.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController oldPwd = TextEditingController();
  final TextEditingController newPwd = TextEditingController();
  final TextEditingController confirmPwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400, minWidth: 200),
      padding: const EdgeInsets.only(top: 17, left: 20, right: 20),
      child: Wrap(
        alignment: WrapAlignment.center,
        runSpacing: 30,
        children: [
          const Text(
            "Modifier le mot de passe",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextFormField(
            controller: oldPwd,
            decoration: const InputDecoration(
                labelText: "Old password",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.password)),
            obscureText: true,
          ),
          TextFormField(
            controller: newPwd,
            decoration: const InputDecoration(
                labelText: "New password",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.password)),
            obscureText: true,
          ),
          TextFormField(
            controller: confirmPwd,
            decoration: const InputDecoration(
                labelText: "Confirm new password",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.password)),
            obscureText: true,
          ),
          ElevatedButton(
            onPressed: () => _changePassword(),
            child: const Text("Modifier le mot de passe."),
          )
        ],
      ),
    );
  }

  void _changePassword() async {
    try {
      await API.put(
        "${LocalStorage.getString('type')}/modify/password",
        {"password": oldPwd.text, "newPassword": newPwd.text},
      );
      showSuccessfulMessage(
          context: context, content: "Mot de passe modifié avec succès.");
      oldPwd.text = "";
      newPwd.text = "";
      confirmPwd.text = "";
    } on AuthorizationException {
      Navigator.pushReplacementNamed(context, '/login');
    } catch (err) {
      showErrorMessage(context: context, content: 'Une erreur est survenue.');
    }
  }
}
