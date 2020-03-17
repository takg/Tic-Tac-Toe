import 'package:flutter/material.dart';
import 'definitions.dart';
import 'tic_tac_toe.dart';

class BoardButton extends StatelessWidget {
  final TicTacToe ticTacToe;
  final Function callback;
  final int index;
  BoardButton(this.index, this.ticTacToe, this.callback);

  @override
  Widget build(BuildContext context) {
    String text = '';
    if (ticTacToe.getPlayerFromIndex(index) == Player.COMPUTER) {
      text = "O";
    } 
    else if (ticTacToe.getPlayerFromIndex(index) == Player.PERSON) {
      text = "X";
    }

    double buttonWidth = MediaQuery.of(context).size.width/3 - 20;
    double buttonHeight = buttonWidth;
    Color textColor = Colors.white;

    // show the text of winning combination in different color
    for (int loop = 0; loop < ticTacToe.winningCombination.length; ++loop) {
      if (ticTacToe.winningCombination[loop] == this.index) {
          textColor = Colors.yellowAccent;
      }
    }

    return 
        Container(
          width: buttonWidth,
          height: buttonHeight,
          child: 
              RaisedButton(
                  child: Text(text,
                          style: TextStyle(
                                    fontSize: 40,
                                    color: textColor,
                                    ),
                          ),
                  color: Colors.teal,
                  onPressed: () {
                    callback(index);
                  }),                  
                );
  }
}
