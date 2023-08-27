import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Liked extends StatefulWidget {
  const Liked({Key? key}) : super(key: key);

  @override
  State<Liked> createState() => _LikedState();
}

class _LikedState extends State<Liked> {
  late SharedPreferences pref;

  Future initPrefs() async {
    pref = await SharedPreferences.getInstance();
    final likedToons = pref.getStringList('likedToons');
    if (likedToons != null) {
      return likedToons;
    }
  }

  ListView makeLiked(AsyncSnapshot<dynamic> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        var webtoo = snapshot.data![index];
        return Container(
            decoration: const BoxDecoration(color: Colors.blue),
            child: Text(webtoo.title));
      },
      separatorBuilder: (context, index) => const SizedBox(width: 40),
    );
  }

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
      // body: FutureBuilder(future: initPrefs(), builder: (context, AsyncSnapshot snapshot){if(snapshot.hasData){return makeLiked(snapshot);}})
    );
  }
}
