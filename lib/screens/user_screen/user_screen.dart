import 'dart:io';
import 'package:app_chat/repo/repository.dart';
import 'package:app_chat/store/actions/update_user_info.dart';
import 'package:app_chat/store/models/app_state.dart';
import 'package:app_chat/store/view_model/app_state_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../../config/const.dart';

class UserScreen extends StatefulWidget {
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final users = FirebaseFirestore.instance.collection('users');
  var docId;
  File? _image;
  var repository = Repository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Me',
        ),
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StoreConnector<AppState, AppStateViewModel>(
          converter: (Store<AppState> store) => AppStateViewModel.create(store),
          builder: (BuildContext context, vm) {
            var user = vm.user;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 100,
                        child: ClipOval(
                          child: SizedBox(
                            width: 180,
                            height: 180,
                            child: (_image != null)
                                ? Image.file(
                                    _image!,
                                    fit: BoxFit.fill,
                                  )
                                : CachedNetworkImage(
                                    imageUrl: user!.image,
                                    placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      color: Colors.black12,
                                      child: Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -10,
                        left: 130,
                        child: IconButton(
                          icon: Icon(Icons.add_a_photo),
                          iconSize: 40,
                          onPressed: () async {
                            _image = await repository.getImage();
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    user!.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                  ),
                  Text(
                    'Email: ${user.email}',
                    style: kUserText,
                  ),
                  Text(
                    'Date Create: ${user.dateCreate}',
                    style: kUserText,
                  ),
                  StoreConnector<AppState, AppStateViewModel>(
                      converter: (Store<AppState> store) =>
                          AppStateViewModel.create(store),
                      builder: (BuildContext context, vm) {
                        return TextButton(
                          onPressed: () async {
                            var url =
                                await repository.uploadUserAva(_image, user);
                            vm.dispatch(
                                action: UpdateUserInfoMiddlewareAction.create(
                                    image: url));
                          },
                          child: Text(
                            'Save',
                            style: TextStyle(fontSize: 24),
                          ),
                        );
                      }),
                ],
              ),
            );
          }),
    );
  }
}
