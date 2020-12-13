import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/models/m_post.dart';
import 'package:socialapp/models/m_user.dart';
import 'package:socialapp/pages/commentspage.dart';
import 'package:socialapp/pages/profilepage.dart';
import 'package:socialapp/services/s_authorizationservice.dart';
import 'package:socialapp/services/s_firestoreservice.dart';

class WPostCart extends StatefulWidget {
  final MPost post;
  final MUsers published;

  const WPostCart({Key key, this.post, this.published}) : super(key: key);

  @override
  _WPostCartState createState() => _WPostCartState();
}

class _WPostCartState extends State<WPostCart> {
  int _likeCount = 0;
  bool _liked = false;
  String _activeUserId;

  @override
  void initState() {
    super.initState();
    _activeUserId = Provider.of<SAuthorizationService>(context, listen: false).activeUserId;
    _likeCount = widget.post.likeCount;
    isLike();
  }

  isLike() async {
    bool isLike = await SFireStoreService().isLike(widget.post, _activeUserId);
    if (isLike) {
      if (mounted) {
        setState(() {
          _liked = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        children: <Widget>[
          _postTitle(),
          _postPhoto(),
          _postFooter(),
        ],
      ),
    );
  }

  postOptions() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text("Seçiminiz nedir?"),
          children: <Widget>[
            SimpleDialogOption(
              child: Text("Gönderiyi Sil"),
              onPressed: () {
                SFireStoreService().deletePost(
                  activeUserId: _activeUserId,
                  post: widget.post,
                );
                Navigator.pop(context);
              },
            ),
            SimpleDialogOption(
              child: Text(
                "Vazgeç",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _postTitle() {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ProfilePage(profileOwnerId: widget.published.id)));
          },
          child: CircleAvatar(
            backgroundColor: Colors.blue,
            backgroundImage: widget.published.photoUrl.isNotEmpty
                ? NetworkImage(widget.published.photoUrl)
                : AssetImage("assets/images/nouser.png"),
          ),
        ),
      ),
      title: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ProfilePage(profileOwnerId: widget.published.id)));
        },
        child: Text(
          widget.published.username,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      trailing: _activeUserId == widget.post.publishedId
          ? IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () => postOptions(),
            )
          : null,
      contentPadding: EdgeInsets.all(0),
    );
  }

  Widget _postPhoto() {
    return GestureDetector(
      onDoubleTap: _changeLike,
      child: Image.network(
        widget.post.photoUrl,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _postFooter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: !_liked
                  ? Icon(
                      Icons.favorite_border,
                      size: 35,
                    )
                  : Icon(
                      Icons.favorite,
                      size: 35,
                      color: Colors.red,
                    ),
              onPressed: _changeLike,
            ),
            IconButton(
              icon: Icon(
                Icons.comment,
                size: 35,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CommentsPage(
                          post: widget.post,
                        )));
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            "$_likeCount beğeni",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 2,
        ),
        widget.post.description.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(left: 8),
                child: RichText(
                  text: TextSpan(
                    text: widget.published.username + " ",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: widget.post.description,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : SizedBox(height: 0),
      ],
    );
  }

  void _changeLike() {
    if (_liked) {
      setState(() {
        _liked = false;
        _likeCount -= 1;
      });
      SFireStoreService().removeLikePost(widget.post, _activeUserId);
    } else {
      setState(() {
        _liked = true;
        _likeCount += 1;
      });
      SFireStoreService().likePost(widget.post, _activeUserId);
    }
  }
}
