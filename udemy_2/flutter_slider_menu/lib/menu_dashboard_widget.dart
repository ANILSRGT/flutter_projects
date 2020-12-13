import 'package:flutter/material.dart';

final TextStyle menuTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 20,
);
final Color backgroundColor = Color(0xFF343442);

class MenuDashboard extends StatefulWidget {
  @override
  _MenuDashboardState createState() => _MenuDashboardState();
}

class _MenuDashboardState extends State<MenuDashboard> with SingleTickerProviderStateMixin {
  double ekranYuksekligi, ekranGenisligi;
  bool menuAcikMi = false;
  AnimationController _animationCtrl;
  Animation<double> _scaleAnim;
  Animation<double> _scaleMenuAnim;
  Animation<Offset> _menuOffsetAnim;
  final Duration _duration = Duration(microseconds: 500);

  @override
  void initState() {
    super.initState();
    _animationCtrl = AnimationController(vsync: this, duration: _duration, reverseDuration: _duration);
    _scaleAnim = Tween(begin: 1.0, end: 0.6).animate(CurvedAnimation(parent: _animationCtrl, curve: Curves.easeInOut));
    _scaleMenuAnim =
        Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _animationCtrl, curve: Curves.easeInOut));
    _menuOffsetAnim = Tween(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _animationCtrl, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _animationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ekranYuksekligi = MediaQuery.of(context).size.height;
    ekranGenisligi = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            _menuOlustur(context),
            _dashBoardOlustur(context),
          ],
        ),
      ),
    );
  }

  Widget _menuOlustur(BuildContext context) {
    return SlideTransition(
      position: _menuOffsetAnim,
      child: ScaleTransition(
        scale: _scaleMenuAnim,
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dashboard",
                  style: menuTextStyle,
                ),
                SizedBox(height: 10),
                Text(
                  "Mesajlar",
                  style: menuTextStyle,
                ),
                SizedBox(height: 10),
                Text(
                  "Utility Bills",
                  style: menuTextStyle,
                ),
                SizedBox(height: 10),
                Text(
                  "Fund Transfer",
                  style: menuTextStyle,
                ),
                SizedBox(height: 10),
                Text(
                  "Branches",
                  style: menuTextStyle,
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dashBoardOlustur(BuildContext context) {
    return AnimatedPositioned(
      duration: _duration,
      top: 0,
      bottom: 0,
      left: menuAcikMi ? 0.6 * ekranGenisligi : 0,
      right: menuAcikMi ? -0.4 * ekranGenisligi : 0,
      child: ScaleTransition(
        scale: _scaleAnim,
        child: Material(
          borderRadius: menuAcikMi ? BorderRadius.circular(20) : BorderRadius.zero,
          elevation: 8,
          color: backgroundColor,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.menu),
                        color: Colors.white,
                        onPressed: () {
                          if (menuAcikMi) {
                            _animationCtrl.reverse().orCancel;
                          } else {
                            _animationCtrl.forward().orCancel;
                          }
                          setState(() {
                            menuAcikMi = !menuAcikMi;
                          });
                        },
                      ),
                      Text(
                        "My Cards",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      IconButton(
                        icon: Icon(Icons.add_circle_outline),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 200,
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          color: Colors.pink,
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                        ),
                        Container(
                          color: Colors.purple,
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                        ),
                        Container(
                          color: Colors.teal,
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: 20,
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.verified_user),
                        title: Text("Öğrenci $index"),
                        trailing: Icon(Icons.add),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
