import 'package:front/models/user.dart';

class Offer {
  // Should contain a reference to a company (owner)
  Offer(
      {required this.id,
      required this.title,
      required this.description,
      this.company,
      this.geolocation,
      this.studyLevel,
      this.contract,
      this.cut,
      this.convoyed,
      this.begin,
      this.skills,
      this.hoursWeek,
      this.emailExtra,
      this.salary,
      this.slots = 1});

  User? company;
  String id;
  String title;
  String description;
  String? geolocation;
  String? studyLevel;
  String? contract;
  bool? cut;
  bool? convoyed;
  String? begin;
  List<dynamic>? skills; // Should be string
  String? hoursWeek;
  String? emailExtra;
  int? salary;
  int? slots;

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json["_id"],
      title: json["title"],
      description: json["description"],
      company:
          json.containsKey('company') ? User.fromJson(json['company']) : null,
      geolocation: json.containsKey('geolocation') ? json["geolocation"] : null,
      studyLevel: json.containsKey('studyLevel') ? json["studyLevel"] : null,
      contract: json.containsKey('contract') ? json["contract"] : null,
      cut: json.containsKey('cut') ? json["cut"] : null,
      convoyed: json.containsKey('convoyed') ? json["convoyed"] : null,
      begin: json.containsKey('begin') ? json["begin"] : null,
      skills: json.containsKey('skills') ? json["skills"] : null,
      hoursWeek: json.containsKey('hoursWeek') ? json["hoursWeek"] : null,
      emailExtra: json.containsKey('emailExtra') ? json["emailExtra"] : null,
      salary: json.containsKey('salary') ? json["salary"] : null,
      slots: json.containsKey('slots') ? json["slots"] : null,
    );
  }
}
