import 'package:app_chat/repo/repository.dart';
import 'package:app_chat/store/actions/auth_action.dart';
import 'package:app_chat/store/actions/message_action.dart';
import 'package:app_chat/store/actions/recent_mess_action.dart';
import 'package:app_chat/store/actions/register_action.dart';
import 'package:app_chat/store/actions/status_reducer_action.dart';
import 'package:app_chat/store/models/app_state.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
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
          var list = await repository.getAllRecentMess(action.user!);
          yield ChangeRecentMess.create(newMess: list.toList());
        } catch (e) {
          Fluttertoast.showToast(msg: e.toString());
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
          final FirebaseFirestore firestore = FirebaseFirestore.instance;
          User? user = FirebaseAuth.instance.currentUser;
          if (action.message.length > 0) {
            var map = new Map<String, dynamic>();
            map['body'] = action.message;
            map['from'] = action.sender;
            map['to'] = action.receiver;
            map['type'] = action.type;
            map['timeSend'] = action.timeSend.toDate();

            await firestore.collection('messages').doc(user!.email).set({
              'text': FieldValue.arrayUnion([map]),
            }, SetOptions(merge: true));

            await firestore.collection('messages').doc(action.receiver).set({
              'text': FieldValue.arrayUnion([map]),
            }, SetOptions(merge: true));

            action.scrollController.animateTo(
              action.scrollController.position.maxScrollExtent,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 300),
            );
          }
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
          final String email = action.email;
          final String password = action.password;
          FirebaseAuth auth = FirebaseAuth.instance;
          UserCredential user = await auth.signInWithEmailAndPassword(
              email: email, password: password);
          if (user.user != null) {
            _navigatorKey.currentState!.pushReplacementNamed(Routes.home);
          }
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
          FirebaseAuth auth = FirebaseAuth.instance;
          FirebaseFirestore firestore = FirebaseFirestore.instance;
          final DateFormat formatter = DateFormat.yMd().add_jm();
          UserCredential user = await auth.createUserWithEmailAndPassword(
              email: action.email, password: action.password);
          if (user.user != null) {
            await firestore.collection('users').doc(user.user!.email).set({
              'name': action.name,
              'email': action.email,
              'dateCreate': formatter.format(DateTime.now()),
              'image':
                  'https://firebasestorage.googleapis.com/v0/b/app-chat-c5b54.appspot.com/o/profileImage%2Fperson.png?alt=media&token=9eb5df06-22c4-4c02-a8fb-39cb1ed08e33',
            });
            await firestore.collection('messages').doc(user.user!.email).set({
              'text': [],
            }, SetOptions(merge: true));
          }
          _navigatorKey.currentState!.pop();
          Fluttertoast.showToast(msg: 'Sign Up Success');
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
