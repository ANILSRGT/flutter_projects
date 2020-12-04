import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  int _activeCategory = 0;

  _changeCategory(int categoryIndex) {
    setState(() {
      _activeCategory = categoryIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Choose your",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Favorite flavor",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Wide range of fresh and healthy juices",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RaisedButton(
                            elevation: 0,
                            onPressed: () => _changeCategory(0),
                            color: _activeCategory == 0 ? Theme.of(context).primaryColor : Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "Juices",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: _activeCategory == 0 ? Colors.white : Colors.grey.shade600,
                              ),
                            ),
                          ),
                          RaisedButton(
                            elevation: 0,
                            onPressed: () => _changeCategory(1),
                            color: _activeCategory == 1 ? Theme.of(context).primaryColor : Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "Ice Shakes",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: _activeCategory == 1 ? Colors.white : Colors.grey.shade600,
                              ),
                            ),
                          ),
                          RaisedButton(
                            elevation: 0,
                            onPressed: () => _changeCategory(2),
                            color: _activeCategory == 2 ? Theme.of(context).primaryColor : Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "Smoothie",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: _activeCategory == 2 ? Colors.white : Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          height: 330,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/images/ocean-spray-cran-blueberry-juice-189-litres.png",
                                    fit: BoxFit.fitHeight,
                                    width: (MediaQuery.of(context).size.width - 40) * 0.4,
                                    height: 200,
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    "Blueberry",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                  Text(
                                    "Fresh juice 250 ml",
                                    style: TextStyle(
                                      color: Colors.blueGrey.shade300,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    "₺5.00",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/images/Cran-Strawberry-Cranberry-Strawberry-Juice-Drink.png",
                                    fit: BoxFit.fitHeight,
                                    width: (MediaQuery.of(context).size.width - 40) * 0.4,
                                    height: 200,
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    "Strawberry",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                  Text(
                                    "Fresh juice 250 ml",
                                    style: TextStyle(
                                      color: Colors.blueGrey.shade300,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    "₺6.00",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Bottom Nav Height
                    Container(
                      height: 90,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        _buildBottomNavBar(context),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.menu),
        color: Color(0xff072706),
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.shopping_cart_outlined),
          color: Color(0xff072706),
          onPressed: () {},
        ),
      ],
    );
  }

  _buildBottomNavBar(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          child: ClipPath(
            clipper: NavBarClipper(),
            child: Container(
              height: 90,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  Icons.home_outlined,
                  color: Colors.white.withOpacity(0.6),
                ),
                iconSize: 26,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.message_outlined,
                  color: Colors.white.withOpacity(0.6),
                ),
                iconSize: 26,
                onPressed: () {},
              ),
              SizedBox(width: 1),
              IconButton(
                icon: Icon(
                  Icons.favorite_outline,
                  color: Colors.white.withOpacity(0.6),
                ),
                iconSize: 26,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.person_outline,
                  color: Colors.white.withOpacity(0.6),
                ),
                iconSize: 26,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class NavBarClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, size.height * 0.25, size.width * 0.03, size.height * 0.25);
    path.cubicTo(size.width * 0.07, size.height * 0.25, size.width * 0.19, size.height * 0.25, size.width * 0.25,
        size.height * 0.25);
    path.cubicTo(size.width * 0.31, size.height * 0.25, size.width * 0.38, size.height * 0.25, size.width * 0.41,
        size.height * 0.40);
    path.cubicTo(size.width * 0.44, size.height * 0.50, size.width * 0.47, size.height * 0.50, size.width * 0.50,
        size.height * 0.50);
    path.cubicTo(size.width * 0.53, size.height * 0.50, size.width * 0.56, size.height * 0.50, size.width * 0.59,
        size.height * 0.40);
    path.cubicTo(size.width * 0.63, size.height * 0.25, size.width * 0.69, size.height * 0.25, size.width * 0.75,
        size.height * 0.25);
    path.cubicTo(size.width * 0.81, size.height * 0.25, size.width * 0.92, size.height * 0.25, size.width * 0.97,
        size.height * 0.25);
    path.quadraticBezierTo(size.width, size.height * 0.25, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}
