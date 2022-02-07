import 'package:app_chat/config/build_app.dart';
import 'package:app_chat/config/validation.dart';
import 'package:app_chat/repo/repository.dart';
import 'package:app_chat/store/actions/auth_action.dart';
import 'package:app_chat/store/actions/change_page_action.dart';
import 'package:app_chat/store/actions/change_theme_action.dart';
import 'package:app_chat/store/actions/list_friend_action.dart';
import 'package:app_chat/store/actions/message_action.dart';
import 'package:app_chat/store/actions/recent_mess_action.dart';
import 'package:app_chat/store/actions/register_action.dart';
import 'package:app_chat/store/actions/status_reducer_action.dart';
import 'package:app_chat/store/actions/update_user_info.dart';
import 'package:app_chat/store/models/app_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';
import 'package:redux_epics/redux_epics.dart';

import '../../config/keys.dart';
import '../../config/route.dart';

class AppMiddleware implements EpicClass<AppState> {
  static final _navigatorKey = NavKey.navKey;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  final Repository repository;

  AppMiddleware(this.repository);

  final validation = Validation();

  @override
  Stream call(Stream actions, EpicStore<AppState> store) {
    return combineEpics<AppState>([
      getAllRecentMess,
      sendMessage,
      authFirebase,
      register,
      updateUserInfo,
      changeTheme,
      getFriendList,
      changePage,
    ])(actions, store);
  }

  Stream<dynamic> getAllRecentMess(
      Stream<dynamic> actions, EpicStore<AppState> store) async* {
    await for (final action in actions) {
      if (action is RencentChatMiddlewareAction) {
        try {
          yield StatusReducerAction.create(status: "isLoading");
          final recentFriend = await repository.getRecentFriend(action.user);
          yield RencentChatReducerAction.create(newMess: recentFriend);
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
      if (action is SendMessageMiddlewareAction) {
        try {
          yield StatusReducerAction.create(status: "isLoading");
          yield repository.sendMess(action.message, action.sender,
              action.receiver, action.type, action.timeSend, action.seen);
        } catch (e) {
          Fluttertoast.showToast(msg: e.toString());
        } finally {
          yield StatusReducerAction.create(status: "idle");
        }
      }
    }
  }

  Stream<dynamic> getFriendList(
      Stream<dynamic> actions, EpicStore<AppState> store) async* {
    await for (final action in actions) {
      if (action is ListFriendMiddlewareAction) {
        try {
          yield StatusReducerAction.create(status: "isLoading");
          final list = await repository.getListFriend(action.user);
          yield ListFriendReducerAction.create(listFriend: list);
        } catch (e) {
          Fluttertoast.showToast(msg: e.toString());
        } finally {
          yield StatusReducerAction.create(status: "idle");
        }
      }
    }
  }

  Stream<dynamic> updateUserInfo(
      Stream<dynamic> actions, EpicStore<AppState> store) async* {
    await for (final action in actions) {
      if (action is UpdateUserInfoMiddlewareAction) {
        try {
          yield StatusReducerAction.create(status: "isLoading");
          yield UpdateUserInfoReducerAction.create(newImage: action.image);
        } catch (e) {
          Fluttertoast.showToast(msg: e.toString());
        } finally {
          yield StatusReducerAction.create(status: "idle");
        }
      }
    }
  }

  Stream<dynamic> changePage(
      Stream<dynamic> actions, EpicStore<AppState> store) async* {
    await for (final action in actions) {
      if (action is ChangePageMiddlewareAction) {
        try {
          yield StatusReducerAction.create(status: "isLoading");
          yield ChangePageReducerAction.create(newPage: action.goToPage);
          pageController.animateToPage(action.goToPage,
              duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);
        } catch (e) {
          Fluttertoast.showToast(msg: e.toString());
        } finally {
          yield StatusReducerAction.create(status: "idle");
        }
      }
    }
  }

  Stream<dynamic> authFirebase(
    Stream<dynamic> actions,
    EpicStore<AppState> store,
  ) async* {
    await for (final action in actions) {
      if (action is VerifyUserMiddlewareAction) {
        var appUser = await repository.infoUser(action.user);
        yield LoginReducerAction.create(newUser: appUser);
      }
      if (action is LoginMiddlewareAction) {
        ProgressDialog progressDialog = ProgressDialog(
            _navigatorKey.currentState!.overlay!.context,
            message: Text('Please wait'),
            title: Text('Logging In'));
        progressDialog.show();
        try {
          yield StatusReducerAction.create(status: "isLoading");
          validation.fillCheck([action.email, action.password]);
          validation.emailValidation(action.email);
          validation.passwordValidation(action.password);
          UserCredential user = await auth.signInWithEmailAndPassword(
              email: action.email, password: action.password);
          if (user.user != null) {
            progressDialog.dismiss();
            _navigatorKey.currentState!.pushReplacementNamed(Routes.home);
            var appUser = await repository.infoUser(user.user!);
            yield LoginReducerAction.create(newUser: appUser);
          }
        } on FirebaseAuthException catch (e) {
          progressDialog.dismiss();
          if (e.code == 'user-not-found') {
            Fluttertoast.showToast(msg: 'User not found');
          } else if (e.code == 'wrong-password') {
            Fluttertoast.showToast(msg: 'Wrong password');
          }
        } catch (e) {
          progressDialog.dismiss();
          Fluttertoast.showToast(msg: e.toString());
        } finally {
          yield StatusReducerAction.create(status: "idle");
        }
      }
      if (action is LogoutMiddlewareAction) {
        try {
          yield StatusReducerAction.create(status: "isLoading");
          FirebaseAuth.instance.signOut();
          yield ChangePageReducerAction.create(newPage: 0);
          _navigatorKey.currentState!
              .pushNamedAndRemoveUntil(Routes.login, (route) => false);
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
      if (action is RegisterMiddlewareAction) {
        ProgressDialog progressDialog = ProgressDialog(
            _navigatorKey.currentState!.overlay!.context,
            message: Text('Please wait'),
            title: Text('Signing up'));
        progressDialog.show();
        try {
          yield StatusReducerAction.create(status: "isLoading");
          validation.fillCheck(
              [action.name, action.email, action.password, action.confirm]);
          validation.emailValidation(action.email);
          validation.passwordValidation(action.password);
          validation.matchPassword(action.password, action.confirm);
          UserCredential user = await auth.createUserWithEmailAndPassword(
              email: action.email, password: action.password);
          if (user.user != null) {
            await firebase.collection('users').doc(user.user!.email).set({
              'name': action.name,
              'email': action.email,
              'dateCreate': DateFormat.yMd().add_jm().format(DateTime.now()),
              'image':
                  'https://firebasestorage.googleapis.com/v0/b/app-chat-c5b54.appspot.com/o/profileImage%2Fperson.png?alt=media&token=9eb5df06-22c4-4c02-a8fb-39cb1ed08e33',
            });
            await firebase.collection('messages').doc(user.user!.email).set({
              'text': [],
            }, SetOptions(merge: true));
          }
          _navigatorKey.currentState!.pop();
          Fluttertoast.showToast(msg: 'Sign Up Success');
        } on FirebaseAuthException catch (e) {
          progressDialog.dismiss();
          if (e.code == 'email-already-in-use') {
            Fluttertoast.showToast(msg: 'Email is already in use');
          } else if (e.code == 'weak-password') {
            Fluttertoast.showToast(msg: 'Password is weak');
          } else {
            Fluttertoast.showToast(msg: 'Something went wrong');
          }
        } catch (e) {
          progressDialog.dismiss();
          Fluttertoast.showToast(msg: 'Something went wrong');
        } finally {
          yield StatusReducerAction.create(status: "idle");
        }
      }
    }
  }

  Stream<dynamic> changeTheme(
    Stream<dynamic> actions,
    EpicStore<AppState> store,
  ) async* {
    await for (final action in actions) {
      if (action is ChangeThemeMiddlewareAction) {
        try {
          yield StatusReducerAction.create(status: "isLoading");
          yield ChangeThemeReducerAction.create(isDark: action.isDark);
        } catch (e) {
          Fluttertoast.showToast(msg: 'Something went wrong');
        } finally {
          yield StatusReducerAction.create(status: "idle");
        }
      }
    }
  }
}
