import 'package:app_chat/repo/repository.dart';
import 'package:app_chat/store/epics/epic.dart';
import 'package:app_chat/store/models/app_state.dart';
import 'package:app_chat/store/reducers/app_state_reducer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'config/build_app.dart';

PageController pageController = PageController(initialPage: 0);
int currentIndex = 0;

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
