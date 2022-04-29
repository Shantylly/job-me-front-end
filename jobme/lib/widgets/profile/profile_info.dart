import 'package:flutter/material.dart';
import 'package:front/constants/colors.dart';
import 'package:front/models/user.dart';
import 'package:front/services/api_service.dart';
import 'package:front/utils/local_storage.dart';
import 'package:front/utils/snackbars.dart';
import 'package:front/widgets/profile/edit_id.dart';
import 'package:front/widgets/profile/edit_profile.dart';
import 'package:front/utils/phone_case.dart';
import 'package:front/widgets/profile/star_display.dart';

class DisplayProfile extends StatefulWidget {
  const DisplayProfile({Key? key}) : super(key: key);

  @override
  _DisplayProfileState createState() => _DisplayProfileState();
}

class _DisplayProfileState extends State<DisplayProfile> {
  late Future<User> _user;
  late bool _isApplicant;

  @override
  void initState() {
    super.initState();
    _isApplicant = LocalStorage.getString('type') == "applicant" ? true : false;
    _user = _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: _user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final User user = snapshot.data!;
          String phone = phoneCase(user.phone.toString());
          return SingleChildScrollView(
              child: Container(
            height: MediaQuery.of(context).size.height + 200,
            margin: const EdgeInsets.fromLTRB(40.0, 50.0, 40.0, 0),
            padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  padding: const EdgeInsets.only(top: 0, left: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () => _editProfile(user),
                        icon: const Icon(Icons.edit),
                      ),
                      Row(
                        verticalDirection: VerticalDirection.up,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: primaryColor,
                            child: ClipOval(
                              child: Image.asset(
                                'assets/jobme.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _isApplicant
                                  ? Text(
                                      "\nPrénom: ${user.firstName} \n\nNom: ${user.lastName}\n\nLocalisation: ${user.geolocation}\n",
                                      style: const TextStyle(fontSize: 18.0),
                                    )
                                  : Text(
                                      "Nom: ${user.name} \nSiret: ${user.siret}\nLocalisation: ${user.geolocation}\n",
                                      style: const TextStyle(fontSize: 18.0),
                                    ),
                            ],
                          ),
                          const SizedBox(width: 200),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StarDisplay(value: user.star),
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: "Email: ${user.email}",
                                    style: const TextStyle(fontSize: 18.0),
                                  ),
                                  WidgetSpan(
                                    child: IconButton(
                                        onPressed: () => _editId(user),
                                        icon: const Icon(Icons.edit, size: 16)),
                                  ),
                                  TextSpan(
                                    text: "\nTéléphone: (+33)$phone",
                                    style: const TextStyle(fontSize: 18.0),
                                  ),
                                  WidgetSpan(
                                    child: IconButton(
                                        onPressed: () => _editId(user),
                                        icon: const Icon(Icons.edit, size: 16)),
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  padding: const EdgeInsets.all(20),
                  child: _isApplicant
                      ? infoList(user)
                      : Text(
                          "Description: ${user.description}\n",
                          style: const TextStyle(fontSize: 20),
                        ),
                ),
              ],
            ),
          ));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget infoList(User user) {
    return ListView(
      shrinkWrap: true,
      children: [
        const Text("Biographie:\n", style: TextStyle(fontSize: 20)),
        Text(user.description, style: const TextStyle(fontSize: 16)),
        const Text("\nExpériences:\n", style: TextStyle(fontSize: 20)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(user.experiences!.length, (index) {
            return Text(
                "- ${user.experiences?[index]['title']} chez ${user.experiences?[index]['company']}\n   Du: ${user.experiences?[index]['begin']}\n   Au: ${user.experiences?[index]['end']}\n",
                style: const TextStyle(fontSize: 16));
          }),
        ),
        const Text("\nDiplômes:\n", style: TextStyle(fontSize: 20)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(user.educations!.length, (index) {
            return Text(
              "- ${user.educations?[index]['title']} chez ${user.educations?[index]['school']}\n   Du: ${user.educations?[index]['begin']}\n   Au: ${user.educations?[index]['end']}\n${user.educations?[index]['description']}\n",
              style: const TextStyle(fontSize: 16),
            );
          }),
        ),
        const Text("\nCompétences:\n", style: TextStyle(fontSize: 20)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(user.skills!.length, (index) {
            return Text(
              "- ${user.skills?[index]}\n",
              style: const TextStyle(fontSize: 16),
            );
          }),
        ),
        const Text("\nLangues:\n", style: TextStyle(fontSize: 20)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(user.languages!.length, (index) {
            return Text(
              "- ${user.languages?[index]["language"]} : ${user.languages?[index]["level"]}\n",
              style: const TextStyle(fontSize: 16),
            );
          }),
        ),
      ],
    );
  }

  void _updateinfo() {
    setState(() {});
  }

  void _editId(User user) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: EditId(user: user, callback: _updateinfo),
        );
      },
    );
  }

  void _editProfile(User user) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: EditProfile(user: user, callback: _updateinfo),
        );
      },
    );
  }

  Future<User> _getUserData() async {
    try {
      Map<String, dynamic> body =
          await API.get("${LocalStorage.getString('type')}/retrieve");
      return User.fromJson(body[LocalStorage.getString('type')]);
    } catch (e) {
      showErrorMessage(context: context, content: 'Une erreur est survenue.');
      rethrow;
    }
  }
}
