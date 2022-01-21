import 'package:app_chat/screens/chat_screen/chat_screen.dart';
import 'package:app_chat/store/actions/auth_action.dart';
import 'package:app_chat/store/models/app_state.dart';
import 'package:app_chat/store/models/message.dart';
import 'package:app_chat/store/selectors/app_state_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';

class ConfirmNotiWidget extends StatelessWidget {
  const ConfirmNotiWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirmation!!!'),
      content: Text('Are you sure to log out?'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('No')),
        StoreConnector<AppState, AppStateViewModel>(
          converter: (Store<AppState> store) => AppStateViewModel.create(store),
          builder: (context, vm) {
            return TextButton(
              onPressed: () {
                vm.dispatch(action: LogOutAction());
              },
              child: Text('Yes'),
            );
          },
        ),
      ],
    );
  }
}

class MessageCard extends StatelessWidget {
  const MessageCard(
      {Key? key,
      required this.avt,
      required this.type,
      required this.sender,
      required this.lastMessage,
      required this.timeSend,
      required this.seen})
      : super(key: key);

  final String sender;
  final String avt;
  final String lastMessage;
  final String timeSend;
  final String type;
  final bool seen;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(avt),
            radius: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sender,
                  style: TextStyle(
                      fontSize: 20,
                      color: seen ? Colors.grey.shade700 : Colors.black,
                      fontWeight: seen ? null : FontWeight.bold),
                ),
                Row(
                  children: [
                    type == 'picture'
                        ? Text(
                            '[Hình ảnh]',
                            style: TextStyle(
                                fontWeight: seen ? null : FontWeight.bold),
                          )
                        : Text(
                            lastMessage.length > 25
                                ? lastMessage.substring(0, 20) + '...'
                                : lastMessage,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16,
                                color:
                                    seen ? Colors.grey.shade600 : Colors.black,
                                fontWeight: seen ? null : FontWeight.bold),
                          ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '•$timeSend',
                      style: TextStyle(
                          fontSize: 16,
                          color: seen ? Colors.grey.shade600 : Colors.black,
                          fontWeight: seen ? null : FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BuildHomePage extends StatefulWidget {
  const BuildHomePage({
    Key? key,
    required this.friendName,
    required this.currentUser,
  }) : super(key: key);

  final String friendName;
  final String? currentUser;

  @override
  State<BuildHomePage> createState() => _BuildHomePageState();
}

class _BuildHomePageState extends State<BuildHomePage> {
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  String lastMess = '';
  String timeSend = '';
  String typeMess = '';

  Future getLastMess() async {
    var messSnapshot =
        await firebase.collection("messages").doc(widget.friendName).get();
    var textList = messSnapshot.data()!['text'];
    if (textList != []) {
      for (var i = textList.length - 1; i >= 0; i--) {
        if ((textList[i]['from'] == widget.currentUser ||
                textList[i]['from'] == widget.friendName) &
            (textList[i]['to'] == widget.currentUser ||
                textList[i]['to'] == widget.friendName)) {
          lastMess = textList[i]['body'];
          typeMess = textList[i]['type'];
          var _timeSend = textList[i]['timeSend'].toDate();
          if (DateFormat.yMd().format((_timeSend)) ==
              DateFormat.yMd().format(Timestamp.now().toDate())) {
            timeSend = DateFormat.Hm().format(_timeSend).toString();
          } else {
            timeSend = DateFormat.yMd().format(_timeSend).toString();
          }
          break;
        }
      }
    }
  }

  @override
  void initState() {
    getLastMess();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebase.collection('users').doc(widget.friendName).get(),
      builder: (BuildContext context,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Container(),
          );
        } else {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: GestureDetector(
              child: MessageCard(
                type: typeMess,
                avt: data['image'],
                sender: data['name'],
                lastMessage: lastMess,
                timeSend: timeSend,
                seen: data['seen'],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      friendName: data['email']!,
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}

class FavoriteContacts extends StatefulWidget {
  final List listFriend;
  FavoriteContacts({required this.listFriend});

  @override
  State<FavoriteContacts> createState() => _FavoriteContactsState();
}

class _FavoriteContactsState extends State<FavoriteContacts> {
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Friends',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 120.0,
            child: ListView.builder(
              padding: EdgeInsets.only(left: 10.0),
              scrollDirection: Axis.horizontal,
              itemCount: widget.listFriend.length,
              itemBuilder: (BuildContext context, int index) {
                return FutureBuilder(
                  future: firebase
                      .collection("users")
                      .doc(widget.listFriend[index])
                      .get(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    } else {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChatScreen(
                              friendName: widget.listFriend[index],
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 35.0,
                                backgroundImage: NetworkImage(data['image']),
                              ),
                              SizedBox(height: 6.0),
                              Text(
                                data['name'],
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RecentChats extends StatelessWidget {
  const RecentChats({
    Key? key,
    required this.lenghtChat,
    required this.recent,
    required this.user,
  }) : super(key: key);

  final int lenghtChat;
  final List<RecentMessage>? recent;
  final User user;

  @override
  Widget build(BuildContext context) {
    var _firestore = FirebaseFirestore.instance;
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: ListView.builder(
              itemCount: lenghtChat,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: GestureDetector(
                      onTap: () async {
                        if (recent![index].seen == false) {
                          var data = {};
                          data['body'] = recent![index].body;
                          data['from'] = recent![index].sender;
                          data['seen'] = recent![index].seen;
                          data['timeSend'] = recent![index].realTime;
                          data['to'] = user.email;
                          data['type'] = recent![index].type;
                          var sender =
                              recent![index].sender.replaceAll('.', '_');
                          await _firestore
                              .collection("messages")
                              .doc(user.email)
                              .update({
                            sender: FieldValue.arrayRemove([data]),
                          });
                          data['seen'] = !recent![index].seen;
                          await _firestore
                              .collection("messages")
                              .doc(user.email)
                              .set({
                            sender: FieldValue.arrayUnion([data]),
                          }, SetOptions(merge: true));
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ChatScreen(friendName: recent![index].sender),
                          ),
                        );
                      },
                      child: MessageCard(
                        avt: recent![index].image,
                        type: recent![index].type,
                        sender: recent![index].sender,
                        lastMessage: recent![index].body,
                        timeSend: recent![index].time,
                        seen: recent![index].seen,
                      )),
                );
              }),
        ),
      ),
    );
  }
}

class Skelton extends StatelessWidget {
  const Skelton({
    Key? key,
    this.height,
    this.width,
  }) : super(key: key);

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          borderRadius: BorderRadius.all(Radius.circular(16))),
    );
  }
}

class NewCardSkelton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var widthDevice = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.black.withOpacity(0.04),
          ),
          Column(
            children: [
              Skelton(
                width: widthDevice * 0.7,
                height: 15,
              ),
              SizedBox(
                height: 5,
              ),
              Skelton(
                width: widthDevice * 0.7,
                height: 15,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LoadingRecentChat extends StatelessWidget {
  const LoadingRecentChat({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: ListView.separated(
            itemBuilder: (context, index) => NewCardSkelton(),
            separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
            itemCount: 7),
      ),
    );
  }
}
