import 'package:chat_app/screens/chat_sreen.dart';
import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  final userId;
  final user_image;
  final user_name;
  final bool isme;
  UserItem(this.isme, this.userId, this.user_image, this.user_name);

  void chatUser(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(userId.toString()),
        ));
  }

  @override
  Widget build(BuildContext context) {
    // print(userId.toString());
    // print(isme);
    return isme
        ? Container()
        : Container(
            margin: EdgeInsets.all(10),
            width: double.infinity,
            child: Card(
              color: Colors.grey[100],
              elevation: 8,
              child: ListTile(
                onTap: () {
                  chatUser(context);
                },
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(user_image),
                ),
                title: Text(user_name),
                subtitle: Text('Busy..'),
              ),
            ),
          );
  }
}
