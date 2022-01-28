import 'dart:io';
import 'package:app_chat/repo/repository.dart';
import 'package:app_chat/store/actions/message_action.dart';
import 'package:app_chat/store/actions/recent_mess_action.dart';
import 'package:app_chat/store/models/app_state.dart';
import 'package:app_chat/store/view_model/app_state_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'chat_widget.dart';

class ChatScreen extends StatefulWidget {
  final String? friendName;
  ChatScreen({this.friendName = ''});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  User? user = FirebaseAuth.instance.currentUser;
  var repository = Repository();
  File? _image;
  var _url;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppStateViewModel>(
        converter: (Store<AppState> store) => AppStateViewModel.create(store),
        builder: (BuildContext context, vm) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 0.5,
              leading: IconButton(
                icon: Icon(CupertinoIcons.back),
                onPressed: () {
                  vm.dispatch(
                      action:
                          RencentChatMiddlewareAction.create(newUser: user!));
                  Navigator.pop(context);
                },
              ),
              title: Text(
                widget.friendName!,
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BuildChatScreen(
                    friendName: widget.friendName,
                    user: user,
                    scrollController: scrollController),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          child: _image == null
                              ? SizedBox()
                              : Image.file(
                                  _image!,
                                  height: 100,
                                ),
                        ),
                      ),
                      Container(
                        height: 60,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          decoration: InputDecoration(
                            fillColor: Color(0xffD5D8DD),
                            focusColor: Color(0xffD5D8DD),
                            hoverColor: Color(0xffD5D8DD),
                            hintText: 'Enter a Message...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            prefixIcon: IconButton(
                              icon: Icon(
                                Icons.photo_outlined,
                              ),
                              onPressed: () async {
                                _image = await repository.getImage();
                                setState(() {});
                              },
                            ),
                            suffix: SendButton(
                                text: 'Send',
                                callback: () async {
                                  if (_image != null) {
                                    _url = await repository
                                        .uploadChatImage(_image);
                                  }
                                  vm.dispatch(
                                    action: SendMessageMiddlewareAction.create(
                                      type: _image == null ? 'text' : 'picture',
                                      receiver: widget.friendName!,
                                      message: _image == null
                                          ? messageController.text
                                          : _url.toString(),
                                      sender: user!.email!,
                                      timeSend: Timestamp.now(),
                                    ),
                                  );
                                  messageController.clear();
                                  setState(() {
                                    _image = null;
                                  });
                                }),
                          ),
                          controller: messageController,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
