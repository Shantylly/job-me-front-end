import 'package:flutter/foundation.dart';
import 'package:front/models/offer.dart';

class Offers extends ChangeNotifier {
  List<Offer> _offers = [];
  Offer? _selected;

  List<Offer> get offers => _offers;
  Offer? get selected => _selected;

  void setSelected(Offer offer) {
    _selected = offer;
    notifyListeners();
  }

  void removeOffer(Offer offer) {
    offer == _selected ? _selected = null : null;
    _offers.remove(offer);
    notifyListeners();
  }

  void setOffers(List<Offer> offers) {
    _offers = offers;
  }

  bool isSelected(Offer offer) {
    if (_selected != null && offer == _selected) {
      return true;
    } else {
      return false;
    }
  }
}
