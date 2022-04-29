import 'package:flutter/material.dart';
import 'package:front/constants/colors.dart';
import 'package:front/models/user.dart';
import 'package:front/services/api_service.dart';
import 'package:front/utils/exceptions.dart';
import 'package:front/utils/local_storage.dart';
import 'package:front/utils/snackbars.dart';
import 'package:front/utils/validator.dart';
import 'package:front/widgets/profile/edit_form_field.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key, required this.user, required this.callback})
      : super(key: key);

  final User user;
  final Function callback;

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _geolocation = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late bool _isApplicant;
  late String name = "Prénom";
  late String siret = "Nom";

  @override
  void initState() {
    super.initState();
    _isApplicant = LocalStorage.getString('type') == "applicant" ? true : false;
    _geolocation.text = widget.user.geolocation;
    _description.text = widget.user.description;
    if (_isApplicant == true) {
      _firstName.text = widget.user.firstName;
      _lastName.text = widget.user.lastName;
    } else {
      _firstName.text = widget.user.name;
      _lastName.text = widget.user.siret;
      name = "Nom de la compagnie";
      siret = "Siret";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SizedBox(
        width: 800,
        height: 800,
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
              child: const Text("Modifier son profil"),
            ),
            EditFormField(
                formText: name,
                controller: _firstName,
                validator: emptyValidator),
            EditFormField(
                formText: siret,
                controller: _lastName,
                validator: emptyValidator),
            EditFormField(
                formText: "Localisation",
                controller: _geolocation,
                validator: emptyValidator),
            EditFormField(
                formText: "Biographie",
                controller: _description,
                line: 5,
                length: 500,
                validator: emptyValidator),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(validateButton)),
                onPressed: () {
                  if (_formKey.currentState!.validate() == true) {
                    _editProfile();
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

  void _editProfile() async {
    if (_isApplicant == true) {
      widget.user.firstName = _firstName.text;
      widget.user.lastName = _lastName.text;
    } else {
      widget.user.name = _firstName.text;
      widget.user.siret = _lastName.text;
    }
    widget.user.geolocation = _geolocation.text;
    widget.user.description = _description.text;
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
