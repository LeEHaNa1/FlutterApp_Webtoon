import 'package:flutter/material.dart';
import 'package:flutterwebtoon/screen/home.dart';
import 'package:flutter/gestures.dart';

void main() {
  runApp(const MyApp());
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // chrome으로 emulator를 돌릴 때, scroll이 되도록 하는 코드
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      home: Home(),
    );
  }
}
