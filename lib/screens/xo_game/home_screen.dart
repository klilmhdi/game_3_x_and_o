import 'package:flutter/material.dart';
import 'package:game_3_x_and_o/widgets/xo_game/xo_widgets.dart';

import '../../controllers/xo_controller.dart';

class HomePage extends StatefulWidget {
  final bool isTwoPlayer;

  const HomePage({super.key, required this.isTwoPlayer});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String activePlayer = 'X';
  String result = '';
  int turn = 0;
  int xWins = 0;
  int oWins = 0;
  int totalGames = 0;
  bool gameOver = false;
  XOGameController game = XOGameController();

  void updateState() {
    if (gameOver) return;

    setState(() {
      String winnerPlayer = game.checkWinner();

      if (winnerPlayer != '') {
        gameOver = true;
        result = '$winnerPlayer is the winner';

        if (winnerPlayer == 'X') {
          xWins++;
        } else {
          oWins++;
        }

        totalGames++;
        Future.delayed(const Duration(seconds: 2), resetGame);
      } else if (turn == 8) {
        result = 'It\'s Draw!';
        gameOver = true;
        totalGames++;
        Future.delayed(const Duration(seconds: 2), resetGame);
      } else {
        activePlayer = (activePlayer == 'X') ? 'O' : 'X';
        turn++;
      }
    });
  }

  void resetGame() {
    setState(() {
      Player.playerX = [];
      Player.playerO = [];
      activePlayer = 'X';
      gameOver = false;
      turn = 0;
      result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
            MediaQuery.of(context).orientation == Orientation.portrait
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    XOWidgets().firstBlock(activePlayer: activePlayer, totalGames: totalGames.toString()),
                    XOWidgets().boardPlay(
                      context,
                      activePlayer: activePlayer,
                      game: game,
                      isTwoPlayer: widget.isTwoPlayer,
                      gameOver: gameOver,
                      turn: turn,
                      updateState: updateState,
                    ),
                    XOWidgets().scoreBoardWidget(
                      result: result,
                      xWins: xWins,
                      oWins: oWins,
                      isTwoPlayer: widget.isTwoPlayer,
                    ),
                  ],
                )
                : Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          XOWidgets().firstBlock(activePlayer: activePlayer, totalGames: totalGames.toString()),
                          const SizedBox(height: 20),
                          XOWidgets().scoreBoardWidget(
                            result: result,
                            xWins: xWins,
                            oWins: oWins,
                            isTwoPlayer: widget.isTwoPlayer,
                          ),
                        ],
                      ),
                    ),
                    XOWidgets().boardPlay(
                      context,
                      activePlayer: activePlayer,
                      game: game,
                      isTwoPlayer: widget.isTwoPlayer,
                      gameOver: gameOver,
                      turn: turn,
                      updateState: updateState,
                    ),
                  ],
                ),
      ),
    );
  }
}
