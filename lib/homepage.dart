import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lol_api/champions_icon_icons.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color colorGrey = const Color(0xFFA09B8C);
  Color colorBlue = const Color(0xFF005A82);

  String searchField = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF091428),
      appBar: AppBar(
        backgroundColor: Colors.white12,
        title: Text(
          widget.title,
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
      body: Column(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadiusDirectional.all(Radius.circular(10.0)),
              color: Colors.white10,
            ),
            margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
            padding: const EdgeInsets.all(10),
            height: 55,
            child: TextFormField(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorGrey),
                  ),
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(CupertinoIcons.search),
                  prefixIconColor: colorGrey,
                  labelStyle:
                      TextStyle(color: colorGrey, fontFamily: 'LoLFont'),
                  labelText: "Rechercher un champion"),
              validator: (valeur) {
                if (valeur == null || valeur.isEmpty) {
                  return 'Veuillez entrer la moyenne EBC des grains';
                } else {
                  return searchField = valeur.toString();
                }
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white12,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.house_fill),
                color: colorGrey),
            IconButton(
              onPressed: () {},
              icon: const Icon(ChampionsIcon.helmet),
              iconSize: 47,
              padding: const EdgeInsets.only(bottom: 0),
              color: colorGrey,
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.collections_solid),
                color: colorGrey),
            IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.gear_alt_fill),
                color: colorGrey),
          ],
        ),
      ),
    );
  }
}
