import 'package:app_chat/store/models/app_state.dart';
import 'package:app_chat/store/view_model/app_state_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

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
    String friend = widget.friendName!.replaceAll('.', '_');
    return Expanded(
      child: StreamBuilder(
          stream: _firestore
              .collection('messages')
              .doc(widget.user!.email)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            }
            var list = [];
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            for (var i in data.keys) {
              if (i == friend) {
                for (var texts in data[i]) {
                  list.add(texts);
                }
              }
            }
            list = List.from(list.reversed);
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
                                    user: widget.user!,
                                    friendName: widget.friendName!);
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
          }),
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
    return StoreConnector<AppState, AppStateViewModel>(
        converter: (Store<AppState> store) => AppStateViewModel.create(store),
        builder: (BuildContext context, vm) {
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
                    color: me ? Colors.purple[800] : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(15),
                    elevation: 6,
                    child: Container(
                        constraints: BoxConstraints(maxWidth: 250),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: type == 'text'
                            ? Text(
                                text,
                                style: TextStyle(
                                  color: me ? Colors.white : Colors.black,
                                ),
                              )
                            : CachedNetworkImage(
                                imageUrl: text,
                                height: 250,
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  color: Colors.black12,
                                  child: Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                ),
                              )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          );
        });
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
  final User user;
  final String friendName;
  final String type;

  @override
  Widget build(BuildContext context) {
    var _firestore = FirebaseFirestore.instance;
    var friend = friendName.replaceAll('.', '_');
    var me = user.email!.replaceAll('.', '_');
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
            _firestore.collection("messages").doc(user.email).update({
              friend: FieldValue.arrayRemove([data]),
            });
            _firestore.collection("messages").doc(friendName).update({
              me: FieldValue.arrayRemove([data]),
            });
            data['seen'] = !data['seen'];
            _firestore.collection("messages").doc(friendName).update({
              me: FieldValue.arrayRemove([data]),
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
