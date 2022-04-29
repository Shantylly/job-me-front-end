import 'package:flutter/material.dart';
import 'package:front/constants/colors.dart';
import 'package:front/provider/settings.dart';
import 'package:provider/provider.dart';

class SettingsCard extends StatefulWidget {
  const SettingsCard(
      {Key? key, required this.parameter, this.icon = Icons.description})
      : super(key: key);
  final String parameter;
  final IconData icon;

  @override
  _SettingsCardState createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListTile(
        tileColor: Colors.white,
        selected: context.watch<Settings>().isSelected(widget.key),
        selectedColor: secondColor,
        selectedTileColor: Colors.blue[50],
        onTap: () {
          Provider.of<Settings>(context, listen: false).setSelected(widget.key);
        },
        leading: Icon(
          widget.icon,
          size: 35,
        ),
        title: Text(widget.parameter,
            style: const TextStyle(
                color: primaryColor, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
