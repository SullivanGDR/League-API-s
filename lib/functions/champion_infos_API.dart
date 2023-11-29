import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lol_api/class/champion_infos.dart';
import 'package:lol_api/class/champion_passive.dart';
import 'package:lol_api/class/champion_spells.dart';

Future<ChampionInfos> initTest(String nomChampion) async {
  String baseUrl = 'ddragon.leagueoflegends.com';
  Map<String, String> header = {
    "Content-type": "application/json; charset=UTF-8",
    "Accept": 'application/json',
    "Accept-Charset": "UTF-8",
  };

  final uri =
      Uri.http(baseUrl, '/cdn/13.23.1/data/fr_FR/champion/$nomChampion.json');
  final response = await http.get(uri, headers: header);

  if (response.statusCode == 200) {
    final Map<String, dynamic> data =
        json.decode(utf8.decode(response.bodyBytes));
    final Map<String, dynamic> championData = data['data'][nomChampion];

    final String championId = championData['key'];
    final String championName = championData['name'];
    final String championLore = championData['lore'];
    final String championNameCompact = championData['id'];
    final List championRoles = championData['tags'];
    final String championIcon = '${championData['image']['full']}';
    final int championHp = championData['stats']['hp'];
    final int championMs = championData['stats']['movespeed'];
    final int championArmor = championData['stats']['armor'];
    final int championAr = championData['stats']['attackrange'];
    final int championAd = championData['stats']['attackdamage'];
    final double championAs = championData['stats']['attackspeed'];

    final ChampionPassive passive = ChampionPassive(
      championData['passive']['name'],
      championData['passive']['description'],
      championData['passive']['image']['full'],
    );

    List<ChampionSpells> spells = [];
    for (var spell in championData['spells']) {
      ChampionSpells spellInfo = ChampionSpells(
        spell['name'],
        spell['description'],
        spell['image']['full'],
        spell['cooldown'],
      );
      spells.add(spellInfo);
    }

    ChampionInfos champion = ChampionInfos(
        championId,
        championName,
        championIcon,
        championNameCompact,
        passive,
        spells,
        championRoles,
        championHp,
        championMs,
        championArmor,
        championAr,
        championAd,
        championAs,
        championLore);

    print("Chargement du champion terminé !");

    return champion;
  } else {
    print("Error: ${response.statusCode} - ${response.reasonPhrase}");
    throw Exception('Échec du chargement du champion');
  }
}
