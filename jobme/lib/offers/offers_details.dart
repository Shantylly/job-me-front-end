// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:jobme/authentification/login.dart';
import 'package:jobme/profile/dashboard_jobbeur.dart';
import 'package:jobme/utils/space.dart';
import 'package:http/http.dart' as http;

class OfferDetail extends StatelessWidget {
  OfferDetail({Key? key, required this.detail}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  final detail;

  applyOffer() async {
    String id = detail["_id"];
    try {
      var response = await http.get(
        Uri.parse('http://10.0.2.2:8080/applicant/apply/$id'),
        headers: {'Authorization': 'Bearer $token'},
      );
      print(response.body);
    } catch (err) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Détail du poste"),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const DashboardJobbeur()));
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Align(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: "${detail["title"]}\n",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade900,
                        height: 2.0),
                  ),
                  TextSpan(
                    text: "Company: ${detail["company"]["name"]}\n",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade900,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: "Description: ${detail["description"]}\n",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  TextSpan(
                    text: "Type of contract: ${detail["contract"]}\n",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  TextSpan(
                    text: "Salary (net worth): ${detail["salary"]}\n",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: "Contact: ${detail["company"]["email"]}",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          space(50),
          ElevatedButton(
              onPressed: () {
                applyOffer();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "Vous avez postulé au poste de ${detail["title"]}")));
              },
              child: const Text("Postuler"))
        ],
      ),
    );
  }
}
