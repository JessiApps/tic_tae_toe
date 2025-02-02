class GameModel {
  // MARK: Attributes
  int _boardSize = 3;
  late List<List<Player>> _board;
  Player _actualPlayer = Player.X;
  Player _winner = Player.EMPTY;
  final initPlayer = Player.X;
  int _moveCount = 0;
  GameStatus _gameStatus = GameStatus.PLAYING;

  //MARK: Constructor
  GameModel() {
    generateBoard();
  }

  //MARK: Getters and setters
  String get actualPlayer => _actualPlayer.getSymbol;

  String get winner => _winner.getSymbol;

  GameStatus get gameStatus => _gameStatus;

  String getCellSymbol(int index) {
    final List cords = _getCellCords(index);
    return _board[cords[0]][cords[1]].getSymbol;
  }

  set boardSize(int size) => _boardSize = size;

  //MARK: Functions

  void generateBoard() {
    _board = List.generate(
      _boardSize,
      (_) => List.generate(_boardSize, (_) => Player.EMPTY),
    );
  }

  void pressCell(int cellId) {
    // Change board value
    if (changeBoardValue(cellId)) {
      _moveCount++;
      print(_board);
      // Check if there is a winner
      if (isWinner()) {
        _gameStatus = GameStatus.WINNER;
        _winner = _actualPlayer;
      }
      // Check if game is finished
      isFinished();
      // Change player
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
    for (int i = 0; i < _boardSize; i++) {
      if (_checkRow(i) || _checkColumn(i)) return true;
    }
    return _checkDiagonals();
  }

  bool _checkRow(int row) {
    return _board[row].every((cell) => cell == _actualPlayer);
  }

  bool _checkColumn(int col) {
    return _board.every((row) => row[col] == _actualPlayer);
  }

  bool _checkDiagonals() {
    return (_board[0][0] == _actualPlayer &&
            _board[1][1] == _actualPlayer &&
            _board[2][2] == _actualPlayer) ||
        (_board[0][2] == _actualPlayer &&
            _board[1][1] == _actualPlayer &&
            _board[2][0] == _actualPlayer);
  }

  void changePlayer() {
    _actualPlayer = _actualPlayer == Player.X ? Player.O : Player.X;
  }

  void isFinished() {
    if (_gameStatus == GameStatus.PLAYING) {
      if (_moveCount == _boardSize * _boardSize) {
        _gameStatus = GameStatus.DRAW;
      }
    }
  }

  void resetGame() {
    // Generate board
    generateBoard();
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
