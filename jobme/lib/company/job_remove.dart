import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jobme/company/job_edit.dart';
import 'package:jobme/authentification/login.dart';
import 'package:jobme/profile/dashboard_company.dart';
import 'package:http/http.dart' as http;
import 'package:jobme/utils/space.dart';

String editId = 'null';

class RemoveJob extends StatefulWidget {
  const RemoveJob({
    Key? key,
  }) : super(key: key);

  @override
  _RemoveJobState createState() => _RemoveJobState();
}

class _RemoveJobState extends State<RemoveJob> {
  List _offers = [];

  getOfferData() async {
    try {
      var response = await http.get(
        Uri.parse('http://10.0.2.2:8080/company/retrieve/offers'),
        headers: {'Authorization': 'Bearer $token'},
      );
      print(response.body);
      List jsonData = jsonDecode(response.body);
      setState(() {
        _offers = jsonData;
      });
    } catch (err) {}
    print(_offers.length);
    return _offers;
  }

  deleteOffer(String id) async {
    try {
      var response = await http.delete(
        Uri.parse('http://10.0.2.2:8080/offer/delete/$id'),
        headers: {'Authorization': 'Bearer $token'},
      );
      print(response.body);
    } catch (err) {}
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const RemoveJob()));
  }

  @override
  void initState() {
    super.initState();
    getOfferData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Remove or edit a post"),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const DashboardCompany()));
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _offers.length,
        itemBuilder: (context, i) {
          final post = _offers[i];
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Poste: ${post["title"]}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                space(10),
                Text(
                  "Description: ${post["description"]}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                ),
                space(10),
                Text(
                  "Type of contract: ${post["contract"]}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                ),
                Text(
                  "Rémunération: ${post["salary"]}€ net",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                ),
                Wrap(children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.black,
                    onPressed: () {
                      String id = post["_id"];
                      deleteOffer(id);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    color: Colors.black,
                    onPressed: () {
                      editId = post["_id"];
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditJob()));
                    },
                  ),
                ]),
                space(20),
              ]);
        },
      ),
    );
  }
}
