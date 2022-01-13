import 'package:app_chat/repo/repository.dart';
import 'package:app_chat/store/actions/auth_action.dart';
import 'package:app_chat/store/actions/message_action.dart';
import 'package:app_chat/store/actions/recent_mess_action.dart';
import 'package:app_chat/store/actions/register_action.dart';
import 'package:app_chat/store/actions/status_reducer_action.dart';
import 'package:app_chat/store/models/app_state.dart';
import 'package:app_chat/store/models/message.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux_epics/redux_epics.dart';

import '../../keys.dart';
import '../../route.dart';

class AppMiddleware implements EpicClass<AppState> {
  static final _navigatorKey = NavKey.navKey;

  final Repository repository;

  AppMiddleware(this.repository);

  @override
  Stream call(Stream actions, EpicStore<AppState> store) {
    return combineEpics<AppState>([
      getAllRecentMess,
      sendMessage,
      auth,
      register,
    ])(actions, store);
  }

  Stream<dynamic> getAllRecentMess(
      Stream<dynamic> actions, EpicStore<AppState> store) async* {
    await for (final action in actions) {
      if (action is GetAllRecentMess) {
        try {
          yield StatusReducerAction.create(status: "isLoading");
          List recentFriend = await repository.getRecentFriend();
          List<RecentMessage> recentMess =
              await repository.getRecentMess(recentFriend);
          yield ChangeRecentMess.create(newMess: recentMess);
        } catch (e) {
          print(e);
        } finally {
          yield StatusReducerAction.create(status: "idle");
        }
      }
    }
  }

  Stream<dynamic> sendMessage(
      Stream<dynamic> actions, EpicStore<AppState> store) async* {
    await for (final action in actions) {
      if (action is SendMessage) {
        try {
          yield StatusReducerAction.create(status: "isLoading");
          yield repository.sendMess(
              action.message,
              action.sender,
              action.receiver,
              action.type,
              action.timeSend,
              action.scrollController);
        } catch (e) {
          Fluttertoast.showToast(msg: e.toString());
        } finally {
          yield StatusReducerAction.create(status: "idle");
        }
      }
    }
  }

  Stream<dynamic> auth(
    Stream<dynamic> actions,
    EpicStore<AppState> store,
  ) async* {
    await for (final action in actions) {
      if (action is LogIn) {
        try {
          yield StatusReducerAction.create(status: "isLoading");
          yield repository.loginAccount(action.email, action.password);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            Fluttertoast.showToast(msg: 'User not found');
          } else if (e.code == 'wrong-password') {
            Fluttertoast.showToast(msg: 'Wrong password');
          }
        } catch (e) {
          Fluttertoast.showToast(msg: e.toString());
        } finally {
          yield StatusReducerAction.create(status: "idle");
        }
      }
      if (action is LogOutAction) {
        try {
          yield StatusReducerAction.create(status: "isLoading");
          FirebaseAuth.instance.signOut();
          _navigatorKey.currentState!.pushReplacementNamed(Routes.login);
        } catch (e) {
          Fluttertoast.showToast(msg: e.toString());
        } finally {
          yield StatusReducerAction.create(status: "idle");
        }
      }
    }
  }

  Stream<dynamic> register(
    Stream<dynamic> actions,
    EpicStore<AppState> store,
  ) async* {
    await for (final action in actions) {
      if (action is Register) {
        try {
          yield StatusReducerAction.create(status: "isLoading");
          yield repository.createNewAccount(
              action.name, action.email, action.password);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'email-already-in-use') {
            Fluttertoast.showToast(msg: 'Email is already in use');
          } else if (e.code == 'weak-password') {
            Fluttertoast.showToast(msg: 'Password is weak');
          }
        } catch (e) {
          Fluttertoast.showToast(msg: 'Something went wrong');
        } finally {
          yield StatusReducerAction.create(status: "idle");
        }
      }
    }
  }
}
