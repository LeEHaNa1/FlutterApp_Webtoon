import 'dart:convert';

import "package:flutterwebtoon/models/webtoonmodel.dart";

import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";

  final String today = "today";

  Future<List<WebtoonModel>> getTodaysToon() async {
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
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    }
    throw Error(); // error를 발생시킨다는 의미.
  }
}
