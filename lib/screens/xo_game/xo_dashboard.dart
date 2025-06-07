import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class XODashboardScreen extends StatelessWidget {
  const XODashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Tic Tac Toe Game", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset("assets/images/preview.png", color: CupertinoColors.white),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Flexible(
                    child: _buildButtonCard(
                      context,
                      isTwoPlayer: false,
                      title: "Play With AI",
                      image: "assets/images/ai-gaming.png",
                    ),
                  ),
                  Flexible(
                    child: _buildButtonCard(
                      context,
                      isTwoPlayer: true,
                      title: "Play with Friend",
                      image: "assets/images/play_with_friend.png",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonCard(context, {required bool isTwoPlayer, required String title, required String image}) =>
      GestureDetector(
        onTap:
            () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(isTwoPlayer: isTwoPlayer))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  Image.asset(image, height: 60, width: 60, color: CupertinoColors.white),
                  Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ),
      );
}
