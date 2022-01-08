import 'package:app_chat/repo/repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../const.dart';
import '../../keys.dart';
import '../../route.dart';
import 'home_widgets.dart';

class HomeScreen extends StatefulWidget {
  static final _navigatorKey = NavKey.navKey;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  Repository repository = Repository();
  List _listRecentChat = [];
  List _listFriend = [];

  Future<List> futureWait() async {
    return Future.wait([
      repository.listFriend(user!).then((value) => _listFriend.addAll(value)),
      repository.listDoc(user!).then((value) => _listRecentChat.addAll(value)),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    var _index = 0;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kAppbarBackground,
        centerTitle: true,
        title: Text(
          user!.email!,
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              HomeScreen._navigatorKey.currentState!.pushNamed(Routes.user);
            },
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return ConfirmNotiWidget();
                  });
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: futureWait(),
        builder: (context, snapshot) {
          return Column(
            children: [
              FavoriteContacts(
                listFriend: _listFriend,
              ),
              RecentChats(list: _listRecentChat, user: user),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Channels',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.expand_more),
            label: 'More',
          ),
        ],
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
    );
  }
}
