import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'dart:async';
import 'dart:math';

class SingleGameScreen extends StatefulWidget {
  const SingleGameScreen({super.key});

  @override
  State<SingleGameScreen> createState() => _SingleGameScreenState();
}

// TODO 고정된 아이콘 및 아이콘 색상을 랜덤한 아이콘/아이콘 색상으로 변경
class _SingleGameScreenState extends State<SingleGameScreen> {
  List<IconData> icons = [
    Icons.home,
    Icons.star,
    Icons.lightbulb_outline,
    Icons.phone,
    Icons.camera_alt,
    Icons.favorite,
    Icons.music_note,
    Icons.pets,
    // Icons.ac_unit_sharp,
    // Icons.mood,
    // Icons.beach_access,
  ];

  final Map<IconData, Color> iconColors = {
    Icons.home: Colors.red,
    Icons.star: Colors.green,
    Icons.lightbulb_outline: Colors.blue,
    Icons.phone: Colors.orange,
    Icons.camera_alt: Colors.purple,
    Icons.favorite: Colors.pink,
    Icons.music_note: Colors.lightBlue,
    Icons.pets: Colors.teal,
    // Icons.ac_unit_sharp: Colors.grey,
    // Icons.mood: Colors.yellowAccent,
    // Icons.beach_access: Colors.lightBlue,
  };

  late List<GlobalKey<FlipCardState>> cardKeys;
  int countdownNumber = 3; // 카운트다운을 위한 변수
  double opacity = 1.0;

  @override
  void initState() {
    super.initState();
    icons = [...icons, ...icons]; // 각 아이콘을 두 번씩 추가
    icons.shuffle(Random()); // 아이콘 목록을 무작위로 섞음
    // 각 카드에 대한 키를 초기화
    cardKeys =
        List.generate(icons.length, (index) => GlobalKey<FlipCardState>());

    // 카운트다운 시작
    _startCountdown();
  }

  // 카운트다운
  void _startCountdown() {
    setState(() {
      opacity = 0.3; // UI 요소들을 흐리게 처리
    });
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdownNumber > -1) {
        setState(() {
          countdownNumber--;
        });
      } else {
        timer.cancel();
        setState(() {
          opacity = 1.0; // 카운트다운이 끝나면 UI 요소들을 다시 명확하게 처리
        });
        flipCards(); // 카운트다운이 끝나면 카드 뒤집기 시작
      }
    });
  }

  // 카드 뒤집기
  void flipCards() {
    // 각 카드를 순차적으로 뒤집기
    for (int i = 0; i < icons.length; i++) {
      Timer(Duration(milliseconds: 500 + (i * 500)), () {
        cardKeys[i].currentState?.toggleCard();
      });
    }

    // 모든 카드가 뒤집힌 후 3초 후에 다시 뒤집기
    int totalDuration = 500 + (icons.length * 500) + 3000; // 전체 지연 시간 계산
    Timer(Duration(milliseconds: totalDuration), () {
      for (var key in cardKeys) {
        key.currentState?.toggleCard();
      }
    });

    // for (int i = 0; i < icons.length; i++) {
    //   Timer(Duration(milliseconds: 2000 + (i * 500)), () {
    //     cardKeys[i].currentState?.toggleCard();
    //   });
    // }

    // int totalDuration = 2000 + (icons.length * 500) + 3000;
    // Timer(Duration(milliseconds: totalDuration), () {
    //   for (var key in cardKeys) {
    //     key.currentState?.toggleCard();
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game UI'), // TODO 화면 구성 고민
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedOpacity(
            opacity: opacity,
            duration: const Duration(seconds: 0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.person, size: 30),
                      ),
                      Column(
                        children: [
                          Text(
                            'Player',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            '4', // TODO 점수는 변동된다. 변수로 변경 예정
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Com',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            '4', // TODO 점수는 변동된다. 변수로 변경 예정
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.computer, size: 30),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, // 4열
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 2 / 3, // 카드 비율
                    ),
                    itemCount: 16, // 카드 수
                    itemBuilder: (context, index) {
                      IconData icon = icons[index];
                      Color color = iconColors[icon] ?? Colors.black;
                      return FlipCard(
                        key: cardKeys[index],
                        fill: Fill.fillBack,
                        direction: FlipDirection.HORIZONTAL, // default
                        side: CardSide.BACK,
                        front: Card(
                          child: Icon(
                            icon,
                            size: 50.0,
                            color: color,
                          ),
                        ),
                        back: Card(
                          color: Colors.grey[10],
                        ),
                        // autoFlipDuration: const Duration(seconds: 2),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          if (countdownNumber > -1)
            Text(
              '$countdownNumber',
              style: TextStyle(fontSize: 100, fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}
