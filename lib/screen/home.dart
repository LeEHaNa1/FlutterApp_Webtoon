import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
      //body:
    );
  }
}
