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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final repository = Repository();
  final store = Store<AppState>(appStateReducer,
      initialState: AppState(),
      middleware: [EpicMiddleware<AppState>(AppMiddleware(repository))]);
  runApp(ChatApp(
    store: store,
  ));
}
