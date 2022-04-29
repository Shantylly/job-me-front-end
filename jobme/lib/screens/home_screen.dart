import 'package:flutter/material.dart';
import 'package:front/widgets/home/home_app_bar.dart';
import 'package:front/widgets/offer/offer_button.dart';
import 'package:front/widgets/offer/offer_list.dart';
import 'package:front/widgets/offer/offer_overview.dart';
import 'package:provider/provider.dart';
import 'package:front/utils/local_storage.dart';
import 'package:front/provider/offers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Offers>(
      create: (_) => Offers(),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: const HomeAppBar(),
        body: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            OfferList(),
            Divider(
              color: Colors.black,
              indent: 1,
            ),
            OfferOverview()
          ],
        )),
        floatingActionButton: LocalStorage.getString('type') == 'company'
            ? const OfferButton()
            : null,
      ),
    );
  }
}
