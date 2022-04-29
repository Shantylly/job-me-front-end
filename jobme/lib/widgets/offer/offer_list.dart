import 'package:flutter/material.dart';
import 'package:front/widgets/offer/offer_card.dart';
import 'package:front/models/offer.dart';
import 'package:front/provider/offers.dart';
import 'package:provider/provider.dart';
import 'package:front/services/api_service.dart';
import 'package:front/utils/local_storage.dart';

class OfferList extends StatefulWidget {
  const OfferList({Key? key}) : super(key: key);

  @override
  _OfferListState createState() => _OfferListState();
}

class _OfferListState extends State<OfferList> {
  late Future<List<Offer>> _offers;

  @override
  void initState() {
    super.initState();
    _offers = LocalStorage.getString('type') == "applicant"
        ? fetchAllOffers()
        : fetchCompanyOffers();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          const BoxConstraints(maxWidth: 500, minHeight: double.infinity),
      child: FutureBuilder<List<Offer>>(
        future: _offers,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Offer> offers = context.watch<Offers>().offers;
            return ListView.builder(
                itemCount: offers.length,
                itemBuilder: (BuildContext context, int i) {
                  return (OfferCard(offer: offers[i]));
                });
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<List<Offer>> fetchAllOffers() async {
    List<Offer> offers = [];
    try {
      final Map<String, dynamic> body = await API.get("offer/retrieve-all");
      for (Map<String, dynamic> offer in body["offers"]) {
        offers.add(Offer.fromJson(offer));
      }
      Provider.of<Offers>(context, listen: false).setOffers(offers);
      offers.isEmpty
          ? null
          : Provider.of<Offers>(context, listen: false).setSelected(offers[0]);
      return offers;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Offer>> fetchCompanyOffers() async {
    List<Offer> offers = [];
    try {
      final List<dynamic> body = await API.get("company/retrieve/offers");
      for (Map<String, dynamic> offer in body) {
        offers.add(Offer.fromJson(offer));
      }
      Provider.of<Offers>(context, listen: false).setOffers(offers);
      offers.isEmpty
          ? null
          : Provider.of<Offers>(context, listen: false).setSelected(offers[0]);
      return offers;
    } catch (e) {
      rethrow;
    }
  }
}
