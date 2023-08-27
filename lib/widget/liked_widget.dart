import 'package:flutter/material.dart';
import 'package:flutterwebtoon/screen/liked.dart';

class LikedWidget extends StatelessWidget {
  const LikedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Liked()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.green),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              "List of Liked Webtoons",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
