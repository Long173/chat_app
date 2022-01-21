import 'package:app_chat/repo/repository.dart';
import 'package:app_chat/store/actions/auth_action.dart';
import 'package:app_chat/store/actions/recent_mess_action.dart';
import 'package:app_chat/store/models/app_state.dart';
import 'package:app_chat/store/selectors/app_state_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
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
  List _listFriend = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _index = 0;
    return user == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: kBackgroundColor,
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Hero(
                  tag: 'icon',
                  child: Image.asset(
                    'assets/icon/logo.png',
                  ),
                ),
              ),
              backgroundColor: kAppbarBackground,
              centerTitle: true,
              title: Text(
                user!.email!,
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    HomeScreen._navigatorKey.currentState!
                        .pushNamed(Routes.user);
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
            body: Column(
              children: [
                FutureBuilder(
                  future: repository
                      .getListFriend(user!)
                      .then((value) => _listFriend.addAll(value)),
                  builder:
                      (BuildContext context, AsyncSnapshot<void> snapshot) {
                    return FavoriteContacts(
                      listFriend: _listFriend,
                    );
                  },
                ),
                StoreConnector<AppState, AppStateViewModel>(
                  distinct: true,
                  converter: (Store<AppState> store) =>
                      AppStateViewModel.create(store),
                  onInitialBuild: (viewModel) {
                    viewModel.dispatch(
                        action: GetAllRecentMess.create(newUser: user!));
                  },
                  builder: (BuildContext context, vm) {
                    final recent = vm.recentMess;
                    final status = vm.status;
                    if (vm.user == null) {
                     vm.dispatch(action: VerifyUser(user: user!));
                    }
                    return Container(
                      child: status == 'idle'
                          ? RecentChats(
                              lenghtChat: recent!.length, recent: recent, user : user!)
                          : Expanded(
                              flex: 4,
                              child: LoadingRecentChat(),
                            ),
                    );
                  },
                ),
              ],
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
