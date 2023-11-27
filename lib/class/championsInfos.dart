import 'dart:convert';
import 'package:http/http.dart' as http;

class ChampionInfos {
  final String _id;
  final String _nom;
  final String _icon;
  final String _nomCompact;
  final ChampionPassive _passive;
  final List<ChampionSpells> _spells;
  final List _role;
  final int _hp;
  final int _movespeed;
  final int _armor;
  final int _attackrange;
  final int _attackdamage;
  final double _attackspeed;

  ChampionInfos(this._id, this._nom, this._icon, this._nomCompact, this._passive, this._spells, this._role, this._hp, this._movespeed, this._armor, this._attackrange, this._attackdamage, this._attackspeed);

  String getId() {
    return _id;
  }

  String getNom() {
    return _nom;
  }

  String getIcon() {
    return _icon;
  }

  String getNomCompact() {
    return _nomCompact;
  }

  ChampionPassive getPassive() {
    return _passive;
  }

  List<ChampionSpells> getSpells() {
    return _spells;
  }

  String getRole() {
    return _role.toString().substring(1, _role.toString().length-1);
  }

  int getHp(){
    return _hp;
  }

  int getMoveSpeed(){
    return _movespeed;
  }

  int getArmor(){
    return _armor;
  }

  int getAttackRange(){
    return _attackrange;
  }

  int getAttackDamage(){
    return _attackdamage;
  }

  double getAttackSpeed(){
    return _attackspeed;
  }
}

class ChampionPassive {
  final String _name;
  final String _description;
  final String _icon;

  ChampionPassive(this._name, this._description, this._icon);

  String getName() {
    return _name;
  }

  String getDescription() {
    return _description;
  }

  String getIcon() {
    return _icon;
  }
}

class ChampionSpells {
  final String _name;
  final String _description;
  final String _icon;
  final List _cooldown;

  ChampionSpells(this._name, this._description, this._icon, this._cooldown);

  String getName() {
    return _name;
  }

  String getDescription() {
    return _description;
  }

  String getIcon() {
    return _icon;
  }

  List getCoolDown() {
    return _cooldown;
  }
}

Future<ChampionInfos> initTest(String nomChampion) async {
  String baseUrl = 'ddragon.leagueoflegends.com';
  Map<String, String> header = {
    "Content-type": "application/json; charset=UTF-8",
    "Accept": 'application/json',
    "Accept-Charset": "UTF-8",
  };

  final uri = Uri.http(baseUrl, '/cdn/13.23.1/data/fr_FR/champion/$nomChampion.json');
  final response = await http.get(uri, headers: header);

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
    final Map<String, dynamic> championData = data['data'][nomChampion];

    final String championId = championData['key'];
    final String championName = championData['name'];
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

    ChampionInfos champion = ChampionInfos(championId, championName, championIcon, championNameCompact, passive, spells, championRoles, championHp, championMs, championArmor, championAr, championAd, championAs);

    print("Chargement du champion terminé !");


    return champion;

  } else {
    print("Error: ${response.statusCode} - ${response.reasonPhrase}");
    throw Exception('Échec du chargement du champion');
  }
}