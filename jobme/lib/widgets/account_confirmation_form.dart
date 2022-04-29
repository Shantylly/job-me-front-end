import 'package:front/utils/validator.dart';
import 'package:front/constants/regex.dart';
import 'package:front/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:front/utils/snackbars.dart';

class AccountConfirmationForm extends StatefulWidget {
  const AccountConfirmationForm({Key? key}) : super(key: key);

  @override
  AccountcConfirmationFormState createState() =>
      AccountcConfirmationFormState();
}

class AccountcConfirmationFormState extends State<AccountConfirmationForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _code = TextEditingController();

  void _confirm() async {
    Map<String, dynamic>? user = ModalRoute.of(context)!.settings.arguments
        as Map<String,
            dynamic>?; // Should be check and managed at the beginning
    if (user == null) {
      return Navigator.pop(context);
    }

    String type = mailRegex.hasMatch(user['id']!) ? "email" : "phone";
    String url = user['isApplicant'] as bool
        ? "applicant/register/confirmation/$type"
        : "company/register/confirmation/$type";

    try {
      await API.post(url, {type: user['id'], 'code': _code.text});
      showSuccessfulMessage(context: context, content: "Account activated.");
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      showErrorMessage(context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 50, maxWidth: 300),
      child: Row(
        children: [
          Expanded(
            child: Form(
              key: _key,
              child: TextFormField(
                  controller: _code,
                  validator: defaultValidator,
                  decoration:
                      const InputDecoration(labelText: 'Code de confirmation')),
            ),
          ),
          const SizedBox(width: 25),
          ElevatedButton(
              onPressed: () {
                if (_key.currentState!.validate()) {
                  _confirm();
                }
              },
              child: const Center(
                child: Text("Confirm"),
              ))
        ],
      ),
    );
  }
}
