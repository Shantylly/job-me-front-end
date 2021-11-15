import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jobme/profile/user_class.dart';
import 'package:jobme/authentification/login.dart';
import 'package:http/http.dart' as http;
import 'package:jobme/utils/star_display.dart';
import 'package:jobme/utils/space.dart';

class CompanyProfile extends StatefulWidget {
  const CompanyProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<CompanyProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController siretController = TextEditingController();
  late Future<CompanyData> companyData;

  Future<CompanyData> getCompanyData() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/company/retrieve'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      print(response.body);
      return CompanyData.fromJson(jsonDecode(response.body)["company"]);
    } else {
      print(response.body);
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    companyData = getCompanyData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile"),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/dashboard_company');
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
              isJobbeur = false;
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
      body: FutureBuilder<CompanyData>(
        future: companyData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        snapshot.data!.name,
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
                      Text(
                        "\nSiret: " + snapshot.data!.siret,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                        ),
                      ),
                      space(30),
                      TextField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Edit company name here'),
                        controller: nameController,
                      ),
                      space(10),
                      TextField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Edit company description here'),
                        controller: descController,
                      ),
                      space(10),
                      TextField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Edit company siret here'),
                        controller: siretController,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            String name = nameController.text;
                            String desc = descController.text;
                            String siret = siretController.text;
                            CompanyData user =
                                await editProfile(name, desc, siret);
                            nameController.text = '';
                            descController.text = '';
                            siretController.text = '';
                            getCompanyData();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CompanyProfile()));
                          },
                          child: const Text("Submit"))
                    ],
                  ),
                ));
          } else if (snapshot.hasError) {
            editProfile("Company name", "desc", "siret");
            return Text('${snapshot.error}\n please refresh the page');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  Future<CompanyData> editProfile(
      String name, String desc, String siret) async {
    var response = await http.put(
      Uri.parse('http://10.0.2.2:8080/company/modify'),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {"name": name, "description": desc, "siret": siret},
    );
    print(response.body);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Profile edited")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Missing arguments")));
    }
    return (CompanyData(name: name, desc: desc, siret: siret));
  }
}
