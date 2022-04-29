import 'package:flutter/material.dart';
import 'package:front/models/offer.dart';
import 'package:front/provider/offers.dart';
import 'package:front/services/api_service.dart';
import 'package:front/utils/snackbars.dart';
import 'package:front/widgets/offer/offer_form.dart';
import 'package:provider/provider.dart';
import 'package:front/utils/local_storage.dart';

class OfferCard extends StatefulWidget {
  const OfferCard({Key? key, required this.offer}) : super(key: key);
  final Offer offer;

  @override
  _OfferCardState createState() => _OfferCardState();
}

class _OfferCardState extends State<OfferCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListTile(
        trailing: LocalStorage.getString('type') == "company"
            ? PopupMenuButton(
                itemBuilder: (context) => [
                      PopupMenuItem(
                          child: GestureDetector(
                              child: const Text("Modify"), onTap: _modify)),
                      PopupMenuItem(
                        child: const Text("Delete"),
                        onTap: _delete,
                      )
                    ])
            : null,
        tileColor: Colors.white,
        selected: context.watch<Offers>().isSelected(widget.offer),
        selectedTileColor: Colors.blue[50],
        onTap: () => Provider.of<Offers>(context, listen: false)
            .setSelected(widget.offer),
        leading: const Icon(
          Icons.person_outline,
          size: 35,
        ),
        title: Text(widget.offer.title,
            style: TextStyle(
                color: Colors.blue[800], fontWeight: FontWeight.bold)),
        subtitle: Text(widget.offer.company!.name +
            ' ' +
            widget
                .offer.company!.geolocation), // Reset DB then use true values.
      ),
    );
  }

  void _delete() {
    try {
      API.delete('offer/delete/${widget.offer.id}');
      Provider.of<Offers>(context, listen: false).removeOffer(widget.offer);
      showSuccessfulMessage(context: context, content: "Offre supprimée");
    } catch (e) {
      showErrorMessage(context: context);
    }
  }

  void _modify() {
    Navigator.pop(context); // Close Popup Menu
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context, 'Cancel'),
              ),
            ),
            content: OfferForm(offer: widget.offer),
          );
        });
  }
}
