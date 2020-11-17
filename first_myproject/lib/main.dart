import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'First My Project',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: TrafficLamp(),
    );
  }
}

class TrafficLamp extends StatefulWidget {
  @override
  _TrafficLampState createState() => _TrafficLampState();
}

class _TrafficLampState extends State<TrafficLamp> {
  int currentTrafficColorIndex = 0;
  List<Color> currentTrafficColor = [Colors.red, Colors.yellow, Colors.green];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.repeat),
        onPressed: changeTrafficLight,
      ),
      appBar: AppBar(
        title: Text("Trafik Işığı"),
      ),
      body: Center(
        child: Container(
          width: 100,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundColor:
                    currentTrafficColorIndex == 0 ? currentTrafficColor[currentTrafficColorIndex] : Colors.white60,
              ),
              SizedBox(
                height: 5,
              ),
              CircleAvatar(
                backgroundColor:
                    currentTrafficColorIndex == 1 ? currentTrafficColor[currentTrafficColorIndex] : Colors.white60,
              ),
              SizedBox(
                height: 5,
              ),
              CircleAvatar(
                backgroundColor:
                    currentTrafficColorIndex == 2 ? currentTrafficColor[currentTrafficColorIndex] : Colors.white60,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changeTrafficLight() {
    setState(() {
      currentTrafficColorIndex++;
      if (currentTrafficColorIndex > 2) {
        currentTrafficColorIndex = 0;
      }
    });
  }
}
