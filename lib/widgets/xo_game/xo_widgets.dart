import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../controllers/xo_controller.dart';

class XOWidgets {
  Widget firstBlock({required String activePlayer, required String totalGames}) => Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: Card(
          color: CupertinoColors.white,
          child: SizedBox(
            height: 50,
            child: Center(
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: "Current Player: ",
                  children: [
                    TextSpan(
                      text: activePlayer,
                      style: TextStyle(
                        color: activePlayer == "x" || activePlayer == "X" ? Colors.blue : Colors.pink,
                        fontFamily: 'Coiny',
                      ),
                    ),
                  ],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: CupertinoColors.black),
                ),
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: Card(
          color: CupertinoColors.white,
          child: SizedBox(
            height: 50,
            child: Center(
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: "Games Played: ",
                  children: [TextSpan(text: totalGames.toString())],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: CupertinoColors.black),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );

  Widget boardPlay(
    BuildContext context, {
    required String activePlayer,
    required XOGameController game,
    required bool isTwoPlayer,
    required bool gameOver,
    required int turn,
    required void Function() updateState,
  }) => Expanded(
    child: GridView.count(
      padding: const EdgeInsets.all(16),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      childAspectRatio: 1.0,
      crossAxisCount: 3,
      children: List.generate(
        9,
        (index) => InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap:
              gameOver
                  ? null
                  : () => _onTap(
                    index,
                    activePlayer: activePlayer,
                    game: game,
                    isTwoPlayer: isTwoPlayer,
                    gameOver: gameOver,
                    turn: turn,
                    updateState: updateState,
                  ),
          child: Container(
            decoration: BoxDecoration(color: Theme.of(context).shadowColor, borderRadius: BorderRadius.circular(16)),
            child: Center(
              child: Text(
                Player.playerX.contains(index)
                    ? 'X'
                    : Player.playerO.contains(index)
                    ? 'O'
                    : '',
                style: TextStyle(
                  color: Player.playerX.contains(index) ? Colors.blue : Colors.pink,
                  fontSize: 60,
                  fontFamily: 'Coiny',
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );

  Widget scoreBoardWidget({
    required String result,
    required int xWins,
    required int oWins,
    required bool isTwoPlayer,
  }) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(result, style: const TextStyle(color: Colors.white, fontSize: 42), textAlign: TextAlign.center),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('XPlayer: $xWins', style: const TextStyle(color: Colors.white, fontSize: 16)),
            Text(
              '${!isTwoPlayer ? "AI: " : "OPlayer: "}$oWins',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 4),
        const Divider(color: Colors.white, thickness: 1),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_buildWinBar(count: xWins, color: Colors.blue), _buildWinBar(count: oWins, color: Colors.pink)],
        ),
      ],
    ),
  );

  Widget _buildWinBar({required int count, required Color color}) {
    int columns = 15;
    int rows = (count / columns).ceil();

    return SizedBox(
      width: columns * 12,
      height: rows * 14,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
        ),
        itemCount: count,
        itemBuilder: (context, index) => Icon(Icons.circle, size: 8, color: color),
      ),
    );
  }

  _onTap(
    int index, {
    required String activePlayer,
    required XOGameController game,
    required bool isTwoPlayer,
    required bool gameOver,
    required int turn,
    required void Function() updateState,
  }) async {
    if ((Player.playerX.contains(index) || Player.playerO.contains(index)) || gameOver) return;

    game.playGame(index, activePlayer);
    updateState();

    if (!isTwoPlayer && !gameOver && turn < 8) {
      await Future.delayed(const Duration(milliseconds: 100));
      final aiPlayer = activePlayer == 'X' ? 'O' : 'X';
      game.playGameForAI(aiPlayer, updateState);
    }
  }
}
