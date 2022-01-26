import 'package:built_value/built_value.dart';

part 'friend.g.dart';

abstract class AbstractFriend {}

abstract class Friend implements Built<Friend, FriendBuilder>, AbstractFriend {
  String get name;
  String get avatar;
  String get email;

  Friend._();
  factory Friend([void Function(FriendBuilder) updates]) = _$Friend;
}


// cmd: flutter pub run build_runner build
