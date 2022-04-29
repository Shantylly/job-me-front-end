import 'package:flutter/material.dart';
import 'package:front/widgets/settings/settings_card.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 3, top: 0, left: 20, bottom: 30),
      padding: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
      ),
      width: 400,
      height: MediaQuery.of(context).size.height - 163, //FIX
      child: Column(
        children: const [
          SettingsCard(
            key: ValueKey(1),
            parameter: "Changer de mot de passe",
            icon: Icons.security,
          ),
          SettingsCard(
            key: ValueKey(2),
            parameter: "Politique de confidentialité",
          ),
          SettingsCard(
            key: ValueKey(3),
            parameter: "Mentions légales",
          ),
          SettingsCard(
            key: ValueKey(4),
            parameter: "Conditions générales d'utilisation",
          ),
          SettingsCard(
            key: ValueKey(5),
            parameter: "Se déconnecter",
            icon: Icons.logout,
          ),
          SettingsCard(
            key: ValueKey(6),
            parameter: "Supprimer le compte",
            icon: Icons.delete,
          ),
        ],
      ),
    );
  }
}
