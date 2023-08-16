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
            return Column(
              children: [
                const SizedBox(height: 50),
                Expanded(child: makeList(snapshot)),
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
        return Column(
          children: [
            Container(
              width: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    offset: const Offset(9, 8),
                    color: Colors.black.withOpacity(0.5),
                  )
                ],
              ),
              child: Image.network(webtoo.thumb),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              webtoo.title,
              style: const TextStyle(
                fontSize: 19,
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 40),
    );
  }
}
