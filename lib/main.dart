import 'package:flutter/material.dart';
import 'package:flutterwebtoon/screen/home.dart';
import 'package:flutterwebtoon/services/api_service.dart';

void main() {
  ApiService().getTodaysToon();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}
