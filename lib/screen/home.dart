import 'package:flutter/material.dart';
import 'package:flutterwebtoon/services/api_service.dart';
import 'package:flutterwebtoon/models/webtoonmodel.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToon();

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
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var webtoo = snapshot.data![index];
                return Text(webtoo.title);
              },
              separatorBuilder: (context, index) => const SizedBox(width: 20),
            );
          }
          return const Center(
            child: CircularProgressIndicator(), // loading되기 하는 것.
          );
        },
      ),
    );
  }
}
