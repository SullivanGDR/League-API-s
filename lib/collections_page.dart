import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lol_api/champion_infos_page.dart';
import 'package:lol_api/class/champion.dart';
import 'package:lol_api/class/database.dart';
import 'package:lol_api/main.dart';

class CollectionsPage extends StatefulWidget {
  const CollectionsPage({super.key});

  @override
  _CollectionsPage createState() => _CollectionsPage();
}

class _CollectionsPage extends State<CollectionsPage> {
  List<Champion> championsFavoris = [];
  List<Champion> championsToplane = [];
  List<Champion> championsJungle = [];
  List<Champion> championsMidlane = [];
  List<Champion> championsAdc = [];
  List<Champion> championsSupport = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadListes();
  }

  void loadListes() async {
    championsFavoris = await DatabaseCollections().getListeFavoris();
    championsToplane = await DatabaseCollections().getListeTop();
    championsJungle = await DatabaseCollections().getListeJgl();
    championsMidlane = await DatabaseCollections().getListeMid();
    championsAdc = await DatabaseCollections().getListeAdc();
    championsSupport = await DatabaseCollections().getListeSupport();

    setState(() {
      _isLoading = false;
    });
  }

  Color colorGrey = const Color(0xFFA09B8C);
  Color colorBlue = const Color(0xFF005A82);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF091428),
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
      body: SingleChildScrollView(
        child: Column(
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
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: championsFavoris.length,
                  itemBuilder: (context, index) {

                    Champion champion = championsFavoris[index];

                    String normalizedChampionName = champion.getIcon();

                    String imageUrl = 'https://ddragon.leagueoflegends.com/cdn/13.24.1/img/champion/$normalizedChampionName';
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
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: championsToplane.length,
                  itemBuilder: (context, index) {

                    Champion champion = championsToplane[index];

                    String normalizedChampionName = champion.getIcon();

                    String imageUrl = 'https://ddragon.leagueoflegends.com/cdn/13.24.1/img/champion/$normalizedChampionName';
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
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: championsJungle.length,
                  itemBuilder: (context, index) {

                    Champion champion = championsJungle[index];

                    String normalizedChampionName = champion.getIcon();

                    String imageUrl = 'https://ddragon.leagueoflegends.com/cdn/13.24.1/img/champion/$normalizedChampionName';
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
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  shrinkWrap: true,
                  itemCount: championsMidlane.length,
                  itemBuilder: (context, index) {

                    Champion champion = championsMidlane[index];

                    String normalizedChampionName = champion.getIcon();

                    String imageUrl = 'https://ddragon.leagueoflegends.com/cdn/13.24.1/img/champion/$normalizedChampionName';
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
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: championsAdc.length,
                  itemBuilder: (context, index) {

                    Champion champion = championsAdc[index];

                    String normalizedChampionName = champion.getIcon();

                    String imageUrl = 'https://ddragon.leagueoflegends.com/cdn/13.24.1/img/champion/$normalizedChampionName';
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
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: championsSupport.length,
                  itemBuilder: (context, index) {

                    Champion champion = championsSupport[index];

                    String normalizedChampionName = champion.getIcon();

                    String imageUrl = 'https://ddragon.leagueoflegends.com/cdn/13.24.1/img/champion/$normalizedChampionName';
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
              ],
            ),
          ),
        ],
      ),),
    );
  }
}