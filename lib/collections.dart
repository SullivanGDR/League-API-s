import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:lol_api/championInfos.dart';
import 'package:lol_api/class/championsRota.dart';
import 'package:lol_api/main.dart';

class CollectionsPage extends StatefulWidget {
  const CollectionsPage({super.key});

  @override
  _CollectionsPage createState() => _CollectionsPage();
}

class _CollectionsPage extends State<CollectionsPage> {
  Color colorGrey = const Color(0xFFA09B8C);
  Color colorBlue = const Color(0xFF005A82);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,
        title: Text(
          'Collections',
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
      body: Column(),
      bottomNavigationBar: const MyBottomAppBar(),
    );
  }
}
