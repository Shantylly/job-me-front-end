import 'package:flutter/material.dart';
import 'package:front/provider/settings.dart';
import 'package:front/widgets/settings/settings_app_bar.dart';
import 'package:front/widgets/settings/settings_detail.dart';
import 'package:front/widgets/settings/settings_list.dart';
import 'package:front/widgets/settings/settings_title.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Settings>(
      create: (_) => Settings(),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: const SettingsAppBar(),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: const [
                  SettingsTitle(),
                  SettingsList(),
                ],
              ),
              const SettingDetail(),
            ],
          ),
        ),
      ),
    );
  }
}
