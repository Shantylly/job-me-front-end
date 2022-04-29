import 'package:flutter/material.dart';
import 'package:front/models/offer.dart';
import 'package:front/services/api_service.dart';
import 'package:front/utils/snackbars.dart';
import 'package:front/utils/validator.dart';

class OfferForm extends StatefulWidget {
  const OfferForm({Key? key, this.offer}) : super(key: key);
  final Offer? offer;
  @override
  _OfferFormState createState() => _OfferFormState();
}

class _OfferFormState extends State<OfferForm> {
  late final bool isNull;
  final InputDecoration _decoration = InputDecoration(
      // Dirty
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(),
        borderRadius: BorderRadius.circular(5),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(),
        borderRadius: BorderRadius.circular(5),
      ),
      errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(),
          borderRadius: BorderRadius.circular(5)));

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  void initState() {
    super.initState();
    isNull = widget.offer == null ? true : false;
    if (!isNull) {
      _title.text = widget.offer!.title;
      _description.text = widget.offer!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 1000,
      height: isNull ? double.infinity : 500,
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Titre",
                    style: TextStyle(fontSize: 15),
                  )),
              const SizedBox(height: 10),
              TextFormField(
                validator: defaultValidator,
                controller: _title,
                decoration: _decoration,
              ),
              const SizedBox(height: 50), // Could use expanded
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Description",
                    style: TextStyle(fontSize: 15),
                  )),
              const SizedBox(height: 10),
              TextFormField(
                validator: defaultValidator,
                controller: _description,
                decoration: _decoration,
                maxLines: 5,
                maxLength: 3500,
              ),
              const SizedBox(height: 50),
              Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 100,
                    height: 30,
                    child: ElevatedButton(
                        onPressed: isNull ? _create : _modify,
                        child: Text(isNull ? 'Créer' : 'Modifier',
                            style: const TextStyle(fontSize: 15))),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void _create() async {
    if (!_key.currentState!.validate()) {
      return;
    }
    try {
      await API.post('offer/create',
          {'title': _title.text, 'description': _description.text});
      showSuccessfulMessage(context: context, content: "Offre créé");
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    } catch (e) {
      showErrorMessage(context: context);
    }
  }

  void _modify() async {
    if (!_key.currentState!.validate()) {
      return;
    }
    try {
      await API.put('offer/modify/${widget.offer!.id}',
          {'title': _title.text, 'description': _description.text});
      showSuccessfulMessage(context: context, content: "Offre modifiée");
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/home', (Route<dynamic> route) => false); // Pas ouf
    } catch (e) {
      showErrorMessage(context: context);
    }
  }
}
