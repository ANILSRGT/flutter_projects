import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
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
              height: (MediaQuery.of(context).size.height - 80) * 0.9,
              child: Center(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed("/game"),
                  child: Image.asset(
                    "assets/images/playicon.png",
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: (MediaQuery.of(context).size.height - 80) * 0.1,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: () => Future.delayed(Duration(seconds: 1))
                      .whenComplete(() => SystemChannels.platform.invokeMethod('SystemNavigator.pop')),
                  child: Image.asset("assets/images/closeicon.png"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
