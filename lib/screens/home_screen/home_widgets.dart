import 'package:app_chat/screens/chat_screen/chat_screen.dart';
import 'package:app_chat/store/actions/auth_action.dart';
import 'package:app_chat/store/models/app_state.dart';
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
      required this.timeSend})
      : super(key: key);

  final String sender;
  final String avt;
  final String lastMessage;
  final String timeSend;
  final String type;

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
                  style: TextStyle(fontSize: 20, color: Colors.grey.shade700),
                ),
                Row(
                  children: [
                    type == 'picture'
                        ? Text('[Hình ảnh]')
                        : Text(
                            lastMessage.length > 25
                                ? lastMessage.substring(0, 20) + '...'
                                : lastMessage,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey.shade600),
                          ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '•$timeSend',
                      style:
                          TextStyle(fontSize: 16, color: Colors.grey.shade600),
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
    if (messSnapshot.data()!['text'] != []) {
      for (var i in messSnapshot.data()!['text']) {
        if ((i['from'] == widget.currentUser ||
                i['from'] == widget.friendName) &
            (i['to'] == widget.currentUser || i['to'] == widget.friendName)) {
          lastMess = i['body'];
          typeMess = i['type'];
          var _timeSend = i['timeSend'].toDate();
          if (DateFormat.yMd().format((_timeSend)) ==
              DateFormat.yMd().format(Timestamp.now().toDate())) {
            timeSend = DateFormat.Hm().format(_timeSend).toString();
          } else {
            timeSend = DateFormat.yMd().format(_timeSend).toString();
          }
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
                  timeSend: timeSend),
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
    required List list,
    required this.user,
  })  : _list = list,
        super(key: key);

  final List _list;
  final User? user;

  @override
  Widget build(BuildContext context) {
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
            itemCount: _list.length,
            itemBuilder: (BuildContext context, int index) {
              return BuildHomePage(
                friendName: _list[index],
                currentUser: user!.email,
              );
            },
          ),
        ),
      ),
    );
  }
}
