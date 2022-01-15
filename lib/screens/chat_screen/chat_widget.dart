import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuildChatScreen extends StatefulWidget {
  BuildChatScreen({
    Key? key,
    required this.friendName,
    required this.user,
    required this.scrollController,
  }) : super(key: key);

  final String? friendName;
  final User? user;
  final ScrollController scrollController;

  @override
  State<BuildChatScreen> createState() => _BuildChatScreenState();
}

class _BuildChatScreenState extends State<BuildChatScreen> {
  bool getMore = false;
  int currentMax = 20;
  @override
  Widget build(BuildContext context) {
    var _firestore = FirebaseFirestore.instance;

    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          final messages = snapshot.data!.docs;

          for (final data in messages) {
            if (data.id == widget.user!.email) {
              var list = [];
              int lenList = data['text'].length;
              for (var i = lenList - 1;
                  i >= ((lenList > currentMax) ? (lenList - currentMax) : 0);
                  i--) {
                if (data['text'] != []) {
                  if (data['text'][i]['to'] == widget.friendName ||
                      data['text'][i]['from'] == widget.friendName) {
                    list.add(data['text'][i]);
                  }
                } else {
                  break;
                }
              }

              widget.scrollController.addListener(() {
                if (widget.scrollController.position.pixels ==
                    widget.scrollController.position.maxScrollExtent) {
                  setState(() {
                    currentMax = currentMax + currentMax;
                  });
                }
              });

              return ListView.builder(
                reverse: true,
                itemCount: list.length,
                controller: widget.scrollController,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onLongPress: widget.user!.email == list[index]['from']
                        ? () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertMessageDelete(
                                      type: list[index]['type'],
                                      data: list[index],
                                      user: widget.user,
                                      friendName: widget.friendName);
                                });
                          }
                        : null,
                    child: MessageScreen(
                      timeSend: list[index]['timeSend'],
                      from: list[index]['from'],
                      text: list[index]['body'],
                      me: widget.user!.email == list[index]['from'],
                      type: list[index]['type'],
                    ),
                  );
                },
              );
            }
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

class MessageScreen extends StatelessWidget {
  final String from;
  final String text;
  final bool me;
  final String type;
  final Timestamp timeSend;

  MessageScreen(
      {required this.text,
      required this.from,
      required this.me,
      required this.type,
      required this.timeSend});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Column(
          crossAxisAlignment:
              me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              from,
            ),
            Material(
              color: me ? Colors.orangeAccent : Colors.white,
              borderRadius: BorderRadius.circular(10),
              elevation: 6,
              child: Container(
                constraints: BoxConstraints(maxWidth: 250),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: type == 'text'
                    ? Text(
                        text,
                        style: TextStyle(
                          color: me ? Colors.white : Colors.black,
                        ),
                      )
                    : Image.network(
                        text,
                        height: 250,
                      ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class SendButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;

  SendButton({required this.text, required this.callback});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: callback,
      child: Text(
        text,
      ),
    );
  }
}

class AlertMessageDelete extends StatelessWidget {
  const AlertMessageDelete({
    Key? key,
    required this.data,
    required this.user,
    required this.friendName,
    required this.type,
  });

  final Map data;
  final User? user;
  final String? friendName;
  final String type;

  @override
  Widget build(BuildContext context) {
    var _firestore = FirebaseFirestore.instance;
    return AlertDialog(
      title: Text('Confirmation!!!'),
      content: Text('Are you sure delete this message?'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('No'),
        ),
        TextButton(
          onPressed: () {
            var list = data;
            _firestore.collection("messages").doc(user!.email).update({
              "text": FieldValue.arrayRemove([list]),
            });
            _firestore.collection("messages").doc(friendName).update({
              "text": FieldValue.arrayRemove([list]),
            });
            if (type == 'picture') {
              FirebaseStorage.instance.refFromURL(data['body']).delete();
            }
            Navigator.pop(context);
          },
          child: Text('Yes'),
        ),
      ],
    );
  }
}
