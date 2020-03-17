import 'package:flutter/material.dart';
import 'board_button.dart';
import 'tic_tac_toe.dart';
import 'new_game_button.dart';
import 'definitions.dart';
import 'mode_drop_down.dart';

class Board extends StatefulWidget {
  @override
  _Board createState() {
    return _Board();
  }
}

class _Board extends State<Board> {
  TicTacToe ticTacToe;
  Color winningColor;


  _Board() {
    ticTacToe = TicTacToe();
    winningColor = Colors.purple;
  }

  void newGame() {
    ticTacToe.newGame();
    _refreshGUI();
  }

  void _refreshGUI() {
    setState((){});
  }

  void clicked(int index) {
    if (ticTacToe.choose(index)) {

      // compute the next move
      Future.delayed(const Duration(milliseconds: 100), () {
        ticTacToe.computerMove();
        _refreshGUI();
      });
    }

    _refreshGUI();
  }

  Text getText(String text) {
    return Text(text,
                style: TextStyle(
                    fontSize: 25, 
                    color: Colors.green),
          );
  }

  Text diplayMessage(String text) {
    return Text(text,
                style: TextStyle(
                    fontSize: 20, 
                    color: winningColor),
          );
  }

  void onModeChange(Mode value) {
    ticTacToe.mode = value;
    _refreshGUI();
  }

  @override
  Widget build(BuildContext context) {
    double heightPadding = 15;
    int scorePlayer = ticTacToe.scorePlayer;
    int scoreDraw = ticTacToe.scoreDraw;
    int scoreComputer = ticTacToe.scoreComputer;
    return 
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                getText("YOU: $scorePlayer DRAW: $scoreDraw, COMPUTER: $scoreComputer"),
              ],
            ),
            SizedBox(height: heightPadding,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Select Mode",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20),
                ),                
                ModeDropDown(onModeChange),
              ],
            ),
            SizedBox(height: heightPadding,),
            diplayMessage(ticTacToe.message),
            Spacer(flex: 2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                BoardButton(1, ticTacToe, clicked),
                BoardButton(2, ticTacToe, clicked),
                BoardButton(3, ticTacToe, clicked),
              ],
            ),
            SizedBox(height: heightPadding,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                BoardButton(4, ticTacToe, clicked),
                BoardButton(5, ticTacToe, clicked),
                BoardButton(6, ticTacToe, clicked),
              ],
            ),
            SizedBox(height: heightPadding,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                BoardButton(7, ticTacToe, clicked),
                BoardButton(8, ticTacToe, clicked),
                BoardButton(9, ticTacToe, clicked),
              ],
            ),
            SizedBox(height: heightPadding,),
            NewGameButton(newGame),
            SizedBox(height: heightPadding,),
          ],
        );
    }
}
