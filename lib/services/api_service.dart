import 'dart:convert';

import 'package:flutterwebtoon/models/detailmodel.dart';
import 'package:flutterwebtoon/models/episodemodel.dart';
import "package:flutterwebtoon/models/webtoonmodel.dart";

import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";

  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToon() async {
    // async타입이기 때문에 void가 아니라면 Future<>안에 반환 타입을 작성해야 함.
    List<WebtoonModel> webtoonInstances = [];
    // async를 작성해야 await 키워드를 사용할 수 있다.
    final url = Uri.parse("$baseUrl/$today");
    final response =
        await http.get(url); // url을 받을 때까지 기다리도록 만들기 위해 await 키워드를 사용.
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      // jsonDecode로 반환 타입인 dynamic으로 list를 만든다는 의미.
      for (var webtoon in webtoons) {
        final instwebtoon = WebtoonModel.fromJson(webtoon);
        webtoonInstances.add(instwebtoon);
      }
      return webtoonInstances;
    }
    throw Error(); // error를 발생시킨다는 의미.
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse("$baseUrl/$id");
    final response = await http.get(url); // 만든 url로 request함. 성공적이면, if문 실행
    if (response.statusCode == 200) {
      final webtoon =
          jsonDecode(response.body); // string 타입을 json으로 jsonDecode를 통해 바꿈.
      return WebtoonDetailModel.fromJson(
          webtoon); // WebtoonDetailModel.fromJson이 해당 json에 title, about, genre, age 값을 할당함.
    }
    throw Error();
  } // id로 webtoon을 가져오는 method

  static Future<List<episionModel>> getLatesEpisodeById(String id) async {
    List<episionModel> episodesInstances = [];
    final url = Uri.parse("$baseUrl/$id");
    final response = await http.get(url); // 만든 url로 request함. 성공적이면, if문 실행
    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodesInstances.add(episionModel.fromJson(episode));
      }
      return episodesInstances;
    }
    throw Error();
  } // id로 최신 episode를 가져오는 method
}
