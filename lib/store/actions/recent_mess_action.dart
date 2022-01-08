import 'package:app_chat/store/models/message.dart';
import 'package:built_value/built_value.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'recent_mess_action.g.dart';

abstract class GetAllRecentMess
    implements Built<GetAllRecentMess, GetAllRecentMessBuilder> {
  GetAllRecentMess._();
  User? get user;
  factory GetAllRecentMess([void Function(GetAllRecentMessBuilder) updates]) =
      _$GetAllRecentMess;
}

abstract class ChangeRecentMess
    implements Built<ChangeRecentMess, ChangeRecentMessBuilder> {
  ChangeRecentMess._();
  List<RecentMessage> get recentMess;
  factory ChangeRecentMess.create({required List<RecentMessage> newMess}) =>
      ChangeRecentMess((update) => update..recentMess = newMess);
  factory ChangeRecentMess([void Function(ChangeRecentMessBuilder) updates]) =
      _$ChangeRecentMess;
}

// cmd: flutter pub run build_runner build
