import 'package:flutter/material.dart';
import 'package:front/models/offer.dart';
import 'package:front/provider/offers.dart';
import 'package:front/services/api_service.dart';
import 'package:front/utils/exceptions.dart';
import 'package:front/utils/local_storage.dart';
import 'package:front/utils/snackbars.dart';
import 'package:provider/provider.dart';

class OfferOverview extends StatefulWidget {
  const OfferOverview({Key? key}) : super(key: key);

  @override
  _OfferOverviewState createState() => _OfferOverviewState();
}

class _OfferOverviewState extends State<OfferOverview> {
  @override
  Widget build(BuildContext context) {
    final Offer? offer = context.watch<Offers>().selected;
    return Container(
      constraints: const BoxConstraints(
          minWidth: 500, maxWidth: 500, minHeight: double.infinity),
      color: Colors.white,
      child: offer == null
          ? null
          : SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    offer.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  const SizedBox(height: 10),
                  Text(offer.company!.name + ' ' + offer.company!.geolocation),
                  const SizedBox(height: 10),
                  Text(offer.description),
                  const SizedBox(height: 20),
                  LocalStorage.getString('type') == "applicant"
                      ? ElevatedButton(
                          onPressed: () => _applyOffer(offer.id, offer.title),
                          child: const Text("Postuler"))
                      : const SizedBox.shrink(),
                ],
              ),
            ),
    );
  }

  void _applyOffer(String id, String title) async {
    try {
      await API.get('applicant/apply/$id');
      showSuccessfulMessage(
          context: context,
          content:
              "Votre candidature au poste de $title a bien été pris en compte.");
    } on AuthorizationException {
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      showErrorMessage(context: context, content: e.toString());
    }
  }
}
