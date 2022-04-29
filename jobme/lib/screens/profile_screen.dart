import 'package:flutter/material.dart';
import 'package:front/widgets/profile/profile_info.dart';
import 'package:front/widgets/profile/profile_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: const ProfileAppBar(),
      body: const Center(
        child: DisplayProfile(),
      ),
    );
  }
}
