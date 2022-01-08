import 'dart:io';
import 'package:app_chat/repo/repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      body: SafeArea(
        child: FutureBuilder<DocumentSnapshot>(
          future: users.doc(user!.email).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
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
                                : Image.network('${data['image']}'),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Text(
                      data['name'],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                    ),
                    Text(
                      'Email: ${data['email']}',
                      style: kUserText,
                    ),
                    Text(
                      'Date Create: ${data['dateCreate']}',
                      style: kUserText,
                    ),
                    TextButton(
                      onPressed: () {
                        repository.uploadUserAva(_image, user!);
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
