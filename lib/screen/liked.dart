import 'package:flutter/material.dart';

class Liked extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1.5, // appbar의 음영을 조절함.
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Center(
            child: Text("Liked Webtoons",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500))),
      ),
    );
  }
}
