import 'package:app_chat/screens/chat_screen/chat_screen.dart';
import 'package:app_chat/store/actions/auth_action.dart';
import 'package:app_chat/store/actions/change_page_action.dart';
import 'package:app_chat/store/models/app_state.dart';
import 'package:app_chat/store/models/message.dart';
import 'package:app_chat/store/view_model/app_state_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
                vm.dispatch(action: LogoutMiddlewareAction());
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
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: avt,
              fit: BoxFit.cover,
              height: 65,
              width: 65,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sender,
                  style: TextStyle(
                      fontSize: 20, fontWeight: seen ? null : FontWeight.bold),
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
                                fontWeight: seen ? null : FontWeight.bold),
                          ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '•$timeSend',
                      style: TextStyle(
                          fontSize: 16,
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

class FriendContact extends StatefulWidget {
  final List listFriend;
  FriendContact({required this.listFriend});

  @override
  State<FriendContact> createState() => _FriendContactState();
}

class _FriendContactState extends State<FriendContact> {
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  var friendController = ScrollController();

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
              controller: friendController,
              padding: EdgeInsets.only(left: 10.0),
              scrollDirection: Axis.horizontal,
              itemCount: widget.listFriend.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(
                        friendName: widget.listFriend[index].email,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: widget.listFriend[index].avatar,
                            height: 65,
                            width: 65,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          widget.listFriend[index].name,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
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
  RecentChats({
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
    var recentController = ScrollController();
    return Expanded(
      child: StoreConnector<AppState, AppStateViewModel>(
          converter: (Store<AppState> store) => AppStateViewModel.create(store),
          builder: (BuildContext context, vm) {
            return Container(
              decoration: BoxDecoration(
                color: vm.isDark ? Colors.black : Colors.white,
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
                    controller: recentController,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                    friendName: recent![index].sender),
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
                          ),
                        ),
                      );
                    }),
              ),
            );
          }),
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
    return StoreConnector<AppState, AppStateViewModel>(
        converter: (Store<AppState> store) => AppStateViewModel.create(store),
        builder: (BuildContext context, vm) {
          return Container(
            height: height,
            width: width,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: vm.isDark
                  ? Colors.white.withOpacity(0.04)
                  : Colors.black.withOpacity(0.04),
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
          );
        });
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
          StoreConnector<AppState, AppStateViewModel>(
              converter: (Store<AppState> store) =>
                  AppStateViewModel.create(store),
              builder: (BuildContext context, vm) {
                return CircleAvatar(
                  radius: 30,
                  backgroundColor: vm.isDark
                      ? Colors.white.withOpacity(0.04)
                      : Colors.black.withOpacity(0.04),
                );
              }),
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
    var viewController = ScrollController();
    return StoreConnector<AppState, AppStateViewModel>(
        converter: (Store<AppState> store) => AppStateViewModel.create(store),
        builder: (BuildContext context, vm) {
          return Container(
            padding: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: vm.isDark ? Colors.black : Colors.white,
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
                  controller: viewController,
                  itemBuilder: (context, index) => NewCardSkelton(),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                  itemCount: 6),
            ),
          );
        });
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              child: ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).primaryColor.withAlpha(150),
                        Theme.of(context).primaryColor,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 45,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CustomNavItem(icon: Icons.home, id: 0),
                  Container(),
                  CustomNavItem(icon: Icons.person_pin_rounded, id: 1),
                  Container(),
                  CustomNavItem(icon: Icons.settings, id: 2),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Home',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(width: 10,),
                  Text(
                    'Friends',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(),
                  Text(
                    'Setting',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomNavItem extends StatelessWidget {
  final IconData icon;
  final int id;

  const CustomNavItem({required this.icon, required this.id});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppStateViewModel>(
        converter: (Store<AppState> store) => AppStateViewModel.create(store),
        builder: (BuildContext context, vm) {
          return GestureDetector(
            onTap: () async {
              await vm.dispatch(
                  action: ChangePageMiddlewareAction.create(newPage: id));
            },
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Theme.of(context).primaryColor,
              child: CircleAvatar(
                radius: 25,
                backgroundColor: vm.page == id
                    ? Colors.white.withOpacity(0.9)
                    : Colors.transparent,
                child: Icon(
                  icon,
                  color: vm.page == id
                      ? Colors.black
                      : Colors.white.withOpacity(0.9),
                ),
              ),
            ),
          );
        });
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    var sw = size.width;
    var sh = size.height;
    path.cubicTo(sw / 12, 0, sw / 12, 2 * sh / 5, 2 * sw / 12, 2 * sh / 5);
    path.cubicTo(3 * sw / 12, 2 * sh / 5, 3 * sw / 12, 0, 4 * sw / 12, 0);
    path.cubicTo(
        5 * sw / 12, 0, 5 * sw / 12, 2 * sh / 5, 6 * sw / 12, 2 * sh / 5);
    path.cubicTo(7 * sw / 12, 2 * sh / 5, 7 * sw / 12, 0, 8 * sw / 12, 0);
    path.cubicTo(
        9 * sw / 12, 0, 9 * sw / 12, 2 * sh / 5, 10 * sw / 12, 2 * sh / 5);
    path.cubicTo(11 * sw / 12, 2 * sh / 5, 11 * sw / 12, 0, sw, 0);
    path.lineTo(sw, sh);
    path.lineTo(0, sh);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
