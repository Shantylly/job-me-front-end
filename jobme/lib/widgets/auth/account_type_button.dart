import 'package:flutter/material.dart';
import 'package:front/constants/colors.dart';

class AccountTypeButton extends StatelessWidget {
  const AccountTypeButton(
      {Key? key, required this.update, required this.isApplicant})
      : super(key: key);
  final ValueChanged<bool> update;
  final bool isApplicant;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(
          child: ElevatedButton.icon(
        icon: const Icon(Icons.account_circle_outlined, color: Colors.black),
        onPressed: () => update(true),
        label: const Text("Jobbeur", style: TextStyle(color: Colors.black)),
        style: ElevatedButton.styleFrom(
          primary: isApplicant ? validateButton : Colors.white,
          minimumSize: const Size(150, 50),
        ),
      )),
      const SizedBox(width: 80.0),
      Expanded(
          child: ElevatedButton.icon(
        icon: const Icon(Icons.corporate_fare, color: Colors.black),
        onPressed: () => update(false),
        label: const Text("Compagnie", style: TextStyle(color: Colors.black)),
        style: ElevatedButton.styleFrom(
          primary: isApplicant ? Colors.white : validateButton,
          minimumSize: const Size(150, 50),
        ),
      ))
    ]);
  }
}
