import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:emojis/emojis.dart';
import 'package:flutter/rendering.dart';
import 'package:smart_home_ui/pages/smart_voice_page.dart';
import 'package:smart_home_ui/widgets/on_off_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color bottomnavbarSelectedItemColor = Colors.black;
  final Color bottomnavbarUnselectedItemColor = Colors.grey.shade400;
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Transform.translate(
        offset: Offset(0, 10),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://cdn.pixabay.com/photo/2017/02/27/19/34/microphone-2104091_960_720.png"),
            ),
          ),
          child: FloatingActionButton(
            elevation: 0,
            backgroundColor: Colors.transparent,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SmartVoicePage()),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _bottomNavBar(),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          _header(),
          SizedBox(height: 16),
          _body(),
        ],
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 28,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Benjamin Frank " + Emojis.wavingHand,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 28,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Let's control your hutch now!",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ],
        ),
        Stack(
          alignment: Alignment.topRight + Alignment(0.3, -0.3),
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: IconButton(
                icon: Icon(CupertinoIcons.bell_fill),
                color: Colors.grey.shade400,
                onPressed: () {},
              ),
            ),
            Container(
              height: 18,
              width: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueAccent,
              ),
              child: Center(
                child: Text(
                  "2",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _body() {
    return Column(
      children: [
        Image.network(
          "https://cdn.pixabay.com/photo/2019/02/12/07/36/smart-home-3991595_960_720.jpg",
          width: double.infinity,
          height: 175,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Emojis.highVoltage + " Battery",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 10),
              LayoutBuilder(
                builder: (context, constraints) {
                  return Row(
                    children: [
                      Expanded(
                        flex: 9,
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: constraints.maxWidth *
                                  0.9 *
                                  (1 - 0.94), // 0.9 -> flex / 10 , (1 - 0.94) -> padding right 94%
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Text("94%"),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: OnOffCard(
                isOn: true,
                icon: Icon(Icons.lightbulb),
                title: "Inner Lamp",
                onLabel: "On",
                offLabel: "Off",
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: OnOffCard(
                isOn: true,
                icon: Icon(Icons.sensor_door),
                title: "Front Door",
                onLabel: "Opened",
                offLabel: "Closed",
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: OnOffCard(
                isOn: false,
                icon: Icon(Icons.ac_unit),
                title: "Warmer",
                onLabel: "On",
                offLabel: "Off",
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: OnOffCard(
                isOn: false,
                icon: Icon(Icons.roofing),
                title: "Roof",
                onLabel: "Opened",
                offLabel: "Closed",
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _bottomNavBar() {
    return Container(
      height: 65,
      child: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: currentPageIndex == 1 ? bottomnavbarSelectedItemColor : bottomnavbarUnselectedItemColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(
                  Icons.show_chart,
                  size: 15,
                  color: Colors.white,
                ),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
