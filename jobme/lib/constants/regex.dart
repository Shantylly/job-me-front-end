// In this file are the different regexp constants used in the app

// Regexp used for authentification purposes

// Regexep to check if the phone is valid phone number

final RegExp phoneRegex = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
//r'^((+|00)?218|0?)?(9[0-9]{8})$'

// Regexp to check if the mail is a valid email adress

final RegExp mailRegex = RegExp(
    r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
