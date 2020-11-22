import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/models/m_notification.dart';
import 'package:socialapp/models/m_user.dart';
import 'package:socialapp/pages/profilepage.dart';
import 'package:socialapp/pages/singlepostpage.dart';
import 'package:socialapp/services/s_authorizationservice.dart';
import 'package:socialapp/services/s_firestoreservice.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<MNotification> _notifications;
  String _activeUserId;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    timeago.setLocaleMessages("tr", timeago.TrMessages());
    _activeUserId = Provider.of<SAuthorizationService>(context, listen: false).activeUserId;
    getNotifications();
  }

  Future<void> getNotifications() async {
    List<MNotification> notifications = await SFireStoreService().getNotifications(_activeUserId);
    if (mounted) {
      setState(() {
        _notifications = notifications;
        _loading = false;
      });
    }
  }

  showNotifications() {
    if (_loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_notifications.isEmpty) {
      return Center(child: Text("Hiç duyurunuz yok!"));
    }

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: RefreshIndicator(
        onRefresh: getNotifications,
        child: ListView.builder(
          itemCount: _notifications.length,
          itemBuilder: (BuildContext context, int index) {
            MNotification notification = _notifications[index];
            return notificationRow(notification);
          },
        ),
      ),
    );
  }

  notificationRow(MNotification notification) {
    String message = createMessage(notification.activityType);
    return FutureBuilder(
      future: SFireStoreService().getUser(notification.activityUserId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SizedBox(height: 0);
        }
        MUsers activityUserId = snapshot.data;
        return ListTile(
          leading: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProfilePage(
                  profileOwnerId: notification.activityUserId,
                ),
              ));
            },
            child: CircleAvatar(
              backgroundImage: activityUserId.photoUrl.isNotEmpty
                  ? NetworkImage(activityUserId.photoUrl)
                  : AssetImage("assets/images/nouser.png"),
            ),
          ),
          title: RichText(
            text: TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      profileOwnerId: notification.activityUserId,
                    ),
                  ));
                },
              text: "${activityUserId.username}",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: notification.comment == null ? " $message" : " $message \n${notification.comment}",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          subtitle: Text(timeago.format(notification.createdTime.toDate(), locale: "tr")),
          trailing: postImage(notification.activityType, notification.postPhoto, notification.postId),
        );
      },
    );
  }

  postImage(String activityType, String postPhoto, String postId) {
    if (activityType == "follow") {
      return null;
    } else if (activityType == "like" || activityType == "comment") {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SinglePostPage(
                    postId: postId,
                    postOwnerId: _activeUserId,
                  )));
        },
        child: Image.network(
          postPhoto,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      );
    }
  }

  createMessage(String activityType) {
    if (activityType == "like")
      return "gönderini beğendi.";
    else if (activityType == "follow")
      return "seni takip etti.";
    else if (activityType == "comment")
      return "gönderine yorum yaptı.";
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text(
          "Duyurular",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: showNotifications(),
    );
  }
}
