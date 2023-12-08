import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadiusDirectional.all(Radius.circular(10.0)),
              color: Colors.white10,
            ),
            margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Favoris',
                      style: TextStyle(color: colorGrey, fontSize: 20),
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 5)),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadiusDirectional.all(Radius.circular(10.0)),
              color: Colors.white10,
            ),
            margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Toplane',
                      style: TextStyle(color: colorGrey, fontSize: 20),
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 5)),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadiusDirectional.all(Radius.circular(10.0)),
              color: Colors.white10,
            ),
            margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Jungle',
                      style: TextStyle(color: colorGrey, fontSize: 20),
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 5)),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadiusDirectional.all(Radius.circular(10.0)),
              color: Colors.white10,
            ),
            margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Midlane',
                      style: TextStyle(color: colorGrey, fontSize: 20),
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 5)),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadiusDirectional.all(Radius.circular(10.0)),
              color: Colors.white10,
            ),
            margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'ADC',
                      style: TextStyle(color: colorGrey, fontSize: 20),
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 5)),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadiusDirectional.all(Radius.circular(10.0)),
              color: Colors.white10,
            ),
            margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Support',
                      style: TextStyle(color: colorGrey, fontSize: 20),
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 5)),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const MyBottomAppBar(),
    );
  }
}
