import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lol_api/champions_icon_icons.dart';
import 'package:lol_api/class/championsRota.dart';
import 'package:lol_api/main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Champion> _champions = [];

  Color colorGrey = const Color(0xFFA09B8C);
  Color colorBlue = const Color(0xFF005A82);

  String searchField = "";

  @override

  void initState() {
    super.initState();
    chargement();
  }

  void chargement() async {
    _champions = await initListChampions(_champions);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF091428),
      appBar: AppBar(
        backgroundColor: Colors.white12,
        title: Text(
          'LOL.GG',
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
                      'Rotation des champions',
                      style: TextStyle(color: colorGrey, fontSize: 20),
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 5)),
                /*Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: _champions.map((champion) =>
                          Card(
                            child: ListTile(
                              title: Text('ID: ${champion.getId()}'),
                              subtitle: Text('Nom: ${champion.getNom()}'),
                              // Ajoute d'autres widgets pour afficher d'autres détails du champion si nécessaire
                            ),
                          ),
                      ).toList(),
                    ),
                  ),
                ),*/
              ],
            ),
          ),

        ],
      ),
      bottomNavigationBar: const MyBottomAppBar(),
    );
  }
}
