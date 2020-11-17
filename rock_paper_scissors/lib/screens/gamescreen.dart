import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  ValueNotifier<String> _selected = ValueNotifier<String>("noneselect");
  ValueNotifier<bool> _isSelected = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text("Rock Paper Scissors"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        height: double.maxFinite,
        child: Column(
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height - 80) * 0.2 / 3,
              child: Center(
                child: Text(
                  "BOT",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Container(
              height: (MediaQuery.of(context).size.height - 80) * 0.25,
              child: ValueListenableBuilder(
                valueListenable: _isSelected,
                builder: (context, value, child) {
                  return Center(
                    child: value
                        ? Image.asset("assets/images/" + botSelect() + ".png")
                        : Image.asset("assets/images/noneselect.png"),
                  );
                },
              ),
            ),
            Container(
              height: (MediaQuery.of(context).size.height - 80) * 0.2 / 3,
              child: Center(
                child: Text(
                  "- VS -",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Container(
              height: (MediaQuery.of(context).size.height - 80) * 0.25,
              child: Center(
                child: ValueListenableBuilder(
                  valueListenable: _selected,
                  builder: (BuildContext context, String value1, Widget child) {
                    return ValueListenableBuilder(
                      valueListenable: _isSelected,
                      builder: (BuildContext context, bool value2, Widget child) {
                        if (value2)
                          return Image.asset("assets/images/$value1.png");
                        else
                          return Image.asset("assets/images/noneselect.png");
                      },
                    );
                  },
                ),
              ),
            ),
            Container(
              height: (MediaQuery.of(context).size.height - 80) * 0.2 / 3,
              child: Center(
                child: Text(
                  "YOU",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Container(
              height: (MediaQuery.of(context).size.height - 80) * 0.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (!_isSelected.value) onSelect("rock");
                    },
                    child: Image.asset("assets/images/rock.png"),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (!_isSelected.value) onSelect("paper");
                    },
                    child: Image.asset("assets/images/paper.png"),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (!_isSelected.value) onSelect("scissors");
                    },
                    child: Image.asset("assets/images/scissors.png"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String botSelect() {
    int rand = Random().nextInt(3);
    switch (rand) {
      case 0:
        return "rock";
        break;
      case 1:
        return "paper";
        break;
      case 2:
        return "scissors";
        break;
      default:
        return "noneselect";
    }
  }

  onSelect(String selected) {
    this._selected.value = selected;
    this._isSelected.value = true;
    Future.delayed(Duration(seconds: 3)).whenComplete(() => this._isSelected.value = false);
  }
}
