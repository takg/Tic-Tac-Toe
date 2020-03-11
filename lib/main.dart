import 'package:flutter/material.dart';
import 'board.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: 
        Scaffold(
          appBar: 
            AppBar(title: Text("Tic Tac Toe")),
          body:
              Board(),
        ),
    );
  }
}