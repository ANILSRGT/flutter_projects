import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/pages/streampage.dart';
import 'package:socialapp/pages/notificationpage.dart';
import 'package:socialapp/pages/profilepage.dart';
import 'package:socialapp/pages/searchpage.dart';
import 'package:socialapp/pages/uploadpage.dart';
import 'package:socialapp/services/s_authorizationservice.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _activePageIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String activeUserId = Provider.of<SAuthorizationService>(context, listen: false).activeUserId;
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (onPageIndex) {
          setState(() {
            _activePageIndex = onPageIndex;
          });
        },
        controller: _pageController,
        children: <Widget>[
          StreamPage(),
          SearchPage(),
          UploadPage(),
          NotificationPage(),
          ProfilePage(
            profileOwnerId: activeUserId,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _activePageIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey[600],
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Akış",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: "Keşfet",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_upload),
            label: "Yükle",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Duyurular",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
        onTap: (selectedPageIndex) {
          setState(() {
            _pageController.jumpToPage(selectedPageIndex);
          });
        },
      ),
    );
  }
}
