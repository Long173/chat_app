import 'package:app_chat/config/build_app.dart';
import 'package:app_chat/repo/repository.dart';
import 'package:app_chat/screens/home_screen/bottom_navbar/friend_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../config/keys.dart';
import '../../config/route.dart';
import 'bottom_navbar/home_page.dart';
import 'bottom_navbar/setting_page.dart';
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


  @override
  Widget build(BuildContext context) {
    return user == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
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
              centerTitle: true,
              title: Text(
                user!.email!,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    HomeScreen._navigatorKey.currentState!
                        .pushNamed(Routes.user);
                  },
                  icon: Icon(
                    Icons.person,
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
                  ),
                ),
              ],
            ),
            extendBody: true,
            body: PageView(
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                HomePage(
                  repository: repository,
                  user: user,
                ),
                FriendPage(
                  repository: repository,
                  user: user!,
                ),
                SettingPage(),
              ],
            ),
            bottomNavigationBar: CustomBottomNavigationBar(),
          );
  }
}
