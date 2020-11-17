import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/models/m_post.dart';
import 'package:socialapp/models/m_user.dart';
import 'package:socialapp/services/s_authorizationservice.dart';
import 'package:socialapp/services/s_firestoreservice.dart';
import 'package:socialapp/widgets/w_indelible_futurebuilder.dart';
import 'package:socialapp/widgets/w_postcart.dart';

class StreamPage extends StatefulWidget {
  @override
  _StreamPageState createState() => _StreamPageState();
}

class _StreamPageState extends State<StreamPage> {
  List<MPost> _posts = [];

  _getStreamingPosts() async {
    String activeUserId = Provider.of<SAuthorizationService>(context, listen: false).activeUserId;
    List<MPost> posts = await SFireStoreService().getStreamingPosts(activeUserId);
    if (mounted) {
      setState(() {
        _posts = posts;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getStreamingPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Social App"),
        centerTitle: true,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          MPost post = _posts[index];
          return WIndelibleFutureBuilder(
            future: SFireStoreService().getUser(post.publishedId),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return SizedBox();
              }

              MUsers postOwner = snapshot.data;
              return WPostCart(
                post: post,
                published: postOwner,
              );
            },
          );
        },
      ),
    );
  }
}
