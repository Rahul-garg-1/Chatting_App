import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  final userId;
  final user_image;
  final user_name;
  UserItem(this.userId,this.user_image,this.user_name);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: double.infinity,
      child: Card(
        color: Colors.grey[100],
        elevation: 8,
        child: ListTile(
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