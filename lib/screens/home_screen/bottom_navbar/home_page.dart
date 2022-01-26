import 'package:app_chat/repo/repository.dart';
import 'package:app_chat/store/actions/auth_action.dart';
import 'package:app_chat/store/actions/list_friend_action.dart';
import 'package:app_chat/store/actions/recent_mess_action.dart';
import 'package:app_chat/store/models/app_state.dart';
import 'package:app_chat/store/view_model/app_state_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../home_widgets.dart';

class HomePage extends StatelessWidget {
  HomePage({
    Key? key,
    required this.repository,
    required this.user,
  });

  final Repository repository;
  final User? user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StoreConnector<AppState, AppStateViewModel>(
            distinct: true,
            converter: (Store<AppState> store) =>
                AppStateViewModel.create(store),
            onInitialBuild: (viewModel) {
              viewModel.dispatch(
                  action: ListFriendMiddlewareAction.create(newUser: user!));
            },
            builder: (BuildContext context, vm) {

              return FriendContact(
                listFriend: vm.friend.toList(),
              );
            }),
        StoreConnector<AppState, AppStateViewModel>(
          distinct: true,
          converter: (Store<AppState> store) => AppStateViewModel.create(store),
          onInitialBuild: (viewModel) {
            viewModel.dispatch(
                action: RencentChatMiddlewareAction.create(newUser: user!));
          },
          builder: (BuildContext context, vm) {
            final recent = vm.recentMess;
            final status = vm.status;
            if (vm.user == null) {
              vm.dispatch(
                  action: VerifyUserMiddlewareAction.create(newUser: user!));
            }
            return Container(
              child: status == 'idle'
                  ? RecentChats(
                      lenghtChat: recent.length,
                      recent: recent.toList(),
                      user: user!)
                  : Expanded(
                      flex: 4,
                      child: LoadingRecentChat(),
                    ),
            );
          },
        ),
      ],
    );
  }
}


// FutureBuilder(
//           future: repository
//               .getListFriend(user!)
//               .then((value) => _listFriend = value),
//           builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
//             return FavoriteContacts(
//               listFriend: _listFriend,
//             );
//           },
//         ),