import 'package:flutter/material.dart';
import 'package:flutterwebtoon/screen/detail.dart';

class wtWidget extends StatelessWidget {
  final String title, thumb, id;

  const wtWidget(
      {Key? key, required this.title, required this.thumb, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Detail(title: title, thumb: thumb, id: id),
              fullscreenDialog: true),
          // fullscreenDialog: true가 아니라면, 이미지는 옆에서 오지만, 있다면 이미지는 아래에서 올라온다.
        );
      },
      child: Column(
        children: [
          Hero(
            tag: id,
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
              child: Image.network(thumb),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 19,
            ),
          ),
        ],
      ),
    );
  }
}
