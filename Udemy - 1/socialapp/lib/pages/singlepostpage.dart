import 'package:flutter/material.dart';
import 'package:socialapp/models/m_post.dart';
import 'package:socialapp/models/m_user.dart';
import 'package:socialapp/services/s_firestoreservice.dart';
import 'package:socialapp/widgets/w_postcart.dart';

class SinglePostPage extends StatefulWidget {
  final String postId;
  final String postOwnerId;

  const SinglePostPage({Key key, this.postId, this.postOwnerId}) : super(key: key);

  @override
  _SinglePostPageState createState() => _SinglePostPageState();
}

class _SinglePostPageState extends State<SinglePostPage> {
  MPost _post;
  MUsers _postOwner;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getPost();
  }

  getPost() async {
    MPost post = await SFireStoreService().getSinglePost(widget.postId, widget.postOwnerId);
    if (post != null) {
      MUsers postOwner = await SFireStoreService().getUser(post.publishedId);

      setState(() {
        _post = post;
        _postOwner = postOwner;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text(
          "Gönderi",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: !_loading
          ? WPostCart(
              post: _post,
              published: _postOwner,
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
