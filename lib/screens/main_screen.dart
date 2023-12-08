import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:same_cards_app/screens/single_game_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  void _showExitConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('종료'),
          content: Text('정말 종료하시겠습니까?'),
          actions: [
            TextButton(
              child: const Text('취소'),
              onPressed: () {
                Navigator.of(context).pop(); // 모달 창 닫기
              },
            ),
            TextButton(
              child: const Text('확인'),
              onPressed: () {
                // exit(0);
                SystemNavigator.pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                const Text(
                  '준비중입니다.',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  child: const Text('확인'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
      minimumSize: const Size(240, 60),
      textStyle: const TextStyle(fontSize: 20),
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/cat.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "같은 그림 찾기!",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                style: buttonStyle,
                child: const Text("싱글 플레이"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SingleGameScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: buttonStyle,
                child: const Text("멀티 플레이"),
                onPressed: () => _showModal(context),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: buttonStyle,
                child: const Text("커뮤니티"),
                onPressed: () => _showModal(context),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: buttonStyle,
                onPressed: () => _showExitConfirmation(context),
                child: const Text("종료"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
