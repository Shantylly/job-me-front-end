import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jobme/authentification/login.dart';
import 'package:jobme/profile/user_class.dart';
import 'package:http/http.dart' as http;
import 'package:jobme/utils/star_display.dart';
import 'package:jobme/utils/space.dart';

class JobbeurProfile extends StatefulWidget {
  const JobbeurProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<JobbeurProfile> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  late Future<JobberData> jobbeurData;

  Future<JobberData> getJobbeurData() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/applicant/retrieve'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      return JobberData.fromJson(jsonDecode(response.body)["applicant"]);
    } else {
      print(response.body);
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    jobbeurData = getJobbeurData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile"),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/dashboard_jobbeur');
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              isJobbeur = true;
              Navigator.pushReplacementNamed(context, '/settings');
            },
            icon: const Icon(
              Icons.settings,
              size: 20,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: FutureBuilder<JobberData>(
        future: jobbeurData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      snapshot.data!.firstName + " " + snapshot.data!.lastName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    space(10),
                    StarDisplay(value: snapshot.data!.star),
                    space(10),
                    Text(
                      snapshot.data!.desc,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                    space(30),
                    TextField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Edit first name here'),
                      controller: firstnameController,
                    ),
                    space(10),
                    TextField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Edit last name here'),
                      controller: lastnameController,
                    ),
                    space(10),
                    TextField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Edit your bio here'),
                      controller: descController,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          String fname = firstnameController.text;
                          String lname = lastnameController.text;
                          String desc = descController.text;
                          JobberData user =
                              await editProfile(fname, lname, desc);
                          firstnameController.text = '';
                          lastnameController.text = '';
                          descController.text = '';
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const JobbeurProfile()));
                        },
                        child: const Text("Submit"))
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  Future<JobberData> editProfile(
      String fname, String lname, String desc) async {
    print(token);
    var response = await http.put(
      Uri.parse('http://10.0.2.2:8080/applicant/modify'),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {"firstName": fname, "lastName": lname, "description": desc},
    );
    print(response.body);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Profile edited")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Missing arguments")));
    }
    return (JobberData(firstName: fname, lastName: lname, desc: desc));
  }
}
