import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lol_api/class/champion.dart';

Future<List<Champion>> initListChampions(List<Champion> listeChampions) async {
  String baseUrl = 'ddragon.leagueoflegends.com';
  Map<String, String> header = {
    "Content-type": "application/json; charset=UTF-8",
    "Accept": 'application/json',
  };
  final uri = Uri.http(baseUrl, '/cdn/13.24.1/data/en_US/champion.json');

  final response = await http.get(uri, headers: header);

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final Map<String, dynamic> championsData = data['data'];

    for (var championData in championsData.values) {
      final int championId = int.parse(championData['key']);
      final String championName = championData['name'];
      final String championNameCompact = championData['id'];
      final String championIcon = '${championData['image']['full']}';

      Champion champion =
          Champion(championId, championName, championIcon, championNameCompact, );
      listeChampions.add(champion);
    }

    print("Chargement terminé !");
  } else {
    print("Error: ${response.statusCode} - ${response.reasonPhrase}");
  }

  return listeChampions;
}
