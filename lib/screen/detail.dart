import 'package:flutter/material.dart';
import 'package:flutterwebtoon/models/detailmodel.dart';
import 'package:flutterwebtoon/models/episodemodel.dart';
import 'package:flutterwebtoon/services/api_service.dart';

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

  @override
  void initState() {
    super.initState();
    webtoon =
        ApiService.getToonById(widget.id); // initState에서는 widget.id에 접근 가능
    episodes = ApiService.getLatesEpisodeById(widget.id);
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
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
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
        ],
      ),
    );
  }
}
