import 'package:app_chat/repo/firestore_search.dart';
import 'package:app_chat/repo/repository.dart';
import 'package:app_chat/screens/chat_screen/chat_screen.dart';
import 'package:app_chat/store/models/app_state.dart';
import 'package:app_chat/store/view_model/app_state_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_search/firestore_search.dart';
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
  var searchController = TextEditingController();
  bool isExecuted = true;

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
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isExecuted = true;
                      });
                    },
                    child: FirestoreSearchBar(
                      tag: 'search friend',
                      showSearchIcon: true,
                    ),
                  ),
                  Expanded(
                      child: FirestoreSearchResults.builder(
                          resultsBodyBackgroundColor:
                              Theme.of(context).primaryColorLight,
                          tag: 'search friend',
                          firestoreCollectionName: 'users',
                          searchBy: 'email',
                          initialBody: ListView.builder(
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
                          dataListFromSnapshot:
                              DataModel().dataListFromSnapshot,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final List<DataModel> dataList = snapshot.data;
                              if (dataList.isEmpty) {
                                return const Center(
                                  child: Text('No Results Returned'),
                                );
                              }
                              return ListView.builder(
                                  itemCount: dataList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (dataList[index].email !=
                                        widget.user.email) {
                                      return GestureDetector(
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ChatScreen(
                                                friendName:
                                                    dataList[index].email),
                                          ),
                                        ),
                                        child: ListTile(
                                          leading: ClipOval(
                                            child: CachedNetworkImage(
                                              imageUrl: dataList[index].image!,
                                              width: 60,
                                              height: 65,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          title: Text(
                                            dataList[index].name!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            dataList[index].email!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  });
                            } else {
                              return Container();
                            }
                          })),
                ],
              ),
            ),
          );
        });
  }
}
