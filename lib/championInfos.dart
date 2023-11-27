import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:lol_api/class/championsInfos.dart';
import 'package:lol_api/class/championsRota.dart';
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

  ChampionInfos championInfo = ChampionInfos(
      '', '', '', '', ChampionPassive('', '', ''), [], [], 0, 0, 0, 0, 0, 0);

  Color colorGrey = const Color(0xFFA09B8C);
  Color colorBlue = const Color(0xFF005A82);

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

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    chargement();
  }

  void chargement() async {
    championInfo = await initTest(widget.champion.getNomCompact());
    initSpells();
    initPassive();
    roles();
    setState(() {});
  }

  void initPassive() async {
    passiveName = await championInfo.getPassive().getName();
    passiveDescription = await (championInfo.getPassive().getDescription())
        .replaceAll('<br>', ' ');
    passiveImg = await championInfo.getPassive().getIcon();
  }

  void initSpells() async {
    List<ChampionSpells> spells = await championInfo.getSpells();

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

    spellQDescription = spellQ.getDescription();
    spellWDescription = spellW.getDescription();
    spellEDescription = spellE.getDescription();
    spellRDescription = spellR.getDescription();

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
        // Retourne une image par défaut si le rôle n'est pas reconnu
        return 'assets/images/default.png';
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF091428),
      body: Column(
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
                                    padding: EdgeInsets.only(top: 20, left: 20),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              child: Image.network(
                                                'https://ddragon.leagueoflegends.com/cdn/13.23.1/img/passive/$passiveImg',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10)),
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
                                        Padding(
                                            padding: EdgeInsets.only(top: 20)),
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
                            'https://ddragon.leagueoflegends.com/cdn/13.23.1/img/passive/$passiveImg',
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
                                    padding: EdgeInsets.only(top: 20, left: 20),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              child: Image.network(
                                                'https://ddragon.leagueoflegends.com/cdn/13.23.1/img/spell/$spellQIcon',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10)),
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
                                            padding: EdgeInsets.only(top: 20)),
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
                            'https://ddragon.leagueoflegends.com/cdn/13.23.1/img/spell/$spellQIcon',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const Text('Q',
                          style: TextStyle(
                              fontFamily: 'LoLFontBold', color: Colors.grey)),
                    ],
                  ),
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
                                    padding: EdgeInsets.only(top: 20, left: 20),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              child: Image.network(
                                                'https://ddragon.leagueoflegends.com/cdn/13.23.1/img/spell/$spellWIcon',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10)),
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
                                            padding: EdgeInsets.only(top: 20)),
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
                            'https://ddragon.leagueoflegends.com/cdn/13.23.1/img/spell/$spellWIcon',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const Text('W',
                          style: TextStyle(
                              fontFamily: 'LoLFontBold', color: Colors.grey)),
                    ],
                  ),
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
                                    padding: EdgeInsets.only(top: 20, left: 20),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              child: Image.network(
                                                'https://ddragon.leagueoflegends.com/cdn/13.23.1/img/spell/$spellEIcon',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10)),
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
                                            padding: EdgeInsets.only(top: 20)),
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
                            'https://ddragon.leagueoflegends.com/cdn/13.23.1/img/spell/$spellEIcon',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const Text('E',
                          style: TextStyle(
                              fontFamily: 'LoLFontBold', color: Colors.grey)),
                    ],
                  ),
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
                                    padding: EdgeInsets.only(top: 20, left: 20),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              child: Image.network(
                                                'https://ddragon.leagueoflegends.com/cdn/13.23.1/img/spell/$spellRIcon',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10)),
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
                                            padding: EdgeInsets.only(top: 20)),
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
                            'https://ddragon.leagueoflegends.com/cdn/13.23.1/img/spell/$spellRIcon',
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
          Padding(
            padding: EdgeInsets.only(top: 20, left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('Rôle : ',
                        style: TextStyle(
                            fontFamily: 'LoLFontBold',
                            color: Colors.grey,
                            fontSize: 20)),
                    for (String role in rolesList) ...[
                      const SizedBox(width: 8),
                      Image.asset(getRoleImage(role), width: 24, height: 24),
                      // Texte du rôle
                      Text(' $role',
                          style: const TextStyle(
                              fontFamily: 'LoLFontBold',
                              color: Colors.grey,
                              fontSize: 20)),
                    ],
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                const Text('Stats de base :',
                    style: TextStyle(
                        fontFamily: 'LoLFontBold',
                        color: Colors.grey,
                        fontSize: 20)),
                Padding(padding: EdgeInsets.only(top: 15)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('HP : ${championInfo.getHp()}',
                            style: const TextStyle(
                                fontFamily: 'LoLFontBold',
                                color: Colors.grey,
                                fontSize: 15)),
                        Row(
                          children: [
                            Image.asset(
                                'assets/images/stats-icon/Armor_icon.webp'),
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
                        Text('Range : ${championInfo.getAttackRange()}',
                            style: const TextStyle(
                                fontFamily: 'LoLFontBold',
                                color: Colors.grey,
                                fontSize: 15)),
                        Row(
                          children: [
                            Image.asset(
                                'assets/images/stats-icon/Attack_damage_icon.webp'),
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
                                'assets/images/stats-icon/Attack_speed_icon.webp'),
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
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: const MyBottomAppBar(),
    );
  }
}
