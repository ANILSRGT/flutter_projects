import 'package:flutter/material.dart';

class SmartVoicePage extends StatefulWidget {
  @override
  _SmartVoicePageState createState() => _SmartVoicePageState();
}

class _SmartVoicePageState extends State<SmartVoicePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(flex: 1, child: Text("What can I do for you?")),
              Expanded(flex: 1, child: Text("Press the mic button to start speaking")),
              Expanded(
                flex: 6,
                child: Container(
                  child: Image.network(
                    "https://cdn.pixabay.com/photo/2017/10/24/00/39/bot-icon-2883144_960_720.png",
                    scale: 5,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Image.network(
                  "https://cdn.pixabay.com/photo/2016/02/10/13/39/expectrum-1191724_960_720.png",
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Expanded(
                flex: 3,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.mic),
                      iconSize: 35,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
