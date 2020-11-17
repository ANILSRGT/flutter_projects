import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/models/m_post.dart';
import 'package:socialapp/models/m_user.dart';
import 'package:socialapp/pages/editprofilepage.dart';
import 'package:socialapp/services/s_authorizationservice.dart';
import 'package:socialapp/services/s_firestoreservice.dart';
import 'package:socialapp/widgets/w_postcart.dart';

class ProfilePage extends StatefulWidget {
  final String profileOwnerId;

  const ProfilePage({Key key, this.profileOwnerId}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _postCount = 0;
  int _followerCount = 0;
  int _followedCount = 0;
  List<MPost> _posts = [];
  String postStyle = "liste";
  String _activeUserId;
  MUsers _profileOwner;
  bool _followed = false;

  _getFollowerCount() async {
    int followerCount = await SFireStoreService().followerCount(widget.profileOwnerId);
    if (mounted) {
      setState(() {
        _followerCount = followerCount;
      });
    }
  }

  _getFollowedCount() async {
    int followedCount = await SFireStoreService().followedCount(widget.profileOwnerId);
    if (mounted) {
      setState(() {
        _followedCount = followedCount;
      });
    }
  }

  _getPosts() async {
    var posts = await SFireStoreService().getPosts(widget.profileOwnerId);
    if (mounted) {
      setState(() {
        _posts = posts;
        _postCount = _posts.length;
      });
    }
  }

  _followCtrl() async {
    bool isFollow = await SFireStoreService().followCtrl(
      activeUserId: _activeUserId,
      profileOwnerId: widget.profileOwnerId,
    );
    setState(() {
      _followed = isFollow;
    });
  }

  @override
  void initState() {
    super.initState();
    _getFollowerCount();
    _getFollowedCount();
    _getPosts();
    _activeUserId = Provider.of<SAuthorizationService>(context, listen: false).activeUserId;
    _followCtrl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profil",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.grey[100],
        actions: <Widget>[
          widget.profileOwnerId == _activeUserId
              ? IconButton(
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ),
                  onPressed: _signOut,
                )
              : SizedBox(height: 0),
        ],
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: FutureBuilder<Object>(
          future: SFireStoreService().getUser(widget.profileOwnerId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            _profileOwner = snapshot.data;

            return ListView(
              children: [
                _profileDetails(snapshot.data),
                _showPosts(snapshot.data),
              ],
            );
          }),
    );
  }

  Widget _showPosts(MUsers profileData) {
    if (postStyle == "liste") {
      return ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          return WPostCart(
            post: _posts[index],
            published: profileData,
          );
        },
      );
    } else {
      List<GridTile> tiles = [];
      _posts.forEach((post) {
        tiles.add(_createTiles(post));
      });

      return GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        childAspectRatio: 1.0,
        physics: NeverScrollableScrollPhysics(),
        children: tiles,
      );
    }
  }

  GridTile _createTiles(MPost post) {
    return GridTile(
      child: Image.network(
        post.photoUrl,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _profileDetails(MUsers profileData) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: profileData.photoUrl.isNotEmpty
                    ? NetworkImage(profileData.photoUrl)
                    : AssetImage("assets/images/nouser.png"),
                backgroundColor: Colors.grey[300],
                radius: 50,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _socialCount("Gonderiler", _postCount),
                    _socialCount("Takipçi", _followerCount),
                    _socialCount("Takip", _followedCount),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            profileData.username,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            profileData.about,
          ),
          SizedBox(
            height: 25,
          ),
          widget.profileOwnerId == _activeUserId ? _editProfileButton() : _followButton(),
        ],
      ),
    );
  }

  Widget _followButton() {
    return _followed ? _unfollow() : _follow();
  }

  Widget _follow() {
    return Container(
      width: double.infinity,
      child: FlatButton(
        color: Theme.of(context).primaryColor,
        onPressed: () {
          SFireStoreService().follow(
            activeUserId: _activeUserId,
            profileOwnerId: widget.profileOwnerId,
          );
          setState(() {
            _followed = true;
            _followerCount += 1;
          });
        },
        child: Text(
          "Takip Et",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _unfollow() {
    return Container(
      width: double.infinity,
      child: FlatButton(
        onPressed: () {
          SFireStoreService().unfollow(
            activeUserId: _activeUserId,
            profileOwnerId: widget.profileOwnerId,
          );
          setState(() {
            _followed = false;
            _followerCount -= 1;
          });
        },
        child: Text(
          "Takipten Çık",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _editProfileButton() {
    return Container(
      width: double.infinity,
      child: OutlineButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => EditProfilePage(
                        profile: _profileOwner,
                      )))
              .whenComplete(() {
            setState(() {});
          });
        },
        child: Text("Profili Düzenle"),
      ),
    );
  }

  Widget _socialCount(String title, int count) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  void _signOut() {
    Provider.of<SAuthorizationService>(context, listen: false).signOut();
  }
}
