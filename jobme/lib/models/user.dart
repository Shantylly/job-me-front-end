class User {
  User(
      {required this.email,
      required this.phone,
      required this.description,
      required this.name,
      required this.firstName,
      required this.lastName,
      required this.siret,
      this.disponibilities,
      this.skills,
      required this.birthday,
      required this.studyLevel,
      required this.geolocation,
      required this.star,
      required this.picture,
      required this.cv,
      required this.video,
      required this.vital,
      required this.rib,
      this.educations,
      this.experiences,
      this.languages});

  String email;
  int phone;
  String description;
  String name;
  String firstName;
  String lastName;
  String siret;
  List<dynamic>? disponibilities;
  List<dynamic>? skills; // Should be string
  String birthday;
  String studyLevel;
  String geolocation;
  int star;
  String picture;
  String cv;
  String video;
  String vital;
  String rib;
  List<dynamic>? educations;
  List<dynamic>? experiences;
  List<dynamic>? languages;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json.containsKey('email') ? json['email'] : '',
      phone: json.containsKey('phone') ? json['phone'] : 33,
      description: json.containsKey('description') ? json["description"] : '',
      name: json.containsKey('name') ? json['name'] : '',
      siret: json.containsKey('siret') ? json['siret'] : '',
      firstName: json.containsKey('firstName') ? json['firstName'] : '',
      lastName: json.containsKey('lastName') ? json['lastName'] : '',
      disponibilities:
          json.containsKey('disponibilities') ? json["disponibilities"] : null,
      skills: json.containsKey('skills') ? json["skills"] : null,
      birthday: json.containsKey('birthday') ? json["birthday"] : '',
      studyLevel: json.containsKey('studyLevel') ? json["studyLevel"] : '',
      geolocation: json.containsKey('geolocation') ? json["geolocation"] : '',
      star: json.containsKey('star') ? json["star"] : null,
      picture: json.containsKey('picture') ? json["picture"] : '',
      cv: json.containsKey('cv') ? json["cv"] : '',
      video: json.containsKey('video') ? json["video"] : '',
      vital: json.containsKey('vital') ? json["vital"] : '',
      rib: json.containsKey('rib') ? json["rib"] : '',
      educations: json.containsKey('educations') ? json["educations"] : null,
      experiences: json.containsKey('experiences') ? json["experiences"] : null,
      languages: json.containsKey('languages') ? json["languages"] : null,
    );
  }

  static Map<String, dynamic> toJson(User user) => {
        "email": user.email,
        "phone": user.phone,
        "name": user.name,
        "firstName": user.firstName,
        "lastName": user.lastName,
        "description": user.description,
        "siret": user.siret,
        "star": user.star,
        "disponibilities": user.disponibilities,
        "skills": user.skills,
        "birthday": user.birthday,
        "studyLevel": user.studyLevel,
        "geolocation": user.geolocation,
        "picture": user.picture,
        "cv": user.cv,
        "video": user.video,
        "vital": user.vital,
        "rib": user.rib,
        "educations": user.educations,
        "experiences": user.experiences,
        "languages": user.languages,
      };
}
