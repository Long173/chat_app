import 'package:app_chat/repo/repository.dart';
import 'package:app_chat/route.dart';
import 'package:app_chat/screens/chat_screen/chat_screen.dart';
import 'package:app_chat/screens/home_screen/home_screen.dart';
import 'package:app_chat/screens/login_screen/login_screen.dart';
import 'package:app_chat/screens/register_screen/register_screen.dart';
import 'package:app_chat/screens/user_screen/user_screen.dart';
import 'package:app_chat/store/epics/epic.dart';
import 'package:app_chat/store/models/app_state.dart';
import 'package:app_chat/store/reducers/app_state_reducer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

import 'keys.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyBViO3wQaMovOhvKshkdsPPzLpRJ7jn_Ko",
        appId: "1:857923094449:web:0ba4a89bf04043e2331f90",
        messagingSenderId: "857923094449",
        projectId: "app-chat-c5b54",
        storageBucket: "app-chat-c5b54.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  final repository = Repository();
  final store = Store<AppState>(appStateReducer,
      initialState: AppState(),
      middleware: [EpicMiddleware<AppState>(AppMiddleware(repository))]);
  runApp(ChatApp(
    store: store,
  ));
}

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
