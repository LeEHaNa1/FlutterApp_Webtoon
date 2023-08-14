import 'package:flutter/material.dart';
import 'package:flutterwebtoon/services/api_service.dart';
import 'package:flutterwebtoon/models/webtoonmodel.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToon();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1.5, // appbar의 음영을 조절함.
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Center(
            child: Text("Today's webtoon",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500))),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Text("There is Data!");
          }
          return const Text("Loading");
        },
      ),
    );
  }
}
