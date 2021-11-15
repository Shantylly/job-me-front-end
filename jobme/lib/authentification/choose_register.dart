import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jobme/utils/space.dart';

class WhichUser extends StatelessWidget {
  const WhichUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                "Who are you ?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30, fontWeight: FontWeight.bold, height: -4),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/register_jobbeur');
                },
                child: const Text('A Jobbeur'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(150.0, 150.0),
                ),
              ),
              space(40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/register_company');
                },
                child: const Text('A Company'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(150.0, 150.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
