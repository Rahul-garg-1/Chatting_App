import 'package:chat_app/screens/profile_screen.dart';
import 'package:chat_app/widgets/users/user_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget{
  Future<String> inputData() async {
      final FirebaseUser user = await FirebaseAuth.instance.currentUser();
      final String uid = user.uid.toString();
      return uid;
    }

  @override
  Widget build(BuildContext context) {
    var id;
    inputData().then((value) {id=value;});
    // print(id);
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.settings),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Settings'),
                    ],
                  ),
                ),
                value: 'settings',
              ),
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier) async {
              if (itemIdentifier == 'settings') {
                final user = await FirebaseAuth.instance.currentUser();
                final userData = await Firestore.instance
                    .collection('users')
                    .document(user.uid)
                    .get();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      userData['username'],
                      userData['image_url'],
                    ),
                  ),
                );
              }
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: Container(
        child: StreamBuilder(
          stream:
              Firestore.instance.collection('users').getDocuments().asStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              // print(_userId);
              // final listUsers=snapshot.data.documents.map((index){snapshot.data.documents[index]!=userId;}).toList();
              return ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemBuilder: (context, index) => UserItem(
                  snapshot.data.documents[index]['userId'] == id,
                  snapshot.data.documents[index]['userId'],
                  snapshot.data.documents[index]['image_url'],
                  snapshot.data.documents[index]['username'],
                ),
                itemCount: snapshot.data.documents.length,
              );
            }
          },
        ),
      ),
    );
  }
}
