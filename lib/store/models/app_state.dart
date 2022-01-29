import 'package:app_chat/store/models/message.dart';
import 'package:app_chat/store/models/user.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

import 'friend.dart';

part 'app_state.g.dart';

abstract class AbstractAppState {}

abstract class AppState
    implements Built<AppState, AppStateBuilder>, AbstractAppState {
  String get status;
  BuiltList<RecentMessage> get recentMess;
  AppUser? get user;
  bool get isDark;
  BuiltList<Friend> get friend;
  int get page;

  AppState._();
  static void _initializeBuilder(AppStateBuilder builder) {
    builder.status = "idle";
    builder.recentMess = ListBuilder();
    builder.isDark = false;
    builder.friend = ListBuilder();
    builder.page = 0;
  }

  factory AppState([void Function(AppStateBuilder)? updates]) = _$AppState;
}
// cmd: flutter pub run build_runner build
