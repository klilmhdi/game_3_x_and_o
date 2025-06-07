import 'dart:math';

class Player {
  static List<int> playerX = [];
  static List<int> playerO = [];
}

class XOGameController {
  List<List<int>> winningCombinations = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  void playGame(int index, String activePlayer) {
    if (activePlayer == 'X') {
      Player.playerX.add(index);
    } else {
      Player.playerO.add(index);
    }
  }

  String checkWinner() {
    for (var combo in winningCombinations) {
      if (combo.every(Player.playerX.contains)) return 'X';
      if (combo.every(Player.playerO.contains)) return 'O';
    }
    return '';
  }

  int? _getWinningMove(List<int> playerMoves, List<int> emptyCells) {
    for (var combo in winningCombinations) {
      var available = combo.where((cell) => emptyCells.contains(cell)).toList();
      var owned = combo.where((cell) => playerMoves.contains(cell)).toList();

      if (available.length == 1 && owned.length == 2) {
        return available.first;
      }
    }
    return null;
  }

  void playGameForAI(String activePlayer, void Function() updateState) async {
    List<int> emptyCells = List.generate(9, (i) => i)
        .where((i) => !(Player.playerX.contains(i) || Player.playerO.contains(i)))
        .toList();

    int? index = _getWinningMove(Player.playerO, emptyCells) ??
        _getWinningMove(Player.playerX, emptyCells) ??
        (emptyCells.isNotEmpty ? emptyCells[Random().nextInt(emptyCells.length)] : null);

    if (index != null) {
      playGame(index, activePlayer);
      updateState();
    }
  }
}
