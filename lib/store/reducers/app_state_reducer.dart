import 'package:app_chat/store/actions/auth_action.dart';
import 'package:app_chat/store/actions/change_page_action.dart';
import 'package:app_chat/store/actions/change_theme_action.dart';
import 'package:app_chat/store/actions/list_friend_action.dart';
import 'package:app_chat/store/actions/update_user_info.dart';
import 'package:app_chat/store/actions/recent_mess_action.dart';
import 'package:app_chat/store/actions/status_reducer_action.dart';
import 'package:app_chat/store/models/app_state.dart';
import 'package:built_collection/built_collection.dart';
import 'package:redux/redux.dart';

final Reducer<AppState> appStateReducer = combineReducers<AppState>([
  TypedReducer<AppState, StatusReducerAction>(reducerChangeStatus),
  TypedReducer<AppState, RencentChatReducerAction>(reducerChangeRecentMess),
  TypedReducer<AppState, LoginReducerAction>(reducerReducerLogin),
  TypedReducer<AppState, UpdateUserInfoReducerAction>(updateUserInfo),
  TypedReducer<AppState, ChangeThemeReducerAction>(changeTheme),
  TypedReducer<AppState, ListFriendReducerAction>(getListFriend),
  TypedReducer<AppState, ChangePageReducerAction>(changePage),
]);

AppState reducerChangeStatus(AppState state, StatusReducerAction action) {
  return state.rebuild((p0) => p0..status = action.newStatus);
}

AppState reducerChangeRecentMess(
    AppState state, RencentChatReducerAction action) {
  return state.rebuild((p0) => p0..recentMess = ListBuilder(action.recentMess));
}

AppState reducerReducerLogin(AppState state, LoginReducerAction action) {
  return state.rebuild((a) => a..user = action.user.toBuilder());
}

AppState updateUserInfo(AppState state, UpdateUserInfoReducerAction action) {
  return state.rebuild((a) => a..user.image = action.image);
}

AppState changeTheme(AppState state, ChangeThemeReducerAction action) {
  return state.rebuild((p0) => p0..isDark = action.isDark);
}

AppState getListFriend(AppState state, ListFriendReducerAction action) {
  return state.rebuild((p0) => p0..friend = ListBuilder(action.listFriend));
}

AppState changePage(AppState state, ChangePageReducerAction action) {
  return state.rebuild((p0) => p0..page = action.goToPage);
}
