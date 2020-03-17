import 'dart:math';
import 'definitions.dart';
import 'tic_tac_toe_logic.dart';

class TicTacToe {
  Map board;
  int scorePlayer;
  int scoreComputer;
  int scoreDraw;
  Player player;
  Mode mode;
  String message;
  var winningCombination;

  // setting up the board
  TicTacToe() {
    board = new Map();
    reset();

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

  Player getPlayerFromIndex(int index){
    return board[index];
  }

  bool blockOther() {
    int index;
    List winningMoveList = winningMoves();

    // check different combinations for winning
    for (int loop = 0; loop < winningMoveList.length; ++loop) {
      var moves = winningMoveList[loop];
      index = isGameGoingTobeWonBy(moves, player, board);
      if (index != -1) {
        setMove(index);
        break;
      }
    }
    
    return index != -1;
  }

  bool playWin() {
    int index;
    List winningMoveList = winningMoves();
    
    // check different combinations for winning
    for (int loop = 0; loop < winningMoveList.length; ++loop) {
      var moves = winningMoveList[loop];
      index = isGameGoingTobeWonBy(moves, otherPlayer(player), board);
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
    if (mode == Mode.VERY_HARD) {
      // do something
      // Map tmpBoard = clone(board);

      List tmp = getBestScore(board, Player.COMPUTER);
      int score = tmp[0];
      int move = tmp[1];

      print(" score is $score , $move");

      if (move != null) {
        setMove(move);
        return;
      }
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

    var available = [];

    for (int i = 1; i < 10; ++i) {
      if (board[i] == Player.NONE)
        available.add(i);
    }

    int random = Random().nextInt(available.length);
    setMove(available[random]);

    return;
  }

  bool isGameOver() {
    bool check = false;
    // check if game over
    if (playerWon(Player.PERSON, board)) {
      message = "Game over! Congratulations! You Won!!!";
      ++scorePlayer;
      check = true;
    }
    else if(playerWon(Player.COMPUTER, board)) {
      ++scoreComputer;
      message = "Game over! Computer Won.";
      check = true;
    }
    else if (!nextMovePossible(board)){
      ++scoreDraw;
      message = "Game over! Game drawn.";
      check = true;
    }

    if (check) {
      winningCombination = getWinningCombination(board);
    }

    return check;
  }

  bool choose(index){
    bool flag = true;

    if (playerWon(Player.COMPUTER, board) 
        || playerWon(Player.PERSON, board) 
        || !nextMovePossible(board)) {
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

  List getBestScore(newBoard, Player _player) {
    // int depth = getDepth(board);
    int score = -2;

    int move = -1;

    // check if the board is won?
    if (playerWon(otherPlayer(_player), newBoard)) {
      // game over
      return [1, null];
    }
    else if (playerWon(_player, newBoard)) {
      // game over
      return [-1, null];
    } 
    else if (!nextMovePossible(newBoard)) {
      // game drawn
      return [0, null];
    }

    for (int i = 1; i < 10; ++i) {
      if (board[i] == Player.NONE) { // check for available moves
        newBoard[i] = _player;

        List tmp = getBestScore(newBoard, otherPlayer(_player));
        int scoreForTheMove = -1*tmp[0];

        // if ( depth > 7) {
        //   print("depth $depth index $i score $scoreForTheMove $_player");
        // }

        if (scoreForTheMove > score) {
          move = i;
          score = scoreForTheMove;
        }
        newBoard[i] = Player.NONE;
      }
    }

    if (move == -1) {
      return [0, null]; // no move draw
    }

    return [score, move];
  }
}
