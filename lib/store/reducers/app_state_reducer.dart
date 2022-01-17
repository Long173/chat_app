import 'package:app_chat/store/actions/auth_action.dart';
import 'package:app_chat/store/actions/recent_mess_action.dart';
import 'package:app_chat/store/actions/status_reducer_action.dart';
import 'package:app_chat/store/models/app_state.dart';
import 'package:redux/redux.dart';

final Reducer<AppState> appStateReducer = combineReducers<AppState>([
  TypedReducer<AppState, StatusReducerAction>(reducerChangeStatus),
  TypedReducer<AppState, ChangeRecentMess>(reducerChangeRecentMess),
  TypedReducer<AppState, Authenticated>(reducerReducerLogin),

]);

AppState reducerChangeStatus(AppState state, StatusReducerAction action) {
  return state.rebuild((p0) => p0..status = action.newStatus);
}

AppState reducerChangeRecentMess(AppState state, ChangeRecentMess action) {
  return state.rebuild((p0) => p0..recentMess = action.recentMess);
}

AppState reducerReducerLogin(AppState state, Authenticated action) {
  return state.rebuild((a) => a..user = action.user.toBuilder());
}