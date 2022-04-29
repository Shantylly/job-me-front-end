import 'package:flutter/material.dart';

class OfferButton extends StatelessWidget {
  const OfferButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add, size: 30),
      onPressed: () => Navigator.pushNamed(
          context, '/create/offer'),
    );
  }
}
