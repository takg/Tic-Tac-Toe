import 'definitions.dart';


Player otherPlayer(Player _player) {
  if (_player == Player.PERSON) {
    return Player.COMPUTER;
  }
  else if (_player == Player.COMPUTER) {
    return Player.PERSON;
  }

  return Player.NONE;
}

int getCountForIndex(int index, Player _player, Map _board) {
  if (_board[index] == _player) {
    return 1;
  } 
  else if (_board[index] == otherPlayer(_player)) {
    return -1;
  }
  return 0;
}

int isGameGoingTobeWonBy( var indexes, Player _player, Map _board) {
  _player = otherPlayer(_player);

  int count = 0;
  int index = -1;

  for (int loop = 0; loop < indexes.length; ++loop) {
    int x = getCountForIndex(indexes[loop], _player, _board);
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

bool nextMovePossible(board) {
  for (int i = 1; i < 10; ++i) {
    if (board[i] == Player.NONE)
      return true;
  }

  return false;
}

List winningMoves() {
  List winningMoveList = [ 
                          [1, 2, 3],
                          [4, 5, 6],
                          [7, 8, 9],
                          [1, 4, 7],
                          [2, 5, 8],
                          [3, 6, 9],
                          [1, 5, 9],
                          [3, 5, 7]
                        ];

  return winningMoveList;
}


bool isGameWonByPlayer(var indexes, Player _player, Map _board) {
  int count = 0;
  for (int loop = 0; loop < indexes.length; ++loop) {
    count += getCountForIndex(indexes[loop], _player, _board);
  }

  return count == 3; // adding up
}

bool playerWon(Player _player, Map _board) {
  bool flag = false;
  List winningMoveList = winningMoves();

  // check different combinations for winning
  for (int loop = 0; loop < winningMoveList.length; ++loop) {
    var moves = winningMoveList[loop];
    if (isGameWonByPlayer(moves, _player, _board)) {
      flag = true;
      break;
    }
  }

  return flag;
}

List getWinningCombination(Map _board) {
  List winningMoveList = winningMoves();

  // check different combinations for winning
  for (int loop = 0; loop < winningMoveList.length; ++loop) {
    var moves = winningMoveList[loop];
    if (_board[moves[0]] == _board[moves[1]] &&
        _board[moves[1]] == _board[moves[2]] && 
        _board[moves[0]] != Player.NONE) {
      return moves;
    }
  }

  return [];
}

int getDepth(board){
  int count = 0;

  for (int i = 1; i < 10; ++i) {
    if (board[i] != Player.NONE)
      count += 1;
  }
  
  return count;
}

Map clone(board) {
  Map newBoard = new Map();

  for (int i = 1; i < 10; ++i) {
    newBoard[i] = board[i];
  }

  return newBoard;
}