import 'package:app_chat/screens/chat_screen/chat_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: avatar,
                height: 65,
                width: 65,
                fit: BoxFit.cover,
              ),
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
