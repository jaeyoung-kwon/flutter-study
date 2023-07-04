import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:studyflutter/models/webtoon_detail_model.dart';
import 'package:studyflutter/models/webtoon_episode_model.dart';
import 'package:studyflutter/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');

    late http.Response response;
    Map<String, String> header = {"Content-Type": "application/json"};
    response = await http.get(url, headers: header);

    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        final instance = WebtoonModel.fromJson(webtoon);
        webtoonInstances.add(instance);
      }
      return webtoonInstances;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse('$baseUrl/$id');

    late http.Response response;
    Map<String, String> header = {"Content-Type": "application/json"};
    response = await http.get(url, headers: header);

    if (response.statusCode == 200) {
      final Map<String, dynamic> webtoon = jsonDecode(response.body);
      final instance = WebtoonDetailModel.fromJson(webtoon);
      return instance;
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLastestEpisodesById(
      String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];
    final url = Uri.parse('$baseUrl/$id/episodes');

    late http.Response response;
    Map<String, String> header = {"Content-Type": "application/json"};
    response = await http.get(url, headers: header);

    if (response.statusCode == 200) {
      final List<dynamic> episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        final instance = WebtoonEpisodeModel.fromJson(episode);
        episodesInstances.add(instance);
      }
      return episodesInstances;
    }
    throw Error();
  }
}
