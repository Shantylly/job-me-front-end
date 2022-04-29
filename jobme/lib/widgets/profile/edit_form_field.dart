import 'package:flutter/material.dart';

class EditFormField extends StatelessWidget {
  const EditFormField(
      {Key? key,
      required this.formText,
      required this.controller,
      required this.validator,
      this.line,
      this.length})
      : super(key: key);

  final String formText;
  final TextEditingController controller;
  final int? line;
  final int? length;
  final Function validator;

  @override
  Widget build(BuildContext context) {
    return (TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: formText,
          alignLabelWithHint: true,
          border: const OutlineInputBorder(),
        ),
        maxLines: line ?? 1,
        maxLength: length,
        keyboardType: TextInputType.multiline,
        validator: (value) => validator(value)));
  }
}
