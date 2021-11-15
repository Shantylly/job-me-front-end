import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:jobme/authentification/login.dart';
import 'package:jobme/company/job_adding.dart';
import 'package:jobme/offers/offers_details.dart';
import 'package:http/http.dart' as http;

class DashboardJobbeur extends StatefulWidget {
  const DashboardJobbeur({Key? key}) : super(key: key);

  @override
  _DashboardJobbeurState createState() => _DashboardJobbeurState();
}

class _DashboardJobbeurState extends State<DashboardJobbeur> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();
  var _alloffers = [];
  var _filteredoffers = [];
  var _appliedoffers = [];
  int _selecteditem = 0;
  int _selecteditemlength = 0;

  getOfferData() async {
    try {
      var response = await http.get(
        Uri.parse('http://10.0.2.2:8080/offer/retrieve-all'),
        headers: {'Authorization': 'Bearer $token'},
      );
      print(response.body);
      List jsonData = jsonDecode(response.body)['offers'];
      setState(() {
        _alloffers = jsonData;
      });
    } catch (err) {
      print(err);
    }
    print(_alloffers.length);
    _selecteditemlength = _alloffers.length;
    _filteredoffers = _alloffers;
    return _alloffers;
  }

  getAppliedOffer() async {
    try {
      var response = await http.get(
        Uri.parse('http://10.0.2.2:8080/applicant/retrieve/applied/offers'),
        headers: {'Authorization': 'Bearer $token'},
      );
      print(response.body);
      var jsonData = jsonDecode(response.body) as List;
      setState(() {
        _appliedoffers = jsonData;
      });
    } catch (err) {
      print(err);
    }
    print(_appliedoffers.length);
    _filteredoffers = _appliedoffers;
    return _appliedoffers;
  }

  @override
  void initState() {
    super.initState();
    getOfferData();
    getAppliedOffer();
  }

  @override
  Widget build(BuildContext context) {
    final dw = MediaQuery.of(context).size.width / 100;
    final dh = MediaQuery.of(context).size.height / 100;
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
          // To profile
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/profile_jobbeur');
            },
            icon: const Icon(
              Icons.account_circle_rounded,
              size: 30,
              color: Colors.black,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF005267),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: _selecteditem,
        onTap: (value) {
          setState(() {
            _selecteditem = value;
            if (_selecteditem == 2) {
              _filteredoffers = _appliedoffers;
              _selecteditemlength = _appliedoffers.length;
            } else {
              _filteredoffers = _alloffers;
              _selecteditemlength = _alloffers.length;
            }
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Extra',
            icon: Icon(Icons.flash_on_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Poste',
            icon: Icon(Icons.work_outline),
          ),
          BottomNavigationBarItem(
              label: 'Candidature', icon: Icon(Icons.calendar_today_outlined)),
          BottomNavigationBarItem(
            label: 'Messagerie',
            icon: Icon(Icons.library_books_outlined),
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
                        if (_selecteditem == 2) {
                          getAppliedOffer();
                        } else {
                          getOfferData();
                        }
                      },
                      icon: const Icon(Icons.clear),
                    )),
                onChanged: (string) {
                  setState(() {
                    if (_selecteditem == 2) {
                      _filteredoffers = _appliedoffers
                          .where((u) => (u["title"]
                                  .toLowerCase()
                                  .contains(string.toLowerCase()) ||
                              u["description"]
                                  .toLowerCase()
                                  .contains(string.toLowerCase())))
                          .toList();
                    } else {
                      _filteredoffers = _alloffers
                          .where((u) => (u["title"]
                                  .toLowerCase()
                                  .contains(string.toLowerCase()) ||
                              u["description"]
                                  .toLowerCase()
                                  .contains(string.toLowerCase())))
                          .toList();
                    }
                  });
                },
              )),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: _filteredoffers.length,
              itemBuilder: (context, i) {
                final post = _filteredoffers[i];
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
                                text: "Poste: ${post["title"]}\n",
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OfferDetail(detail: post)));
                                  },
                              ),
                              TextSpan(
                                text: "Description: ${post["description"]}",
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
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


/*body: ListView(children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: dw * 4, vertical: dh * 2),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: SizedBox(
                  height: dh * 4,
                  child: TypeAheadFormField(
                    suggestionsCallback: (pattern) => jobType.where(
                      (item) =>
                          item.toLowerCase().contains(pattern.toLowerCase()),
                    ),
                    itemBuilder: (_, String item) =>
                        ListTile(title: Text(item)),
                    onSuggestionSelected: (String val) {
                      nameController.text = val;
                    },
                    getImmediateSuggestions: true,
                    hideSuggestionsOnKeyboardHide: true,
                    hideOnEmpty: false,
                    noItemsFoundBuilder: (context) => const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text('No item found'),
                    ),
                    textFieldConfiguration: TextFieldConfiguration(
                      textAlign: TextAlign.start,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search...',
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
        ListView.builder(
          physics: const ScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: _selecteditemlength,
          itemBuilder: (context, i) {
            if (_selecteditem == 2) {
              final post = _appliedoffers[i];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: "Poste: ${post["title"]}\n",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: "Description: ${post["description"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              final post = _alloffers[i];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: "Poste: ${post["title"]}\n",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OfferDetail(detail: post)));
                              },
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: "Company: ${post["company"]["name"]}\n",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade900,
                            ),
                          ),
                          TextSpan(
                            text: "Description: ${post["description"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ]),*/