import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:lol_api/class/champion.dart';
import 'package:lol_api/class/champion_infos.dart';
import 'package:lol_api/class/champion_passive.dart';
import 'package:lol_api/class/champion_spells.dart';
import 'package:lol_api/class/database.dart';
import 'package:lol_api/functions/champion_infos_API.dart';
import 'package:lol_api/main.dart';

class ChampionInfoPage extends StatefulWidget {
  final Champion champion;

  const ChampionInfoPage({
    super.key,
    required this.champion,
  });

  @override
  _ChampionInfoPageState createState() => _ChampionInfoPageState();
}

class _ChampionInfoPageState extends State<ChampionInfoPage> {
  List<ChampionSpells> allSpells = [];
  late SpeedDial _speedDial;

  ChampionInfos championInfo = ChampionInfos('', '', '', '',
      ChampionPassive('', '', ''), [], [], 0, 0, 0, 0, 0, 0, "");

  Color colorGrey = const Color(0xFFA09B8C);
  Color colorBlue = const Color(0xFF005A82);
  Color colorGold = const Color(0xFFC89B3C);

  String spellQName = "";
  String spellWName = "";
  String spellEName = "";
  String spellRName = "";

  String spellQDescription = "";
  String spellWDescription = "";
  String spellEDescription = "";
  String spellRDescription = "";

  String spellQIcon = "";
  String spellWIcon = "";
  String spellEIcon = "";
  String spellRIcon = "";

  List spellQCooldown = [];
  List spellWCooldown = [];
  List spellECooldown = [];
  List spellRCooldown = [];

  String passiveName = "";
  String passiveDescription = "";
  String passiveImg = "";

  String role = "";

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    chargement();
    _initializeSpeedDial();
  }

  Future<void> _initializeSpeedDial() async {
    SpeedDial speedDial = await _buildSpeedDial();
    setState(() {
      _speedDial = speedDial;
    });
  }

  void chargement() async {
    championInfo = await initTest(widget.champion.getNomCompact());
    initSpells();
    initPassive();
    roles();
    setState(() {
      _isLoading = false;
    });
  }

  void initPassive() async {
    passiveName = championInfo.getPassive().getName();
    passiveDescription =
        (championInfo.getPassive().getDescription()).replaceAll('<br>', ' ');
    passiveImg = championInfo.getPassive().getIcon();
  }

  void initSpells() async {
    List<ChampionSpells> spells = championInfo.getSpells();

    if (spells.isNotEmpty) {
      for (ChampionSpells spell in spells) {
        allSpells.add(spell);
      }
    }

    useSpells();
  }

  void useSpells() {
    ChampionSpells spellQ = allSpells[0];
    ChampionSpells spellW = allSpells[1];
    ChampionSpells spellE = allSpells[2];
    ChampionSpells spellR = allSpells[3];

    spellQName = spellQ.getName();
    spellWName = spellW.getName();
    spellEName = spellE.getName();
    spellRName = spellR.getName();

    spellQDescription = (spellQ.getDescription()).replaceAll('<br>', ' ');
    spellWDescription = (spellW.getDescription()).replaceAll('<br>', ' ');
    spellEDescription = (spellE.getDescription()).replaceAll('<br>', ' ');
    spellRDescription = (spellR.getDescription()).replaceAll('<br>', ' ');

    spellQIcon = spellQ.getIcon();
    spellWIcon = spellW.getIcon();
    spellEIcon = spellE.getIcon();
    spellRIcon = spellR.getIcon();

    spellQCooldown = spellQ.getCoolDown();
    spellWCooldown = spellW.getCoolDown();
    spellECooldown = spellE.getCoolDown();
    spellRCooldown = spellR.getCoolDown();
  }

  List<String> rolesList = [];

  void roles() {
    role = championInfo.getRole();

    rolesList = role.split(', ');
  }

  String getRoleImage(String role) {
    switch (role) {
      case 'Marksman':
        return 'assets/images/class-icons/marksmen.png';
      case 'Tank':
        return 'assets/images/class-icons/tanks.png';
      case 'Assassin':
        return 'assets/images/class-icons/slayers.png';
      case 'Fighter':
        return 'assets/images/class-icons/fighters.png';
      case 'Support':
        return 'assets/images/class-icons/controllers.png';
      case 'Mage':
        return 'assets/images/class-icons/mages.png';
      default:
        return 'assets/images/default.png';
    }
  }

  void addChampionToCollectionButton(String nomCollection, Champion champion) async {

    await DatabaseCollections().addChampionToCollection(nomCollection, champion);

    final scaffold = ScaffoldMessenger.of(context);

    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: colorGold,
        content: Text("Ajout de ${champion.getNom()} dans la collection $nomCollection.", style: const TextStyle(fontFamily: 'LolFontBold', color: Colors.white)),
      ),
    );
    _initializeSpeedDial();
  }

  void removeChampionToCollectionButton(String nomCollection, Champion champion) async {

    await DatabaseCollections().deleteItem(widget.champion.getId(), nomCollection);

    final scaffold = ScaffoldMessenger.of(context);

    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text("Suppression de ${champion.getNom()} dans la collection $nomCollection.", style: const TextStyle(fontFamily: 'LolFontBold', color: Colors.white)),
      ),
    );
    _initializeSpeedDial();
  }

  Future<SpeedDial> _buildSpeedDial() async {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: const IconThemeData(size: 22.0),
      backgroundColor: colorBlue,
      foregroundColor: Colors.white,
      children: [
        await _buildSpeedDialChild('Favoris'),
        await _buildSpeedDialChild('Support'),
        await _buildSpeedDialChild('ADC'),
        await _buildSpeedDialChild('MID'),
        await _buildSpeedDialChild('JGL'),
        await _buildSpeedDialChild('TOP'),
      ],
    );
  }

  Future<SpeedDialChild> _buildSpeedDialChild(String collectionName) async {
    bool estDansCollection = await DatabaseCollections().isChampionInCollection(collectionName, widget.champion);
    return SpeedDialChild(
      child: estDansCollection ? const Icon(Icons.delete, color: Colors.red) : const Icon(Icons.playlist_add),
      backgroundColor: colorBlue,
      label: estDansCollection ? 'Supprimer de $collectionName' : 'Ajouter à $collectionName',
      labelStyle: const TextStyle(fontFamily: 'LolFontBold'),
      onTap: () {
        if (estDansCollection) {
          removeChampionToCollectionButton(collectionName, widget.champion);
        } else {
          addChampionToCollectionButton(collectionName, widget.champion);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF091428),
      body: _isLoading ? const Center(child: CircularProgressIndicator()) : _buildContent(),
    );
  }

  Widget _buildContent() {
    return Scaffold(
      backgroundColor: const Color(0xFF091428),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  'https://ddragon.leagueoflegends.com/cdn/img/champion/splash/${championInfo.getNomCompact()}_0.jpg',
                  fit: BoxFit.contain,
                ),
                Container(
                  height: 243,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Color(0xFF091428),
                      ],
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        championInfo.getNom(),
                        style: TextStyle(
                            color: colorGrey,
                            fontSize: 35.0,
                            fontFamily: 'LoLFontBold'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.only(top: 15)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // INFORMATIONS DU PASSIF
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (BuildContext context) {
                                return Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16.0),
                                        topRight: Radius.circular(16.0),
                                      ),
                                      color: Color(0xFF091428),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, left: 20),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                                child: Image.network(
                                                  'https://ddragon.leagueoflegends.com/cdn/13.24.1/img/passive/$passiveImg',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10)),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(passiveName,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'LoLFontBold',
                                                          color: colorGrey,
                                                          fontSize: 20)),
                                                  Text('Compétence passive',
                                                      style: TextStyle(
                                                          fontFamily: 'LoLFont',
                                                          color: colorGrey,
                                                          fontSize: 15))
                                                ],
                                              )
                                            ],
                                          ),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(top: 20)),
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Text(passiveDescription,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        fontFamily: 'LoLFont',
                                                        color: colorGrey,
                                                        fontSize: 15)),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ));
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            child: Image.network(
                              'https://ddragon.leagueoflegends.com/cdn/13.24.1/img/passive/$passiveImg',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const Text('Passive',
                            style: TextStyle(
                                fontFamily: 'LoLFontBold', color: Colors.grey)),
                      ],
                    ),
                    // INFORMATIONS DU Q SPELL
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (BuildContext context) {
                                return Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16.0),
                                        topRight: Radius.circular(16.0),
                                      ),
                                      color: Color(0xFF091428),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, left: 20),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                                child: Image.network(
                                                  'https://ddragon.leagueoflegends.com/cdn/13.24.1/img/spell/$spellQIcon',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10)),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(spellQName,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'LoLFontBold',
                                                          color: colorGrey,
                                                          fontSize: 20)),
                                                  Text('Compétence 1',
                                                      style: TextStyle(
                                                          fontFamily: 'LoLFont',
                                                          color: colorGrey,
                                                          fontSize: 15)),
                                                  Text(
                                                      'Cooldown : $spellQCooldown',
                                                      style: TextStyle(
                                                          fontFamily: 'LoLFont',
                                                          color: colorGrey,
                                                          fontSize: 15))
                                                ],
                                              )
                                            ],
                                          ),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(top: 20)),
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Text(spellQDescription,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        fontFamily: 'LoLFont',
                                                        color: colorGrey,
                                                        fontSize: 15)),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ));
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            child: Image.network(
                              'https://ddragon.leagueoflegends.com/cdn/13.24.1/img/spell/$spellQIcon',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const Text('Q',
                            style: TextStyle(
                                fontFamily: 'LoLFontBold', color: Colors.grey)),
                      ],
                    ),
                    // INFORMATIONS DU W SPELL
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (BuildContext context) {
                                return Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16.0),
                                        topRight: Radius.circular(16.0),
                                      ),
                                      color: Color(0xFF091428),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, left: 20),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                                child: Image.network(
                                                  'https://ddragon.leagueoflegends.com/cdn/13.24.1/img/spell/$spellWIcon',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10)),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(spellWName,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'LoLFontBold',
                                                          color: colorGrey,
                                                          fontSize: 20)),
                                                  Text('Compétence 2',
                                                      style: TextStyle(
                                                          fontFamily: 'LoLFont',
                                                          color: colorGrey,
                                                          fontSize: 15)),
                                                  Text(
                                                      'Cooldown : $spellWCooldown',
                                                      style: TextStyle(
                                                          fontFamily: 'LoLFont',
                                                          color: colorGrey,
                                                          fontSize: 15))
                                                ],
                                              )
                                            ],
                                          ),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(top: 20)),
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Text(spellWDescription,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        fontFamily: 'LoLFont',
                                                        color: colorGrey,
                                                        fontSize: 15)),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ));
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            child: Image.network(
                              'https://ddragon.leagueoflegends.com/cdn/13.24.1/img/spell/$spellWIcon',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const Text('W',
                            style: TextStyle(
                                fontFamily: 'LoLFontBold', color: Colors.grey)),
                      ],
                    ),
                    // INFORMATIONS DU E SPELL
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (BuildContext context) {
                                return Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16.0),
                                        topRight: Radius.circular(16.0),
                                      ),
                                      color: Color(0xFF091428),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, left: 20),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                                child: Image.network(
                                                  'https://ddragon.leagueoflegends.com/cdn/13.24.1/img/spell/$spellEIcon',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10)),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(spellEName,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'LoLFontBold',
                                                          color: colorGrey,
                                                          fontSize: 20)),
                                                  Text('Compétence 3',
                                                      style: TextStyle(
                                                          fontFamily: 'LoLFont',
                                                          color: colorGrey,
                                                          fontSize: 15)),
                                                  Text(
                                                      'Cooldown : $spellECooldown',
                                                      style: TextStyle(
                                                          fontFamily: 'LoLFont',
                                                          color: colorGrey,
                                                          fontSize: 15))
                                                ],
                                              )
                                            ],
                                          ),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(top: 20)),
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Text(spellEDescription,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        fontFamily: 'LoLFont',
                                                        color: colorGrey,
                                                        fontSize: 15)),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ));
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            child: Image.network(
                              'https://ddragon.leagueoflegends.com/cdn/13.24.1/img/spell/$spellEIcon',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const Text('E',
                            style: TextStyle(
                                fontFamily: 'LoLFontBold', color: Colors.grey)),
                      ],
                    ),
                    // INFORMATIONS DE L\'ultime
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (BuildContext context) {
                                return Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16.0),
                                        topRight: Radius.circular(16.0),
                                      ),
                                      color: Color(0xFF091428),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, left: 20),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                                child: Image.network(
                                                  'https://ddragon.leagueoflegends.com/cdn/13.24.1/img/spell/$spellRIcon',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10)),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(spellRName,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'LoLFontBold',
                                                          color: colorGrey,
                                                          fontSize: 20)),
                                                  Text('Compétence ultime',
                                                      style: TextStyle(
                                                          fontFamily: 'LoLFont',
                                                          color: colorGrey,
                                                          fontSize: 15)),
                                                  Text(
                                                      'Cooldown : $spellRCooldown',
                                                      style: TextStyle(
                                                          fontFamily: 'LoLFont',
                                                          color: colorGrey,
                                                          fontSize: 15))
                                                ],
                                              )
                                            ],
                                          ),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(top: 20)),
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Text(spellRDescription,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        fontFamily: 'LoLFont',
                                                        color: colorGrey,
                                                        fontSize: 15)),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ));
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            child: Image.network(
                              'https://ddragon.leagueoflegends.com/cdn/13.24.1/img/spell/$spellRIcon',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const Text('R',
                            style: TextStyle(
                                fontFamily: 'LoLFontBold', color: Colors.grey)),
                      ],
                    ),
                  ],
                )
              ],
            ),
            // INFORMATIONS DU CHAMPIONS (STATS DE BASE)
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 15, right: 15, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Rôle : ',
                          style: TextStyle(
                              fontFamily: 'LoLFontBold',
                              color: colorGold,
                              fontSize: 20)),
                      for (String role in rolesList) ...[
                        const SizedBox(width: 8),
                        Image.asset(getRoleImage(role), width: 24, height: 24),
                        Text(' $role',
                            style: const TextStyle(
                                fontFamily: 'LoLFontBold',
                                color: Colors.grey,
                                fontSize: 20)),
                      ],
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  Text('Stats de base :',
                      style: TextStyle(
                          fontFamily: 'LoLFontBold',
                          color: colorGold,
                          fontSize: 20)),
                  const Padding(padding: EdgeInsets.only(top: 15)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/stats-icon/Health_icon.webp',
                                color: Colors.green,
                              ),
                              Text('  : ${championInfo.getHp()}',
                                  style: const TextStyle(
                                      fontFamily: 'LoLFontBold',
                                      color: Colors.grey,
                                      fontSize: 15)),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/stats-icon/Armor_icon.webp',
                                color: Colors.redAccent,
                              ),
                              Text('  : ${championInfo.getArmor()}',
                                  style: const TextStyle(
                                      fontFamily: 'LoLFontBold',
                                      color: Colors.grey,
                                      fontSize: 15)),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(
                                  'assets/images/stats-icon/Movement_speed_icon.webp'),
                              Text('  : ${championInfo.getMoveSpeed()}',
                                  style: const TextStyle(
                                      fontFamily: 'LoLFontBold',
                                      color: Colors.grey,
                                      fontSize: 15)),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/stats-icon/Range_icon.webp',
                                color: Colors.blueAccent,
                              ),
                              Text('  : ${championInfo.getAttackRange()}',
                                  style: const TextStyle(
                                      fontFamily: 'LoLFontBold',
                                      color: Colors.grey,
                                      fontSize: 15)),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/stats-icon/Attack_damage_icon.webp',
                                color: Colors.deepOrangeAccent,
                              ),
                              Text('  : ${championInfo.getAttackDamage()}',
                                  style: const TextStyle(
                                      fontFamily: 'LoLFontBold',
                                      color: Colors.grey,
                                      fontSize: 15)),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/stats-icon/Attack_speed_icon.webp',
                                color: Colors.orangeAccent,
                              ),
                              Text('  : ${championInfo.getAttackSpeed()}',
                                  style: const TextStyle(
                                      fontFamily: 'LoLFontBold',
                                      color: Colors.grey,
                                      fontSize: 15)),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  // LORE DU CHAMPION
                  Text('Lore :',
                      style: TextStyle(
                          fontFamily: 'LoLFontBold',
                          color: colorGold,
                          fontSize: 20)),
                  Row(
                    children: [
                      Flexible(
                        child: Text(championInfo.getLore(),
                            softWrap: true,
                            style: TextStyle(
                                fontFamily: 'LoLFont',
                                color: colorGrey,
                                fontSize: 17)),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: _speedDial,
      bottomNavigationBar: const MyBottomAppBar(),
    );
  }
}
