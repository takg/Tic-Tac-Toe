import 'package:flutter/material.dart';

class NewGameButton extends StatelessWidget {
  final Function callback;

  NewGameButton(this.callback);
  
  @override
  Widget build(BuildContext context) {
    return FlatButton(
                  color: Colors.teal[300],
                  child: Text("New Game",
                          style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  ),
                          ),
                  shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          ),                    
                  onPressed: callback,
            );
  }
}