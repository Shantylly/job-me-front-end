import 'package:front/constants/regex.dart';
import 'package:front/utils/phone_case.dart';

String? defaultValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Ce champ est vide.';
  } else {
    return null;
  }
}

String? idValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Ce champ est vide.';
  }

  if (mailRegex.hasMatch(value)) {
    return null;
  } else {
    String phone = value;
    phone = phone.replaceAll(RegExp(r' '), '');
    if (phone.length != 11) {
      phone = phone.replaceFirst(RegExp(r'0'), '33');
    }
    if (phone.length == 11 && phoneRegex.hasMatch(phone)) {
      return null;
    }
  }
  return "Téléphone ou mail non valide.";
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Ce champ est vide.';
  }
  // if (value.length < 8) {
  //   return "Le mot de passe doit être supérieur ou égal à 8 caractères.";
  // }
  return null;
}

String? emptyValidator(String? value) {
  //Dirty, to change later
  return null;
}

String? emailValidator(String? value) {
  if (value == null) {
    return null;
  } else if (mailRegex.hasMatch(value) || value == '') {
    return null;
  } else {
    return 'Email incorrect.';
  }
}

String? phoneValidator(String? value) {
  if (value == null) {
    return null;
  }
  if (value.isNotEmpty) {
    value = invertPhoneCase(value).toString();
  } else if (phoneRegex.hasMatch(value) || value == '' || value == '33') {
    return null;
  } else {
    return 'Numéro de téléphone incorrect.';
  }
}
