import 'package:flutter/material.dart';
import 'definitions.dart';

class ModeDropDown extends StatefulWidget {
  final Function callback;
  ModeDropDown(this.callback);

  @override
  _ModeDropDown createState() {
    return _ModeDropDown(callback);
  }
}

class _ModeDropDown extends State<ModeDropDown> {
  Mode mode;
  Function callback;

  _ModeDropDown(this.callback) {
    mode = Mode.EASY;
  }

  void run(Mode value){
    setState(() {
      mode = value;
      callback(value);
    });
  }

  @override
  Widget build(BuildContext context) {

    return  DropdownButton<Mode>(
              value: mode,
              icon:Icon(Icons.arrow_drop_down),
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 20),
              onChanged: run,
              items: getModeList().map<DropdownMenuItem<Mode>>(
                  (String textValue) {
                    return DropdownMenuItem<Mode>(
                      value: getMode(textValue),
                      child: Text(textValue),
                      );
                  }).toList(),
            );

  }
}