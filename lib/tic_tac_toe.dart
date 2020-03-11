import 'dart:math';

enum Mode {EASY, MEDIUM, HARD}
enum Player {NONE, PERSON, COMPUTER}

class TicTacToe {
  Map board;
  int scorePlayer;
  int scoreComputer;
  int scoreDraw;
  Player player;
  Mode mode;
  String message;
  var winningMoves;
  var winningCombination;

  TicTacToe() {
    board = new Map();
    winningMoves = [];
    reset();

    winningMoves.add([1, 2, 3]);
    winningMoves.add([4, 5, 6]);
    winningMoves.add([7, 8, 9]);
    winningMoves.add([1, 4, 7]);
    winningMoves.add([2, 5, 8]);
    winningMoves.add([3, 6, 9]);
    winningMoves.add([1, 5, 9]);
    winningMoves.add([3, 5, 7]);
  }

  void reset() {
    scorePlayer = 0;
    scoreComputer = 0;
    scoreDraw = 0;
    mode = Mode.EASY;

    newGame();
  }

  void newGame() {
    player = Player.PERSON;
    message = "";
    winningCombination = [];

    for (int i = 1; i < 10; ++i) {
      board[i] = Player.NONE;
    }
  }

  void switchPlayer() {
    player = otherPlayer(player);
  }

  Player otherPlayer(Player _player) {
    if (_player == Player.PERSON) {
      return Player.COMPUTER;
    }
    else if (_player == Player.COMPUTER) {
      return Player.PERSON;
    }

    return Player.NONE;
  }

  Player getPlayerFromIndex(int index){
    return board[index];
  }

  bool blockOther() {
    int index;
    
    // check different combinations for winning
    for (int loop = 0; loop < winningMoves.length; ++loop) {
      var moves = winningMoves[loop];
      index = isGameGoingTobeWonBy(moves, player);
      if (index != -1) {
        setMove(index);
        break;
      }
    }
    
    return index != -1;
  }

  bool playWin() {
    int index;
    
    // check different combinations for winning
    for (int loop = 0; loop < winningMoves.length; ++loop) {
      var moves = winningMoves[loop];
      index = isGameGoingTobeWonBy(moves, otherPlayer(player));
      if (index != -1) {
        setMove(index);
        break;
      }
    }
    
    return index != -1;
  }

  void setMove(int index) {
    board[index] = player;
  }

  void playNextMove() {
    var available = [];

    for (int i = 1; i < 10; ++i) {
      if (board[i] == Player.NONE)
        available.add(i);
    }

    if (mode == Mode.HARD) {
      // play winning move
      if (playWin()) {
        return;
      }
    }

    if (mode != Mode.EASY) {
      // check if other player is winning, then block
      if (blockOther()) {
        return;
      }
    }

    int random = Random().nextInt(available.length);
    setMove(available[random]);

    return;
  }

  int getCountForIndex(int index, Player _player) {
    if (board[index] == _player) {
      return 1;
    } 
    else if (board[index] == otherPlayer(_player)) {
      return -1;
    }
    return 0;
  }

  bool isGameWonByPlayer( var indexes, Player _player) {
    int count = 0;
    for (int loop = 0; loop < indexes.length; ++loop) {
      count += getCountForIndex(indexes[loop], _player);
    }
    
    if (count == 3) {
      winningCombination = indexes;
    }

    return count == 3;
  }

  int isGameGoingTobeWonBy( var indexes, Player _player) {
    _player = otherPlayer(_player);

    int count = 0;
    int index = -1;

    for (int loop = 0; loop < indexes.length; ++loop) {
      int x = getCountForIndex(indexes[loop], _player);
      count += x;
      if (x == 0) {
        index = indexes[loop];
      }
    }

    if (count != 2) {
      index = -1;
    }
    
    return index;
  }

  bool playerWon(Player _player) {
    bool flag = false;

    // check different combinations for winning
    for (int loop = 0; loop < winningMoves.length; ++loop) {
      var moves = winningMoves[loop];
      if (isGameWonByPlayer(moves, _player)) {
        flag = true;
        break;
      }
    }

    return flag;
  }

  bool nextMovePossible() {
    for (int i = 1; i < 10; ++i) {
      if (board[i] == Player.NONE)
        return true;
    }

    return false;
  }

  bool isGameOver() {
    bool check = false;
    // check if game over
    if (playerWon(Player.PERSON)) {
      message = "Game over! Congratulations! You Won!!!";
      ++scorePlayer;
      check = true;
    }
    else if(playerWon(Player.COMPUTER)) {
      ++scoreComputer;
      message = "Game over! Computer Won.";
      check = true;
    }
    else if (!nextMovePossible()){
      ++scoreDraw;
      message = "Game over! Game drawn.";
      check = true;
    }

    return check;
  }

  bool choose(index){
    bool flag = true;

    if (playerWon(Player.COMPUTER) 
        || playerWon(Player.PERSON) 
        || !nextMovePossible()) {
          // game over, nothing to do
      return false;
    }

    if (board[index] != Player.NONE) {
      message = "Please select a valid position";
      return false;
    }
    else {
      message = "";
      setMove(index);
    }

    return flag;
  }

  void computerMove() {
    if (!isGameOver()) {
      switchPlayer(); // switch to computer
      playNextMove();
      if (!isGameOver()){
        switchPlayer(); // switch back to user
      }
    }
  }
}