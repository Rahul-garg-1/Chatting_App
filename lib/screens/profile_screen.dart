import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final userName;
  final userImage;
  ProfileScreen(this.userName, this.userImage);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Container(
        // margin: EdgeInsets.all(30),
        padding: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(widget.userImage),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              width: double.infinity,
              child: Card(
                
                elevation: 2,
                color: Colors.grey[100],
                child: ListTile(
                  title: Text('UserName'),
                  subtitle: Text(widget.userName),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
