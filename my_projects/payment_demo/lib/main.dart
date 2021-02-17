import 'package:flutter/material.dart';
import 'package:payment_demo/config.dart';
import 'package:payment_demo/widgets/appbar_widget.dart';
//import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Payment App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: currentTheme.currentTheme(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.all(10),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.wb_sunny),
          backgroundColor: currentTheme.currentTheme() == ThemeMode.light ? Colors.deepOrangeAccent : Colors.black54,
          onPressed: () => currentTheme.switchTheme(),
        ),
        body: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  AppBarWidget(
                    height: 200,
                    decoration: BoxDecoration(
                      color: currentTheme.currentTheme() == ThemeMode.light ? Colors.deepOrange : Colors.black87,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 30,
                                  child: Text(
                                    "AS",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    "Your Name",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(child: Container()),
                            Container(
                              width: 45,
                              height: 45,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: CircleBorder(),
                              ),
                              child: IconButton(
                                icon: Icon(Icons.shopping_cart),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: constraints.maxHeight - 200,
                    child: ListView.builder(
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Text("sads"),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
