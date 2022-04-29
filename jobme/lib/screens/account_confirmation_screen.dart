import 'package:front/widgets/account_confirmation_form.dart';
import 'package:flutter/material.dart';

class AccountConfirmationScreen extends StatelessWidget {
  const AccountConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: AccountConfirmationForm(),
      ),
    );
  }
}
