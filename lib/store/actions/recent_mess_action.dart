import 'package:app_chat/store/models/message.dart';
import 'package:built_value/built_value.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'recent_mess_action.g.dart';

abstract class AbstractRecentMess {}

abstract class RencentChatMiddlewareAction
    implements Built<RencentChatMiddlewareAction, RencentChatMiddlewareActionBuilder>,AbstractRecentMess {
  RencentChatMiddlewareAction._();
  User get user;
  factory RencentChatMiddlewareAction.create({required User newUser}) =>
      RencentChatMiddlewareAction((update) => update..user = newUser);
  factory RencentChatMiddlewareAction([void Function(RencentChatMiddlewareActionBuilder) updates]) =
      _$RencentChatMiddlewareAction;
}

abstract class RencentChatReducerAction
    implements Built<RencentChatReducerAction, RencentChatReducerActionBuilder>,AbstractRecentMess {
  RencentChatReducerAction._();
  List<RecentMessage> get recentMess;
  factory RencentChatReducerAction.create({required List<RecentMessage> newMess}) =>
      RencentChatReducerAction((update) => update..recentMess = newMess);
  factory RencentChatReducerAction([void Function(RencentChatReducerActionBuilder) updates]) =
      _$RencentChatReducerAction;
}

// cmd: flutter pub run build_runner build
