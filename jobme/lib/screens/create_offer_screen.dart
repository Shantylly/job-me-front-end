import 'package:flutter/material.dart';
import 'package:front/widgets/offer/offer_form.dart';

class CreateOfferScreen extends StatefulWidget {
  const CreateOfferScreen({Key? key}) : super(key: key);

  @override
  CreateOfferScreenState createState() => CreateOfferScreenState();
}

class CreateOfferScreenState extends State<CreateOfferScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: const Center(child: OfferForm()));
  }
}
