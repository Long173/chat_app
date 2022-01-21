import 'dart:io';

import 'package:app_chat/repo/repository.dart';
import 'package:app_chat/route.dart';
import 'package:app_chat/store/actions/message_action.dart';
import 'package:app_chat/store/models/app_state.dart';
import 'package:app_chat/store/selectors/app_state_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../../const.dart';
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
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kAppbarBackground,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          color: Colors.black,
          onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.home);
          },
        ),
        title: Text(
          widget.friendName!,
          style: TextStyle(color: Colors.black),
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
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter a Message...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: IconButton(
                            icon: Icon(
                              Icons.photo,
                              color: Colors.black,
                            ),
                            onPressed: () async {
                              _image = await repository.getImage();
                              setState(() {});
                            },
                          ),
                        ),
                        controller: messageController,
                      ),
                    ),
                    StoreConnector<AppState, AppStateViewModel>(
                      converter: (Store<AppState> store) =>
                          AppStateViewModel.create(store),
                      builder: (BuildContext context, viewModel) {
                        return SendButton(
                            text: 'Send',
                            callback: () async {
                              if (_image != null) {
                                _url = await repository.uploadChatImage(_image);
                              }
                              viewModel.dispatch(
                                action: SendMessage(
                                  type: _image == null ? 'text' : 'picture',
                                  receiver: widget.friendName!,
                                  message: _image == null
                                      ? messageController.text
                                      : _url.toString(),
                                  sender: user!.email!,
                                  timeSend: Timestamp.now(),
                                  scrollController: scrollController,
                                ),
                              );
                              messageController.clear();
                              setState(() {
                                _image = null;
                              });
                            });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
