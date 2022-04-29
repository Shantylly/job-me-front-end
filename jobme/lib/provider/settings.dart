import 'package:flutter/foundation.dart';

class Settings extends ChangeNotifier {
  Key? _selected = const ValueKey(1);
  Key? get selected => _selected;

  void setSelected(Key? setting) {
    _selected = setting;
    notifyListeners();
  }

  bool isSelected(Key? setting) {
    if (_selected != null && setting == _selected) {
      return true;
    } else {
      return false;
    }
  }

  String whichKey() {
    return _selected.toString();
  }
}
