import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/widgets/webtoon_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFeaffe0),
      appBar: AppBar(
        elevation: 2, // 그림자
        backgroundColor: Colors.white,
        foregroundColor: const Color.fromARGB(255, 41, 32, 79),
        centerTitle: true,
        title: const Text(
          "오늘의 웹툰",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: webtoons,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Expanded(
                        child: makeList(snapshot),
                      )
                    ],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              height: 50,
              width: 220,
              child: ElevatedButton(
                onPressed: () {
                  launchWebtoon();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF845ad6),
                  padding: const EdgeInsets.all(10.0),
                  textStyle: const TextStyle(fontSize: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 12,
                ),
                child: Row(
                  children: const [
                    Text("네이버 웹툰 전체보기"),
                    Icon(
                      Icons.chevron_right_rounded,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  launchWebtoon() async {
    String url = "https://comic.naver.com/index";
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    }
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    // .builder는 리스트뷰를 최적화한 것이다.
    // .separated는 builder에서 필수 인자를 하나 더 가진다.
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      itemBuilder: (context, index) {
        // 사용자가 보고 있는 아이템만 build한다.
        var webtoon = snapshot.data![index];
        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
      // 아이템 간 SizedBox로 간격을 둔다.
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
    );
  }
}
