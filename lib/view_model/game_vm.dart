import 'package:flutter/material.dart';
import 'package:tic_tae_toe/model/game_model.dart';

class GamelVM extends ChangeNotifier {
  final GameModel _model = GameModel();
  String _actualPlayer = "";
  String _winner = "";

  GamelVM() {
    _actualPlayer = _model.actualPlayer;
  }

  String get actualPlayer => _actualPlayer;
  String get winner => _winner;

  String getCellSymbol(int cellID) {
    return _model.getCellSymbol(cellID);
  }

  void resetGame() {
    _model.resetGame();
    _actualPlayer = _model.actualPlayer;
    _winner = _model.winner;
    notifyListeners();
  }

  void pressCell(int cellId) {
    _model.pressCell(cellId);
    _actualPlayer = _model.actualPlayer;
    _winner = _model.winner;
    notifyListeners();
  }

  bool isWinner() {
    return winner != "" ? true : false;
  }
}
