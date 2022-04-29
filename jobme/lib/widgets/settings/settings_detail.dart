import 'package:flutter/material.dart';
import 'package:front/provider/settings.dart';
import 'package:front/widgets/settings/change_password.dart';
import 'package:front/widgets/settings/delete_account.dart';
import 'package:front/widgets/settings/log_out.dart';
import 'package:provider/provider.dart';

class SettingDetail extends StatelessWidget {
  const SettingDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 3, top: 23, bottom: 30, right: 30),
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
      constraints: const BoxConstraints(maxWidth: 1000, minWidth: 400),
      height: MediaQuery.of(context).size.height,
      child: _settingsDetail(context),
    );
  }

  Widget _settingsDetail(BuildContext context) {
    switch (context.watch<Settings>().whichKey()) {
      case "[<2>]":
        return const Text("Politique de confidentialité.");
      case "[<3>]":
        return const Text("Mention légales.");
      case "[<4>]":
        return const Text("Conditions générales d'utilisation.");
      case "[<5>]":
        return const LogOut();
      case "[<6>]":
        return const DeleteAccount();
      default:
        return const ChangePassword();
    }
  }
}
