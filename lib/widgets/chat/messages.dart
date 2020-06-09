import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:chat_app/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  final secondUserId;
  Messages(this.secondUserId);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
            stream: Firestore.instance
                .collection('chat')
                .orderBy(
                  'createdAt',
                  descending: true,
                )
                // .where('userId', isEqualTo: futureSnapshot.data.uid)
                // .where('peerId', isEqualTo: secondUserId)
                .snapshots(),
            builder: (ctx, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final chatDocs = chatSnapshot.data.documents;

              return  ListView.builder(
                      reverse: true,
                      itemCount: chatDocs.length,
                      itemBuilder: (ctx, index) => MessageBubble(
                        chatDocs[index]['text'],
                        chatDocs[index]['username'],
                        chatDocs[index]['userImage'],
                        chatDocs[index]['userId'] == futureSnapshot.data.uid,
                        chatDocs[index]['peerId'] == secondUserId,
                        chatDocs[index]['userId'] == secondUserId,
                        chatDocs[index]['peerId'] == futureSnapshot.data.uid,
                        key: ValueKey(chatDocs[index].documentID),
                      ),
                    );
            });
      },
    );
  }
}
