import 'package:flutter/material.dart';
import 'package:tic_tae_toe/model/game_model.dart';

class GameVM extends ChangeNotifier {
  final GameModel _model = GameModel();
  String _actualPlayer = "";
  String _winner = "";

  GameVM() {
    _model.resetGame();
    _actualPlayer = _model.actualPlayer;
  }

  // MARK: Getters and setters
  String get actualPlayer => _actualPlayer;
  String get winner => _winner;

  String getCellSymbol(int cellID) {
    return _model.getCellSymbol(cellID);
  }

  GameStatus getGameStatus() {
    return _model.gameStatus;
  }

  void setGameDifficulty(int size) {
    _model.boardSize = size;
  }

  // Mark: Functions

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
}
