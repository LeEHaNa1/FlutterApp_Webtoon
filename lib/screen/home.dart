import 'package:flutter/material.dart';
import 'package:flutterwebtoon/models/webtoonmodel.dart';
import 'package:flutterwebtoon/services/api_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<WebtoonModel> webtoons = [];
  bool isLoading = true;

  void waitForWebtoons() async {
    webtoons = await ApiService.getTodaysToon();
    isLoading = false;
    setState(() {});
  }
//setState의 역할:

  @override
  void initState() {
    super.initState();
    waitForWebtoons();
  } //initState의 역할: 상태를 초기화시킴.(build 동작 이전에.)
  //상태가 초기화되면서 waitForWebtoons()가 실행되어 getTodaysToon()로 data를 받아 webtoons에 넣고 isLoading을 false로 두었다.

  @override
  Widget build(BuildContext context) {
    print(webtoons);
    print(isLoading);
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
