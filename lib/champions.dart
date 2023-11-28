import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:lol_api/championInfos.dart';
import 'package:lol_api/class/championsRota.dart';
import 'package:lol_api/main.dart';

class FabricationPage extends StatefulWidget {
  const FabricationPage({super.key});

  @override
  _FabricationPage createState() => _FabricationPage();
}

class _FabricationPage extends State<FabricationPage> {
  List<Champion> _champions = [];
  Color colorGrey = const Color(0xFFA09B8C);
  Color colorBlue = const Color(0xFF005A82);

  @override
  void initState() {
    super.initState();
    loadApi();
  }

  void loadApi() async {
    _champions = await initListChampions(_champions);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,
        title: Text(
          'Champions',
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
      body: GridView.builder(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: _champions.length,
        itemBuilder: (context, index) {
          Champion champion = _champions[index];

          // Normalisation du nom du champion pour l'utiliser dans l'URL
          String normalizedChampionName = champion.getIcon();

          String imageUrl =
              'https://ddragon.leagueoflegends.com/cdn/13.23.1/img/champion/$normalizedChampionName';

          return InkWell(
              onTap: () {
                // Permet d'ouvrir une nouvelle page avec des données en paramètre
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChampionInfoPage(
                      champion: champion,
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  Expanded(
                    child: Image.network(
                      imageUrl, // Remplacez par l'URL de votre image
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    champion.getNom(),
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.fade,
                      fontFamily: 'LoLFont',
                      color: colorGrey,
                    ),
                  ),
                ],
              ));
        },
      ),
      bottomNavigationBar: const MyBottomAppBar(),
    );
  }
}
