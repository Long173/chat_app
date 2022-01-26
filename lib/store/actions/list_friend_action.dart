import 'package:app_chat/store/models/friend.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'list_friend_action.g.dart';

abstract class AbstractListFriend {}

abstract class ListFriendMiddlewareAction implements Built<ListFriendMiddlewareAction, ListFriendMiddlewareActionBuilder>,AbstractListFriend {
    User get user;


  ListFriendMiddlewareAction._();
    factory ListFriendMiddlewareAction.create({required User newUser}) =>
      ListFriendMiddlewareAction((update) => update..user = newUser);
  factory ListFriendMiddlewareAction([void Function(ListFriendMiddlewareActionBuilder) updates]) = _$ListFriendMiddlewareAction;
}

abstract class ListFriendReducerAction implements Built<ListFriendReducerAction, ListFriendReducerActionBuilder>,AbstractListFriend {
  BuiltList<Friend> get listFriend;

  ListFriendReducerAction._();

  factory ListFriendReducerAction.create(
          {required BuiltList<Friend> listFriend}) =>
      ListFriendReducerAction(
          (update) => update..listFriend = ListBuilder(listFriend));
  factory ListFriendReducerAction([void Function(ListFriendReducerActionBuilder) updates]) = _$ListFriendReducerAction;
}

// cmd: flutter pub run build_runner build