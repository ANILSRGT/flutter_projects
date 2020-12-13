import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/models/m_comment.dart';
import 'package:socialapp/models/m_post.dart';
import 'package:socialapp/models/m_user.dart';
import 'package:socialapp/services/s_authorizationservice.dart';
import 'package:socialapp/services/s_firestoreservice.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentsPage extends StatefulWidget {
  final MPost post;

  const CommentsPage({Key key, this.post}) : super(key: key);

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  TextEditingController _commentCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    timeago.setLocaleMessages("tr", timeago.TrMessages());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text(
          "Yorumlar",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Column(
        children: <Widget>[
          _showComments(),
          _addComment(),
        ],
      ),
    );
  }

  _showComments() {
    return Expanded(
      child: StreamBuilder(
        stream: SFireStoreService().getComments(widget.post.id),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              MComment comment = MComment.produceFromDocument(snapshot.data.docs[index]);
              return _commentRow(comment);
            },
          );
        },
      ),
    );
  }

  _commentRow(MComment comment) {
    return FutureBuilder<MUsers>(
        future: SFireStoreService().getUser(comment.publishedId),
        builder: (BuildContext context, AsyncSnapshot<MUsers> snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
              height: 0,
            );
          }

          MUsers published = snapshot.data;

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: published.photoUrl.isNotEmpty
                  ? NetworkImage(published.photoUrl)
                  : AssetImage("assets/images/nouser.png"),
            ),
            title: RichText(
              text: TextSpan(
                text: published.username + " ",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: comment.content,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            subtitle: Text(timeago.format(
              comment.createdTime.toDate(),
              locale: "tr",
            )),
          );
        });
  }

  _addComment() {
    return ListTile(
      title: TextFormField(
        controller: _commentCtrl,
        decoration: InputDecoration(
          hintText: "Yorumu buraya yazınız...",
        ),
      ),
      trailing: IconButton(
        icon: Icon(Icons.send),
        onPressed: _sendComment,
      ),
    );
  }

  void _sendComment() {
    String activeUserId = Provider.of<SAuthorizationService>(context, listen: false).activeUserId;

    SFireStoreService().addComment(
      activeUserId: activeUserId,
      post: widget.post,
      content: _commentCtrl.text,
    );
    _commentCtrl.clear();
  }
}
