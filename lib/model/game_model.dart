class GameModel {
  // MARK: Attributes
  final _numRows = 3;
  late List<List<Player>> _board;
  var _actualPlayer = Player.X;
  var _winner = Player.EMPTY;
  final initPlayer = Player.X;
  var _numMoves = 0;
  var _gameStatus = GameStatus.PLAYING;

  //MARK: Getters
  String get actualPlayer => _actualPlayer.getSymbol;

  String get winner => _winner.getSymbol;

  GameStatus get gameStatus => _gameStatus;

  String getCellSymbol(int index) {
    final List cords = _getCellCords(index);
    return _board[cords[0]][cords[1]].getSymbol;
  }

  //MARK: Functions

  void pressCell(int cellId) {
    // Change board value
    bool changed = changeBoardValue(cellId);
    _numMoves += 1;
    print(_board);
    // Check if there is a winner
    isWinner();
    // Check if game is finished
    isFinished();
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

  void isWinner() {
    // Check vertical - horizontal
    for (int i = 0; (i < 3) && (_gameStatus == GameStatus.PLAYING); i++) {
      // Horizontal
      if ((_board[i][0] == _actualPlayer) &&
          (_board[i][1] == _actualPlayer) &&
          (_board[i][2] == _actualPlayer)) {
        _gameStatus = GameStatus.WINNER;
      }
      // Vertical
      else if ((_board[0][i] == _actualPlayer) &&
          (_board[1][i] == _actualPlayer) &&
          (_board[2][i] == _actualPlayer)) {
        _gameStatus = GameStatus.WINNER;
      }
    }

    // Check diagonal
    if ((_board[0][0] == _actualPlayer) &&
        (_board[1][1] == _actualPlayer) &&
        (_board[2][2] == _actualPlayer)) {
      _gameStatus = GameStatus.WINNER;
    } else if ((_board[0][2] == _actualPlayer) &&
        (_board[1][1] == _actualPlayer) &&
        (_board[2][0] == _actualPlayer)) {
      _gameStatus = GameStatus.WINNER;
    }

    // Set winner
    if (_gameStatus == GameStatus.WINNER) {
      _winner = _actualPlayer;
    }
  }

  void changePlayer() {
    _actualPlayer = _actualPlayer == Player.X ? Player.O : Player.X;
  }

  void isFinished() {
    if (_gameStatus == GameStatus.PLAYING) {
      int boardSize = _numRows * _numRows;
      if (boardSize == _numMoves) {
        _gameStatus = GameStatus.DRAW;
      }
    }
  }

  void resetGame() {
    // Generate board
    _board = List.generate(
      _numRows,
      (_) => List.generate(_numRows, (_) => Player.EMPTY),
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

enum GameStatus {
  PLAYING,
  DRAW,
  WINNER;
}
