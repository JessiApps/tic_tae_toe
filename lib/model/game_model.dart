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
    // Change board value
    bool changed = changeBoardValue(cellId);
    print(_board);
    // Check if there is a winner
    isWinner();
    // Change player
    if (changed) {
      changePlayer();
    }
  }

  bool changeBoardValue(int cellID) {
    final List cords = _getCellCords(cellID);
    final int i = cords[0];
    final int j = cords[1];

    if (_board[i][j] == Player.EMPTY) {
      _board[i][j] = _actualPlayer;
      return true;
    }
    return false;
  }

  bool isWinner() {
    bool isWinner = false;
    // Check vertical - horizontal
    for (int i = 0; (i < 3) && (isWinner == false); i++) {
      // Horizontal
      if ((_board[i][0] == _actualPlayer) &&
          (_board[i][1] == _actualPlayer) &&
          (_board[i][2] == _actualPlayer)) {
        isWinner = true;
      }
      // Vertical
      else if ((_board[0][i] == _actualPlayer) &&
          (_board[1][i] == _actualPlayer) &&
          (_board[2][i] == _actualPlayer)) {
        isWinner = true;
      }
    }

    // Check diagonal
    if ((_board[0][0] == _actualPlayer) &&
        (_board[1][1] == _actualPlayer) &&
        (_board[2][2] == _actualPlayer)) {
      isWinner = true;
    } else if ((_board[0][2] == _actualPlayer) &&
        (_board[1][1] == _actualPlayer) &&
        (_board[2][0] == _actualPlayer)) {
      isWinner = true;
    }

    // Set winner
    if (isWinner) {
      _winner = _actualPlayer;
      return true;
    }
    return false;
  }

  void changePlayer() {
    _actualPlayer = _actualPlayer == Player.X ? Player.O : Player.X;
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
