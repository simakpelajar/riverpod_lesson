import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:riverpod_lesson/live_game/models/game.dart';

class GameSource {
  static Future<List<Game>> getLive() async {
    final String url = 'https://www.freetogame.com/api/games';
    final response = await http.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        List list = jsonDecode(response.body);
        return list.map((e) => Game.fromJson(Map.from(e))).toList();
      } else {
        throw Exception('Failed to load games');
      }
    } catch (e) {
      throw Exception('Failed to load games');
    }
  }
}
