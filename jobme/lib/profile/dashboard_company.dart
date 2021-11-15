import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jobme/company/job_adding.dart';
import 'package:jobme/company/job_remove.dart';
import 'package:jobme/offers/jobbeur_details.dart';
import 'package:jobme/authentification/login.dart';
import 'package:http/http.dart' as http;

class DashboardCompany extends StatefulWidget {
  const DashboardCompany({Key? key}) : super(key: key);

  @override
  _DashboardCompanyState createState() => _DashboardCompanyState();
}

class _DashboardCompanyState extends State<DashboardCompany> {
  TextEditingController searchController = TextEditingController();
  List _alljobbeurs = [];
  List _filteredjobbeurs = [];

  getJobbeurData() async {
    try {
      var response = await http.get(
        Uri.parse('http://10.0.2.2:8080/company/search/applicants'),
        headers: {'Authorization': 'Bearer $token'},
      );
      print(response.body);
      List jsonData = jsonDecode(response.body);
      setState(() {
        _alljobbeurs = jsonData;
      });
    } catch (err) {
      print(err);
    }
    print(_alljobbeurs.length);
    _filteredjobbeurs = _alljobbeurs;
    return _alljobbeurs;
  }

  @override
  void initState() {
    super.initState();
    getJobbeurData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: const Color(0xff005267),
              child: ClipOval(
                child: Image.asset(
                  'assets/jobme.png',
                  fit: BoxFit.fill,
                  height: 50,
                ),
              ),
            ),
          ],
        ),
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.white,
        actions: <Widget>[
          // To remove offer
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const RemoveJob()));
            },
            icon: const Icon(
              Icons.remove_circle,
              size: 30,
              color: Colors.black,
            ),
          ),
          // To add offer
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const MyJobPage()));
            },
            icon: const Icon(
              Icons.add_circle,
              size: 30,
              color: Colors.black,
            ),
          ),
          // To profile
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/profile_company');
            },
            icon: const Icon(
              Icons.account_circle_rounded,
              size: 30,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
              height: 40,
              width: double.infinity,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10.0),
                    hintText: 'Search...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      onPressed: () {
                        searchController.text = '';
                        getJobbeurData();
                      },
                      icon: const Icon(Icons.clear),
                    )),
                onChanged: (string) {
                  setState(() {
                    _filteredjobbeurs = _alljobbeurs
                        .where((u) => (u["_id"]
                                .toLowerCase()
                                .contains(string.toLowerCase()) ||
                            u["status"]
                                .toLowerCase()
                                .contains(string.toLowerCase())))
                        .toList();
                  });
                },
              )),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: _filteredjobbeurs.length,
              itemBuilder: (context, i) {
                final jobbeur = _filteredjobbeurs[i];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    "Jobbeur: ${jobbeur["firstName"]} ${jobbeur["lastName"]}\n",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => JobbeurDetail(
                                                detail: jobbeur)));
                                  },
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: "Email: ${jobbeur["email"]}\n",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey.shade900,
                                ),
                              ),
                              TextSpan(
                                text: "Phone: ${jobbeur["phone"]}",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
