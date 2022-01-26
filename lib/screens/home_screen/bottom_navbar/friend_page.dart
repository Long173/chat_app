import 'package:app_chat/repo/repository.dart';
import 'package:app_chat/store/models/app_state.dart';
import 'package:app_chat/store/view_model/app_state_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'friend_page_widgets.dart';

class FriendPage extends StatefulWidget {
  FriendPage({required this.repository, required this.user});

  final Repository repository;
  final User user;

  @override
  State<FriendPage> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  QuerySnapshot? snapshotData;
  var findController = TextEditingController();
  bool isExecuted = false;
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppStateViewModel>(
        converter: (Store<AppState> store) => AppStateViewModel.create(store),
        builder: (BuildContext context, vm) {
          return Container(
            color: Theme.of(context).primaryColorLight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    child: TextField(
                      onTap: () {
                        widget.repository
                            .queryData(findController.text, widget.user)
                            .then((value) {
                          snapshotData = value;
                          setState(() {
                            isExecuted = true;
                          });
                        });
                      },
                      controller: findController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 20),
                        suffixIcon: GestureDetector(
                          child: Icon(Icons.close),
                          onTap: () {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            setState(() {
                              isExecuted = false;
                            });
                          },
                        ),
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search for friends',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: isExecuted
                        ? null
                        : Text(
                            '${vm.friend.length} friends',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                  ),
                  Expanded(
                    child: isExecuted
                        ? searchData(snapshotData!)
                        : ListView.builder(
                            itemCount: vm.friend.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: FriendCard(
                                  avatar: vm.friend[index].avatar,
                                  name: vm.friend[index].name,
                                  email: vm.friend[index].email,
                                ),
                              );
                            }),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
