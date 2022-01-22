import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:built_value/built_value.dart';

part 'message_action.g.dart';

abstract class AbstractMessage {}

abstract class SendMessageMiddlewareAction
    implements
        Built<SendMessageMiddlewareAction, SendMessageMiddlewareActionBuilder>,
        AbstractMessage {
  String get message;
  String get sender;
  String get receiver;
  String get type;
  Timestamp get timeSend;
  bool get seen;

  SendMessageMiddlewareAction._();

  factory SendMessageMiddlewareAction.create({
    required String message,
    required String sender,
    required String receiver,
    required String type,
    required Timestamp timeSend,
    bool seen = true,
  }) =>
      SendMessageMiddlewareAction((update) => update
        ..message = message
        ..sender = sender
        ..receiver = receiver
        ..type = type
        ..timeSend = timeSend
        ..seen = seen);

  factory SendMessageMiddlewareAction(
          [void Function(SendMessageMiddlewareActionBuilder) updates]) =
      _$SendMessageMiddlewareAction;
}


abstract class DeleteMessageMiddlewareAction
    implements
        Built<DeleteMessageMiddlewareAction, DeleteMessageMiddlewareActionBuilder>,
        AbstractMessage {
  DeleteMessageMiddlewareAction._();

  factory DeleteMessageMiddlewareAction(
          [void Function(DeleteMessageMiddlewareActionBuilder) updates]) =
      _$DeleteMessageMiddlewareAction;
}
