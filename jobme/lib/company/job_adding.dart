import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:jobme/profile/user_class.dart';
import 'package:jobme/authentification/login.dart';
import 'package:jobme/profile/dashboard_company.dart';
import 'package:http/http.dart' as http;
import 'package:jobme/utils/space.dart';

final jobType = [
  'Serveur',
  'Cuisinier',
  'Barman / Barmaid',
  'Chef de partie',
  'Plongeur',
  'Préparateur de burgeur',
  'Runneur',
  'Commis / Commise de cuisine',
  'Chef de rang',
  'Responsable de salle',
  'Maitre d\'hotel',
  'Responsable carre VIP',
  'Sommelier',
  'Flair bartender',
  'Responsable encaissement',
  'Garçon limonadier / Serveuse limonadière',
  'Garçon de café / seveuse de café',
  'Responsable de bar',
  'Commis / Commise de bar',
  'Directeur d\'établissement',
  'Commis / Commise de bar',
  'Portier',
  'Voiturier',
  'Physionomiste',
];

class MyJobPage extends StatefulWidget {
  const MyJobPage({Key? key}) : super(key: key);

  @override
  _MyJobPageState createState() => _MyJobPageState();
}

class _MyJobPageState extends State<MyJobPage> {
  final OfferData _OfferData =
      OfferData(name: "null", desc: "null", contract: "null", salary: "0");
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController skillsController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController contractController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final dw = MediaQuery.of(context).size.width / 100;
    final dh = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("New post"),
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
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: dw * 4, vertical: dh * 4),
                child: Column(
                  children: [
                    Text(
                      'Poste :',
                      style: TextStyle(fontSize: dw * 4, color: Colors.blue),
                    ),
                    SizedBox(height: dh * 2),
                    Form(
                      key: _formKey,
                      child: Container(
                        height: dh * 7,
                        margin: EdgeInsets.symmetric(vertical: dh * 1),
                        child: TypeAheadFormField(
                          suggestionsCallback: (pattern) => jobType.where(
                            (item) => item
                                .toLowerCase()
                                .contains(pattern.toLowerCase()),
                          ),
                          itemBuilder: (_, String item) =>
                              ListTile(title: Text(item)),
                          onSuggestionSelected: (String val) {
                            nameController.text = val;
                          },
                          getImmediateSuggestions: true,
                          hideSuggestionsOnKeyboardHide: true,
                          hideOnEmpty: true,
                          noItemsFoundBuilder: (context) => const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('No item found'),
                          ),
                          textFieldConfiguration: TextFieldConfiguration(
                            decoration: const InputDecoration(
                              hintText: 'Type job type here...',
                              border: OutlineInputBorder(),
                            ),
                            controller: nameController,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              space(20),
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter job description here'),
                controller: jobController,
              ),
              space(20),
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter job skills here'),
                controller: skillsController,
              ),
              space(20),
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter needed language here'),
                controller: languageController,
              ),
              space(20),
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter type of contract here'),
                controller: contractController,
              ),
              space(20),
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter job salary here (net worth)'),
                controller: salaryController,
                keyboardType: TextInputType.number,
              ),
              space(30),
              ElevatedButton(
                  onPressed: () async {
                    String name = nameController.text;
                    String job = jobController.text;
                    String contract = contractController.text;
                    String salary = salaryController.text;
                    OfferData user =
                        await submitData(name, job, contract, salary);
                    nameController.text = '';
                    jobController.text = '';
                    skillsController.text = '';
                    languageController.text = '';
                    contractController.text = '';
                    salaryController.text = '';
                  },
                  child: const Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }

  Future<OfferData> submitData(
      String name, String desc, String contract, String salary) async {
    try {
      var response = await http.post(
        Uri.parse('http://10.0.2.2:8080/offer/create'),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          "title": name,
          "description": desc,
          "contract": contract,
          "salary": salary
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        String responseString = response.body;
        OfferDataFromJson(responseString);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Offer added correctly")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Missing arguments")));
      }
    } catch (err) {}
    return (OfferData(
        name: name, desc: desc, contract: contract, salary: salary));
  }
}
