import 'package:flutter/material.dart';

class AuthFormField extends StatelessWidget {
  const AuthFormField(
      {Key? key,
      required this.formText,
      required this.isObscure,
      required this.controller,
      required this.validator,
      this.icon})
      : super(key: key);

  final String formText;
  final bool isObscure;
  final TextEditingController controller;
  final Icon? icon;
  final Function validator;

  @override
  Widget build(BuildContext context) {
    return (TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: formText,
          border: const OutlineInputBorder(),
          suffixIcon: icon),
      obscureText: isObscure,
      validator: (value) => validator(value)
    ));
  }
}
