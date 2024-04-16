import 'package:flutter/material.dart';

class GameModel {
  // MARK: Attributes
  List<List<Player>> _board = List.generate(
    3, // Number of rows
    (_) => List.generate(3, (_) => Player.EMPTY),
  );
  var _actualPlayer = Player.X;
  var _winner = Player.EMPTY;
  final initPlayer = Player.X;

  //MARK: Getters
  String get actualPlayer => _actualPlayer.getSymbol;

  String get winner => _winner.getSymbol;

  String getCellSymbol(int index) {
    final List cords = _getCellCords(index);
    return _board[cords[0]][cords[1]].getSymbol;
  }

  //MARK: Functions

  void pressCell(int cellId) {
    print(_board);
    // Change board value
    changeBoardValue(cellId);
    // Check if there is a winner
    isWinner();
  }

  void changeBoardValue(int cellID) {
    final List cords = _getCellCords(cellID);
    final int i = cords[0];
    final int j = cords[1];

    if (_board[i][j] == Player.EMPTY) {
      _board[i][j] = _actualPlayer;
      // Change player
      _actualPlayer = _actualPlayer == Player.X ? Player.O : Player.X;
    }
  }

  bool isWinner() {
    // TODO: Check if there is a winner
    // if winner
    _winner = _actualPlayer == Player.X ? Player.O : Player.X;
    return false;
  }

  void resetGame() {
    _board = List.generate(
      3, // Number of rows
      (_) => List.generate(3, (_) => Player.EMPTY),
    );
    _actualPlayer = initPlayer;
    _winner = Player.EMPTY;
  }

  List<int> _getCellCords(int cellID) {
    int i = cellID ~/ 3;
    int j = cellID % 3;
    return [i, j];
  }
}

enum Player {
  X(symbol: "X"),
  O(symbol: "O"),
  EMPTY(symbol: "");

  final String symbol;

  const Player({required this.symbol});

  String get getSymbol => symbol;
}
