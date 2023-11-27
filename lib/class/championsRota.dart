import 'dart:convert';
import 'package:http/http.dart' as http;

class Champion {
  final int _id;
  final String _nom;
  final String _icon;
  final String _nomCompact;

  Champion(this._id, this._nom, this._icon, this._nomCompact);

  int getId() {
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

}

Future<List<Champion>> initListChampions(List<Champion> listeChampions) async {
  String baseUrl = 'ddragon.leagueoflegends.com';
  Map<String, String> header = {
    "Content-type": "application/json; charset=UTF-8",
    "Accept": 'application/json',
  };
  final uri = Uri.http(baseUrl, '/cdn/13.23.1/data/en_US/champion.json');

  final response = await http.get(uri, headers: header);

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final Map<String, dynamic> championsData = data['data'];

    for (var championData in championsData.values) {
      final int championId = int.parse(championData['key']);
      final String championName = championData['name'];
      final String championNameCompact = championData['id'];
      final String championIcon = '${championData['image']['full']}';

      Champion champion = Champion(championId, championName, championIcon, championNameCompact);
      listeChampions.add(champion);
    }

    print("Chargement terminé !");
  } else {
    print("Error: ${response.statusCode} - ${response.reasonPhrase}");
  }

  return listeChampions;
}