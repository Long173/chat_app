import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class SendMessage {
  final String message;
  final String sender;
  final ScrollController scrollController;
  final String receiver;
  final String type;
  final Timestamp timeSend;

  const SendMessage({
    required this.message,
    required this.sender,
    required this.scrollController,
    required this.receiver,
    required this.type,
    required this.timeSend,
  });
}

class DeleteMessage {
  const DeleteMessage();
}
