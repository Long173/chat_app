import 'dart:io';
import 'package:app_chat/repo/repository.dart';
import 'package:app_chat/store/actions/change_user_image.dart';
import 'package:app_chat/store/models/app_state.dart';
import 'package:app_chat/store/selectors/app_state_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../../const.dart';
import '../../route.dart';

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
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Me',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: kAppbarBackground,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          color: Colors.black,
          onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.home);
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
                  GestureDetector(
                    onTap: () async {
                      _image = await repository.getImage();
                      setState(() {});
                    },
                    child: CircleAvatar(
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
                              : Image.network('${user!.image}'),
                        ),
                      ),
                    ),
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
                            vm.dispatch(action: UpdateUserInfo(image: url));
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
