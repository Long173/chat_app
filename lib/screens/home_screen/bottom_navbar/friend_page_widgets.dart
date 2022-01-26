import 'package:app_chat/screens/chat_screen/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FriendCard extends StatelessWidget {
  const FriendCard({
    Key? key,
    required this.avatar,
    required this.name,
    required this.email,
  }) : super(key: key);

  final String avatar;
  final String name;
  final String email;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(friendName: email),
        ),
      ),
      child: Container(
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(avatar),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

Widget searchData(QuerySnapshot snapshotData) {
  return ListView.builder(
      itemCount: snapshotData.docs.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ChatScreen(friendName: snapshotData.docs[index]['email']),
            ),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(snapshotData.docs[index]['image']),
            ),
            title: Text(
              snapshotData.docs[index]['name'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              snapshotData.docs[index]['email'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      });
}
