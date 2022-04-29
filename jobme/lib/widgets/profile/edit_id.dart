import 'package:flutter/material.dart';
import 'package:front/constants/colors.dart';
import 'package:front/models/user.dart';
import 'package:front/services/api_service.dart';
import 'package:front/utils/exceptions.dart';
import 'package:front/utils/local_storage.dart';
import 'package:front/utils/snackbars.dart';
import 'package:front/utils/validator.dart';
import 'package:front/widgets/profile/edit_form_field.dart';
import 'package:front/utils/phone_case.dart';

class EditId extends StatefulWidget {
  const EditId({Key? key, required this.user, required this.callback})
      : super(key: key);

  final User user;
  final Function callback;

  @override
  _EditIdState createState() => _EditIdState();
}

class _EditIdState extends State<EditId> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _email.text = widget.user.email;
    _phone.text = phoneCase(widget.user.phone.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SizedBox(
        width: 300,
        height: 300,
        child: Wrap(
          runSpacing: 30,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(width: 1.0)),
              ),
              child: const Text("Modifier ses identifiants de connexion"),
            ),
            EditFormField(
                formText: "Email",
                controller: _email,
                validator: emailValidator),
            EditFormField(
                formText: "Phone",
                controller: _phone,
                validator: phoneValidator),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(validateButton)),
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      _checkUser() == true) {
                    _editId();
                  } else {
                    showErrorMessage(
                        context: context,
                        content:
                            'Vous devez renseigner au moins un email ou un numéro de téléphone.');
                  }
                },
                child: const Text(
                  'Appliquer',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _checkUser() {
    if (_email.text.isEmpty && (_phone.text.isEmpty || _phone.text == '33')) {
      return false;
    } else {
      return true;
    }
  }

  void _editId() async {
    widget.user.email = _email.text;
    if (_phone.text.isNotEmpty) {
      widget.user.phone = invertPhoneCase(_phone.text);
    } else {
      widget.user.phone = 33;
    }
    Map<String, dynamic> info = User.toJson(widget.user);
    try {
      await API.put("${LocalStorage.getString('type')}/modify", info);
      widget.callback();
      Navigator.pop(context);
    } on AuthorizationException {
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      showErrorMessage(context: context, content: 'Une erreur est survenue.');
    }
  }
}
