import 'package:app_chat/store/actions/auth_action.dart';
import 'package:app_chat/store/actions/change_page_action.dart';
import 'package:app_chat/store/actions/change_theme_action.dart';
import 'package:app_chat/store/actions/list_friend_action.dart';
import 'package:app_chat/store/actions/recent_mess_action.dart';
import 'package:app_chat/store/actions/status_reducer_action.dart';
import 'package:app_chat/store/actions/update_user_info.dart';
import 'package:app_chat/store/models/app_state.dart';
import 'package:app_chat/store/models/friend.dart';
import 'package:app_chat/store/models/message.dart';
import 'package:app_chat/store/models/user.dart';
import 'package:app_chat/store/reducers/app_state_reducer.dart';
import 'package:app_chat/store/view_model/app_state_view_model.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';

void main() {
  group("test change page", () {
    test("get page", () {
      final store = Store<AppState>(appStateReducer, initialState: AppState());
      final viewModel = AppStateViewModel.create(store);
      expect(viewModel.page, 0);
    });

    test("change page", () {
      final store = Store<AppState>(appStateReducer, initialState: AppState());
      final viewModel = AppStateViewModel.create(store);
      viewModel.dispatch(action: ChangePageReducerAction.create(newPage: 1));
      expect(store.state.page, 1);
    });
  });
  group("user reducer", () {
    final user = AppUser((u) => u
      ..email = 'example@gmail.com'
      ..dateCreate = 'dateCreate'
      ..name = 'name'
      ..image = 'image');
    test('should update user when state empty', () {
      final store = Store<AppState>(appStateReducer, initialState: AppState());
      expect(store.state.user, null);

      final viewModel = AppStateViewModel.create(store);
      viewModel.dispatch(action: LoginReducerAction.create(newUser: user));
      expect(store.state.user, user);
    });
    test("should update user when state has data", () {
      final store = Store<AppState>(appStateReducer, initialState: AppState());
      final viewModel = AppStateViewModel.create(store);
      viewModel.dispatch(action: LoginReducerAction.create(newUser: user));
      viewModel.dispatch(
          action: UpdateUserInfoReducerAction.create(newImage: 'newImage'));
      expect(store.state.user!.image, 'newImage');
    });
  });
  group("status reducer", () {
    test("test change status", () {
      final store = Store<AppState>(appStateReducer, initialState: AppState());
      final viewModel = AppStateViewModel.create(store);
      viewModel.dispatch(
          action: StatusReducerAction.create(status: "isLoading"));
      expect(store.state.status, "isLoading");
    });
  });
  group("recent chat reducer", () {
    final recentMess = RecentMessage((rm) => rm
      ..body = "body"
      ..image = "image"
      ..realTime = Timestamp.fromDate(DateTime.now())
      ..seen = true
      ..sender = "sender@gmail.com"
      ..time = "time"
      ..type = "text");
    var list = BuiltList<RecentMessage>([]);
    list = list.rebuild((p0) => p0..add(recentMess));

    test("should update recent mess", () {
      final store = Store<AppState>(appStateReducer, initialState: AppState());
      expect(store.state.recentMess, [].toBuiltList());
      final viewModel = AppStateViewModel.create(store);
      viewModel.dispatch(
          action: RencentChatReducerAction.create(newMess: list));
      expect(store.state.recentMess, list);
    });
  });
  group("change theme reducer", () {
    test("change theme", () {
      final store = Store<AppState>(appStateReducer, initialState: AppState());
      final viewModel = AppStateViewModel.create(store);
      expect(store.state.isDark, false);
      viewModel.dispatch(action: ChangeThemeReducerAction.create(isDark: true));
      expect(store.state.isDark, true);
    });
  });
  group("friend reducer", () {
    final friend = Friend((f) => f
      ..name = 'name'
      ..avatar = 'avatar'
      ..email = 'example@gmail.com');
    var list = BuiltList<Friend>([]);
    list = list.rebuild((p0) => p0..add(friend));
    test("get list friend", () {
      final store = Store<AppState>(appStateReducer, initialState: AppState());
      final viewModel = AppStateViewModel.create(store);
      expect(store.state.friend, [].toBuiltList());
      viewModel.dispatch(
          action: ListFriendReducerAction.create(listFriend: list));
      expect(store.state.friend, list);
    });
  });
}
