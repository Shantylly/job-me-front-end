import 'package:flutter/material.dart';
import 'package:front/constants/colors.dart';
import 'package:front/services/api_service.dart';
import 'package:front/utils/exceptions.dart';
import 'package:front/utils/local_storage.dart';
import 'package:front/utils/snackbars.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400, minWidth: 200),
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Êtes-vous sûr de vouloir supprimer votre compte ?\nCette action est irréversible.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () => _accountDelete(context),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(secondColor)),
              child: const Text(
                'Supprimer le compte',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _accountDelete(BuildContext context) async {
    try {
      await API.delete("${LocalStorage.getString('type')}/delete");
      showSuccessfulMessage(
          context: context,
          content: "Votre compte a été supprimé avec succès.");
      LocalStorage.setString('jwt', '');
      LocalStorage.setString('type', '');
      Navigator.pushReplacementNamed(context, '/login');
    } on AuthorizationException {
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      showErrorMessage(context: context, content: 'Une erreur est survenue.');
    }
  }
}
