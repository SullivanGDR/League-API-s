import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lol_api/champion_infos_page.dart';
import 'package:lol_api/class/champion.dart';
import 'package:lol_api/class/database.dart';
import 'package:lol_api/functions/all_champions_API.dart';
import 'package:lol_api/main.dart';

class FabricationPage extends StatefulWidget {
  const FabricationPage({super.key});

  @override
  FabricationPage2 createState() => FabricationPage2();
}

class FabricationPage2 extends State<FabricationPage> {
  List<Champion> _champions = [];
  List<Champion> _searchResults = [];

  Color colorGrey = const Color(0xFFA09B8C);
  Color colorBlue = const Color(0xFF005A82);

  bool _isLoading = true; // Nouvel état de chargement

  @override
  void initState() {
    super.initState();
    loadApi();
  }

  void loadApi() async {
    _champions = await initListChampions(_champions);
    _searchResults = _champions;

    // Mettez à jour l'état pour indiquer que le chargement est terminé
    setState(() {
      _isLoading = false;
    });
  }

  void searchChampions(String query) {
    setState(() {
      _searchResults = _champions
          .where((champion) =>
          champion.getNomCompact().toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF091428),
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
      )
          : _buildContent(),
    );
  }

  Widget _buildContent() {
    return Scaffold(
      backgroundColor: const Color(0xFF091428),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(bottomStart: Radius.circular(10.0), bottomEnd: Radius.circular(10.0)),
              color: Colors.white10,
            ),
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            height: 50,
            child: TextField(
              onChanged: (query) => searchChampions(query),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorGrey),
                ),
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(CupertinoIcons.search),
                prefixIconColor: colorGrey,
                labelStyle: TextStyle(color: colorGrey, fontFamily: 'LoLFont'),
                labelText: "Rechercher un champion",
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                Champion champion = _searchResults[index];

                String normalizedChampionName = champion.getIcon();

                String imageUrl =
                    'https://ddragon.leagueoflegends.com/cdn/13.24.1/img/champion/$normalizedChampionName';

                return InkWell(
                  onTap: () {
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
                          imageUrl,
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
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const MyBottomAppBar(),
    );
  }
}
