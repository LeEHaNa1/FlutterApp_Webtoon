import 'package:flutter/material.dart';
import 'package:flutterwebtoon/models/detailmodel.dart';
import 'package:flutterwebtoon/models/episodemodel.dart';
import 'package:flutterwebtoon/services/api_service.dart';
import 'package:flutterwebtoon/widget/episode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Detail extends StatefulWidget {
  final String title, thumb, id; // StatefulWidget은 build에서 widget.__로 사용해야 함.

  const Detail(
      {Key? key, required this.title, required this.thumb, required this.id})
      : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  late Future<WebtoonDetailModel>
      webtoon; // constructor에서 widget.id에 접근 불가능 -> 선언만 하고 initState로 이동
  late Future<List<episionModel>> episodes;
  bool isLiked = false;
  late SharedPreferences pref;
  late List<String> liked = [];

  Future initPrefs() async {
    pref = await SharedPreferences.getInstance();
    final likedToons = pref.getStringList('likedToons');
    if (likedToons != null) {
      if (likedToons.contains(widget.title) == true) {
        isLiked = true;
        setState(() {
          isLiked = true;
        });
      }
    } else {
      await pref.setStringList('likedToons', []); // 사용자가 처음 앱을 열었을 때의 상태
    }
  }

  onHeartTap() async {
    final likedToons = pref.getStringList('likedToons');
    if (likedToons != null) {
      if (isLiked) {
        likedToons.remove(widget.title);
      } else {
        likedToons.add(widget.title);
      }
      await pref.setStringList('likedToons', likedToons);
      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    webtoon =
        ApiService.getToonById(widget.id); // initState에서는 widget.id에 접근 가능
    episodes = ApiService.getLatesEpisodeById(
        widget.id); // data를 받아와야 하기 때문에 statefulwidget을 사용함.
    initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1.5, // appbar의 음영을 조절함.
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.title, // 부모에게 가라는 의미.
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 50,
                    child: IconButton(
                      onPressed: onHeartTap,
                      icon: Icon(
                        isLiked
                            ? Icons.favorite
                            : Icons.favorite_outline_outlined,
                        size: 35,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, bottom: 40),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: widget.id,
                        child: Container(
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
                          child: Image.network(widget.thumb),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  FutureBuilder(
                    future: webtoon,
                    builder: (context, AsyncSnapshot snapshot) {
                      // AsyncSnapshot 으로 타입을 지정해주지 않으면 오류가 발생한다.
                      if (snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue.shade200.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1.8,
                                      color:
                                          Colors.blueAccent.withOpacity(0.8))),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(
                                snapshot.data!.about,
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              '${snapshot.data!.genre} / ${snapshot.data!.age}',
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        );
                      }
                      return const Text('...');
                    },
                  ),
                  const SizedBox(height: 20),
                  FutureBuilder(
                    future: episodes,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            for (var episode in snapshot.data!.length > 10
                                ? snapshot.data!.sublist(0, 10)
                                : snapshot.data!)
                              webtoonEpisode(
                                  episode: episode, webtoonId: widget.id),
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
