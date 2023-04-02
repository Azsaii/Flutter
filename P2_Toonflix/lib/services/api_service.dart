import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  // Future타입은 당장 완료될 수 있는 작업이 아님을 의미.
  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today'); // Api에 http 요청을 보낸다.
    // http.get은 Future타입을 반환한다.
    // await은 async와 함꼐 쓰이며, http.get이 반환할 때까지 기다린다.
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // response의 바디는 문자열이고, 이것을 json형식으로 변환한다.
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        // named constructor로 객체 생성하고 리스트에 add
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse("$baseUrl/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];
    final url = Uri.parse("$baseUrl/$id/episodes");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodesInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodesInstances;
    }
    throw Error();
  }
}
