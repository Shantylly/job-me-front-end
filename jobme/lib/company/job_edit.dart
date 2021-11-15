import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:jobme/company/job_adding.dart';
import 'package:jobme/utils/space.dart';
import 'package:jobme/company/job_remove.dart';
import 'package:jobme/profile/user_class.dart';
import 'package:jobme/authentification/login.dart';
import 'package:http/http.dart' as http;

class EditJob extends StatefulWidget {
  const EditJob({Key? key}) : super(key: key);

  @override
  EditJobState createState() => EditJobState();
}

class EditJobState extends State<EditJob> {
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();
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
        title: const Text("Remove or edit a post"),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const RemoveJob()));
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
                    hintText: 'Edit offer description here'),
                controller: jobController,
              ),
              space(10),
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Edit offer contract here'),
                controller: contractController,
              ),
              space(10),
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Edit offer salary here'),
                controller: salaryController,
              ),
              ElevatedButton(
                  onPressed: () async {
                    String name = nameController.text;
                    String job = jobController.text;
                    String contract = contractController.text;
                    String salary = salaryController.text;
                    OfferData user =
                        await editData(name, job, contract, salary);
                    nameController.text = '';
                    jobController.text = '';
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

  Future<OfferData> editData(
      String name, String desc, String contract, String salary) async {
    try {
      var response = await http.put(
        Uri.parse('http://10.0.2.2:8080/offer/modify/$editId'),
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
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Offer edited correctly")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Missing arguments")));
      }
    } catch (err) {}
    return (OfferData(
        name: name, desc: desc, contract: contract, salary: salary));
  }
}
