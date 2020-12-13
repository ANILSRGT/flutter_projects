import 'package:flutter/material.dart';
import 'package:sociaworld/widgets/postcard.dart';

class ProfilePage extends StatelessWidget {
  final String firstNameLastName;
  final String username;
  final String coverPhotoLink;
  final String profilePhotoLink;

  const ProfilePage({Key key, this.firstNameLastName, this.username, this.coverPhotoLink, this.profilePhotoLink})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 230.0,
                //color: Colors.yellow,
              ),
              Container(
                height: 180.0,
                decoration: BoxDecoration(
                  color: Colors.green,
                  image: DecorationImage(
                    image: NetworkImage("https://cdn.pixabay.com/photo/2014/07/10/17/18/battleship-389274_960_720.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                left: 20.0,
                bottom: 0.0,
                child: Hero(
                  tag: username,
                  child: Container(
                    width: 120.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(profilePhotoLink),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(60.0),
                      border: Border.all(
                        width: 2.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 145.0,
                top: 190.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      firstNameLastName,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      username,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 15.0,
                top: 130.0,
                child: Container(
                  width: 100.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.grey[200],
                    border: Border.all(
                      width: 2.0,
                      color: Colors.white,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.add_circle,
                        size: 18,
                      ),
                      SizedBox(
                        width: 2.0,
                      ),
                      Text(
                        "Takip Et",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 75.0,
            color: Colors.grey.withOpacity(0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                profileCounter("Takipçi", "20K"),
                profileCounter("Takip", "500"),
                profileCounter("Paylaşım", "75"),
              ],
            ),
          ),
          PostCard(
            firstNameLastName: firstNameLastName,
            elapsedTime: "2 saat önce",
            description: "Kız Kulesi",
            profilePhotoLink: profilePhotoLink,
            postPhotoLink: "https://cdn.pixabay.com/photo/2018/09/09/02/25/kzkulesi-3663817_960_720.jpg",
          ),
        ],
      ),
    );
  }

  Column profileCounter(String title, String number) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(number,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
        SizedBox(
          height: 1,
        ),
        Text(title,
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            )),
      ],
    );
  }
}
