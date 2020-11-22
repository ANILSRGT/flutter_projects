import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sociaworld/pages/profilepage.dart';
import 'package:sociaworld/widgets/postcard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Socia World',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Socia World",
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.grey,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[100],
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.grey,
            size: 32,
          ),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.purple[300],
              size: 32,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Column(
                    children: <Widget>[
                      notification("Kamil seni takip etmeye başladı.", "3 dakika önce"),
                      notification("Cünet mesaj gönderdi.", "5 dakika önce"),
                      notification("Seda gönderine yorum yaptı.", "1 saat önce"),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 3.0),
                  blurRadius: 5.0,
                ),
              ],
            ),
            height: 100.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                buildProfileCard("jmsk55", "https://cdn.pixabay.com/photo/2016/12/10/05/16/profile-1896698_960_720.jpg",
                    "Joe joe", "https://cdn.pixabay.com/photo/2018/09/09/02/25/kzkulesi-3663817_960_720.jpg"),
                buildProfileCard("jsca2", "https://cdn.pixabay.com/photo/2015/11/03/13/47/love-1020869_960_720.jpg",
                    "Jesica Jes", "https://cdn.pixabay.com/photo/2018/09/09/02/25/kzkulesi-3663817_960_720.jpg"),
                buildProfileCard("tmtm45", "https://cdn.pixabay.com/photo/2020/04/18/06/34/man-5057800_960_720.jpg",
                    "Tom Tom", "https://cdn.pixabay.com/photo/2018/09/09/02/25/kzkulesi-3663817_960_720.jpg"),
                buildProfileCard(
                    "lorela24",
                    "https://cdn.pixabay.com/photo/2019/03/09/20/30/international-womens-day-4044939_960_720.jpg",
                    "Lore Lorem",
                    "https://cdn.pixabay.com/photo/2018/09/09/02/25/kzkulesi-3663817_960_720.jpg"),
                buildProfileCard(
                    "smsm69",
                    "https://cdn.pixabay.com/photo/2015/01/08/18/29/entrepreneur-593358_960_720.jpg",
                    "Sam Same",
                    "https://cdn.pixabay.com/photo/2018/09/09/02/25/kzkulesi-3663817_960_720.jpg"),
                buildProfileCard("jsyr355", "https://cdn.pixabay.com/photo/2014/12/16/22/25/sunset-570881_960_720.jpg",
                    "Jesy Jes", "https://cdn.pixabay.com/photo/2018/09/09/02/25/kzkulesi-3663817_960_720.jpg"),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          PostCard(
            firstNameLastName: "Sam John",
            elapsedTime: "2 saat önce",
            description: "Kız Kulesi",
            profilePhotoLink: "https://cdn.pixabay.com/photo/2015/01/08/18/29/entrepreneur-593358_960_720.jpg",
            postPhotoLink: "https://cdn.pixabay.com/photo/2018/09/09/02/25/kzkulesi-3663817_960_720.jpg",
          ),
          PostCard(
            firstNameLastName: "Jesica Jes",
            elapsedTime: "3 saat önce",
            description: "Harika bir manzara...",
            profilePhotoLink: "https://cdn.pixabay.com/photo/2015/11/03/13/47/love-1020869_960_720.jpg",
            postPhotoLink: "https://cdn.pixabay.com/photo/2014/11/12/00/26/ferry-527728_960_720.jpg",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        backgroundColor: Colors.purple[300],
        child: Icon(
          Icons.add_a_photo,
          color: Colors.white,
        ),
      ),
    );
  }

  Padding notification(String message, String elapsedTime) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            message,
            style: TextStyle(
              fontSize: 15.0,
            ),
          ),
          Text(elapsedTime),
        ],
      ),
    );
  }

  Widget buildProfileCard(String username, String profilePhotoLink, String firstNameLastName, String coverPhotoLink) {
    return Material(
      child: InkWell(
        onTap: () async {
          bool donenVeri = await Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => ProfilePage(
                    profilePhotoLink: profilePhotoLink,
                    username: username,
                    coverPhotoLink: coverPhotoLink,
                    firstNameLastName: firstNameLastName,
                  )));
          if (donenVeri) {
            print("Kullanıcı profil sayfasından döndü");
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            children: <Widget>[
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: <Widget>[
                  Hero(
                    tag: username,
                    child: Container(
                      width: 70.0,
                      height: 70.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: 2.0,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(35.0),
                        image: DecorationImage(
                          image: NetworkImage(profilePhotoLink),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25.0),
                      border: Border.all(width: 2.0, color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 4.0,
              ),
              Text(
                username,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
