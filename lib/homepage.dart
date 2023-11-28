import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lol_api/champions_icon_icons.dart';
import 'package:lol_api/class/championsRota.dart';
import 'package:lol_api/main.dart';
import 'package:searchfield/searchfield.dart';

import 'championInfos.dart';

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
            child: SearchField<Champion>(
              suggestionItemDecoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: colorGrey,
                  ),
                ),
              ),
              searchInputDecoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorGrey),
                  ),
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(CupertinoIcons.search),
                  prefixIconColor: colorGrey,
                  labelStyle:
                      TextStyle(color: colorGrey, fontFamily: 'LoLFont'),
                  labelText: "Rechercher un champion"),
              suggestions: _champions
                  .map(
                    (e) => SearchFieldListItem<Champion>(e.getNom(),
                        item: e,
                        child: InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChampionInfoPage(
                                    champion: e,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Row(
                                children: [
                                  Image.network(
                                      'https://ddragon.leagueoflegends.com/cdn/13.23.1/img/champion/${e.getIcon()}'),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(e.getNom(),
                                      style: TextStyle(
                                          fontFamily: 'LoLFontBold',
                                          color: colorGrey,
                                          fontSize: 20)),
                                ],
                              ),
                            ))

                        /*Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChampionInfoPage(
                                    champion: e,
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Image.network(
                                    'https://ddragon.leagueoflegends.com/cdn/13.23.1/img/champion/${e.getIcon()}'),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(e.getNom(),
                                    style: TextStyle(
                                        fontFamily: 'LoLFontBold',
                                        color: colorGrey,
                                        fontSize: 20)),
                              ],
                            ),
                          )),*/
                        ),
                  )
                  .toList(),
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
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const MyBottomAppBar(),
    );
  }
}
