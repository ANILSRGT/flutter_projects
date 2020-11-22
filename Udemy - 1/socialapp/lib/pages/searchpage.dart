import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/models/m_user.dart';
import 'package:socialapp/pages/profilepage.dart';
import 'package:socialapp/services/s_authorizationservice.dart';
import 'package:socialapp/services/s_firestoreservice.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchCtrl = TextEditingController();
  Future<List<MUsers>> _searchResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createAppBar(),
      body: _searchResult != null ? getResults() : noSearch(),
    );
  }

  AppBar _createAppBar() {
    return AppBar(
      titleSpacing: 0,
      backgroundColor: Colors.grey[100],
      title: TextFormField(
        onFieldSubmitted: (inputValue) {
          setState(() {
            _searchResult = SFireStoreService().searchUser(inputValue);
          });
        },
        controller: _searchCtrl,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            size: 30,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              _searchCtrl.clear();
              setState(() {
                _searchResult = null;
              });
            },
          ),
          border: InputBorder.none,
          fillColor: Colors.white,
          filled: true,
          hintText: "Kullanıcı Ara...",
          contentPadding: EdgeInsets.only(top: 16),
        ),
      ),
    );
  }

  noSearch() {
    return Center(child: Text("Kullanıcı Ara"));
  }

  getResults() {
    return FutureBuilder(
      future: _searchResult,
      builder: (BuildContext context, AsyncSnapshot<List<MUsers>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data.length == 0) {
          return Center(child: Text("Bu arama için sonuç bulunamadı!"));
        }

        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            MUsers user = snapshot.data[index];
            return user.id == Provider.of<SAuthorizationService>(context).activeUserId ? null : userRow(user);
          },
        );
      },
    );
  }

  userRow(MUsers user) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfilePage(
                profileOwnerId: user.id,
              ),
            ));
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage:
              user.photoUrl.isNotEmpty ? NetworkImage(user.photoUrl) : AssetImage("assets/images/nouser.png"),
        ),
        title: Text(
          user.username,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
