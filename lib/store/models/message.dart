import 'package:built_value/built_value.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'message.g.dart';

abstract class AbstractRecentMessage {}

abstract class RecentMessage
    implements
        Built<RecentMessage, RecentMessageBuilder>,
        AbstractRecentMessage {
  String get sender;
  String get body;
  String get type;
  String get time;
  String get image;
  RecentMessage._();

  factory RecentMessage([void Function(RecentMessageBuilder) updates]) =
      _$RecentMessage;
}
// cmd: flutter pub run build_runner build
