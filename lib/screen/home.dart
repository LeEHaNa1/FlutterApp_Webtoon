import 'package:flutter/material.dart';
import 'package:flutterwebtoon/services/api_service.dart';
import 'package:flutterwebtoon/models/webtoonmodel.dart';
import 'package:flutterwebtoon/widget/webtoon_widget.dart';

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
            return Column(
              children: [
                const SizedBox(height: 50),
                Expanded(child: makeList(snapshot)),
                const SizedBox(height: 80),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(), // loading되기 하는 것.
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<dynamic> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        var webtoo = snapshot.data![index];
        return wtWidget(
            title: webtoo.title, thumb: webtoo.thumb, id: webtoo.id);
      },
      separatorBuilder: (context, index) => const SizedBox(width: 40),
    );
  }
}
