import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lol_api/main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPage createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  Color colorGrey = const Color(0xFFA09B8C);
  Color colorBlue = const Color(0xFF005A82);
  Color colorGold = const Color(0xFFC89B3C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,
        title: Text(
          'Réglages',
          style: TextStyle(
            color: colorGrey,
            fontSize: 30,
            fontFamily: 'LoLFontBold',
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(CupertinoIcons.bars, color: colorGrey, size: 30.0),
              onPressed: () {}),
        ],
      ),
      backgroundColor: const Color(0xFF091428),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 10, bottom: 10),
            color: Colors.white12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Connexion',
                  style: TextStyle(color: colorGrey, fontFamily: 'LoLFontBold'),
                ),
                Icon(
                  Icons.arrow_right,
                  color: colorGrey,
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(bottom: 10),
            color: Colors.white12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Thème',
                  style: TextStyle(color: colorGrey, fontFamily: 'LoLFontBold'),
                ),
                Icon(
                  Icons.arrow_right,
                  color: colorGrey,
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(bottom: 10),
            color: Colors.white12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Langue',
                  style: TextStyle(color: colorGrey, fontFamily: 'LoLFontBold'),
                ),
                Icon(
                  Icons.arrow_right,
                  color: colorGrey,
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(bottom: 10),
            color: Colors.white12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Avis',
                  style: TextStyle(color: colorGrey, fontFamily: 'LoLFontBold'),
                ),
                Icon(
                  Icons.arrow_right,
                  color: colorGrey,
                )
              ],
            ),
          ),
          // RESEAUX SOCIAUX
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(bottom: 10),
            color: Colors.white12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Discord',
                  style: TextStyle(color: colorGrey, fontFamily: 'LoLFontBold'),
                ),
                Icon(
                  Icons.arrow_right,
                  color: colorGrey,
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(bottom: 10),
            color: Colors.white12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Conditions d\'utilisation',
                  style: TextStyle(color: colorGrey, fontFamily: 'LoLFontBold'),
                ),
                Icon(
                  Icons.arrow_right,
                  color: colorGrey,
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(bottom: 10),
            color: Colors.white12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Politique de confidentialité',
                  style: TextStyle(color: colorGrey, fontFamily: 'LoLFontBold'),
                ),
                Icon(
                  Icons.arrow_right,
                  color: colorGrey,
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(bottom: 10),
            color: Colors.white12,
            child: Row(
              children: [
                Text(
                  'Version 1.0.0',
                  style: TextStyle(color: colorGrey, fontFamily: 'LoLFontBold'),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const MyBottomAppBar(),
    );
  }
}
