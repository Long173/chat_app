import 'package:app_chat/config/route.dart';
import 'package:app_chat/screens/chat_screen/chat_screen.dart';
import 'package:app_chat/screens/home_screen/home_screen.dart';
import 'package:app_chat/screens/login_screen/login_screen.dart';
import 'package:app_chat/screens/register_screen/register_screen.dart';
import 'package:app_chat/screens/user_screen/user_screen.dart';
import 'package:app_chat/store/models/app_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'keys.dart';
class ChatApp extends StatelessWidget {
  const ChatApp({Key? key, required this.store}) : super(key: key);
  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'App Chat',
        debugShowCheckedModeBanner: false,
        navigatorKey: NavKey.navKey,
        initialRoute: FirebaseAuth.instance.currentUser == null
            ? Routes.login
            : Routes.home,
        routes: {
          Routes.login: (context) {
            return LoginScreen();
          },
          Routes.home: (context) {
            return HomeScreen();
          },
          Routes.register: (context) {
            return RegisterScreen();
          },
          Routes.user: (context) {
            return UserScreen();
          },
          Routes.chat: (context) {
            return ChatScreen();
          },
        },
      ),
    );
  }
}
