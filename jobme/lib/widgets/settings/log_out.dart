import 'package:flutter/material.dart';
import 'package:front/constants/colors.dart';
import 'package:front/utils/local_storage.dart';

class LogOut extends StatelessWidget {
  const LogOut({Key? key}) : super(key: key);

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
            const Text("Êtes-vous sûr de vouloir vous déconnecter ?"),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                LocalStorage.setString('type', '');
                LocalStorage.setString('jwt', '');
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(secondColor)),
              child: const Text(
                'Déconnexion',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
