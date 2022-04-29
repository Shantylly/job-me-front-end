//A function that convert +33XXXXXXXXX phone number into 0X XX XX XX XX

String phoneCase(String src) {
  List<String> dest = [];

  if (src.isEmpty) {
    return "33";
  }
  if (src != "33") {
    src = src.replaceAll(' ', '');
    if (src[0] == "3") {
      src = src.replaceFirst('33', '0');
    }
  }
  for (var e = 0; e < src.length; e++) {
    if (e % 2 == 0) {
      dest.add(' ');
    }
    dest.add(src[e]);
  }
  return (dest.join(""));
}

//A function that convert 0X XX XX XX XX phone number into +33XXXXXXXXX

int invertPhoneCase(String src) {
  if (src.isEmpty) {
    return (33);
  }
  src = src.replaceAll(' ', '');
  if (src[0] == "0") {
    src = src.replaceFirst('0', '33');
  }
  return int.parse(src);
}
