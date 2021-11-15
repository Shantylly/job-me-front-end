import 'dart:convert';

// Offer Data Class

OfferData OfferDataFromJson(String str) => OfferData.fromJson(json.decode(str));

String OfferDataToJson(OfferData data) => json.encode(data.toJson());

class OfferData {
  OfferData({
    required this.name,
    required this.desc,
    required this.contract,
    required this.salary,
  });

  String name;
  String desc;
  String contract;
  String salary;

  factory OfferData.fromJson(Map<String, dynamic> json) => OfferData(
        name: json["message"],
        desc: json["offer"],
        contract: json["contract"],
        salary: json["salary"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "desc": desc,
        "contract": contract,
        "salary": salary,
      };
}

// Jobbeur Data Class

JobberData JobberDataFromJson(String str) =>
    JobberData.fromJson(json.decode(str));

String JobberDataToJson(JobberData data) => json.encode(data.toJson());

class JobberData {
  JobberData({
    this.firstName = "your",
    this.lastName = "name",
    this.desc = "null",
    this.star = 0,
  });

  String firstName;
  String lastName;
  String desc;
  int star;

  factory JobberData.fromJson(Map<String, dynamic> json) => JobberData(
        firstName: json["firstName"],
        lastName: json["lastName"],
        desc: json["description"],
        star: json["star"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "description": desc,
        "star": star,
      };
}

// Company Data Class

CompanyData CompanyDataFromJson(String str) =>
    CompanyData.fromJson(json.decode(str));

String CompanyDataToJson(JobberData data) => json.encode(data.toJson());

class CompanyData {
  CompanyData({
    this.name = 'company',
    this.desc = "what's your company doing",
    this.siret = "siret number here",
    this.star = 0,
  });

  String name;
  String desc;
  String siret;
  int star;

  factory CompanyData.fromJson(Map<String, dynamic> json) => CompanyData(
        name: json["name"],
        desc: json["description"],
        siret: json["siret"],
        star: json["star"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": desc,
        "siret": siret,
        "star": star,
      };
}
