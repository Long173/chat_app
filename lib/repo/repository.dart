import 'dart:io';
import 'dart:math';
import 'package:app_chat/store/models/friend.dart';
import 'package:app_chat/store/models/message.dart';
import 'package:app_chat/store/models/user.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

abstract class AbstractRepository {
  Future<AppUser> infoUser(User user);
  Future<BuiltList<Friend>> getListFriend(User user);
  Future<BuiltList<RecentMessage>> getRecentFriend(User user);
  Future getAvatar(String name);
  Future<File?> getImage();
  Future uploadChatImage(var image);
  Future uploadUserAva(image, AppUser user, BuildContext context);
  Future sendMess(String message, String sender, String receiver, String type,
      Timestamp timeSend, bool seen);
}

class Repository implements AbstractRepository {
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<AppUser> infoUser(User user) async {
    final result = await firebase.collection('users').doc(user.email).get();
    final data = result.data();
    var appUser = new AppUser((b) => b
      ..dateCreate = data!['dateCreate']
      ..email = data['email']
      ..image = data['image']
      ..name = data['name']);

    return appUser;
  }

  @override
  Future<BuiltList<Friend>> getListFriend(User user) async {
    var list = BuiltList<Friend>([]);
    final result = firebase.collection('users');
    await result.get().then((snapshot) {
      snapshot.docs.forEach((doc) {
        if (doc.id != user.email) {
          var friend = new Friend((b) => b
            ..avatar = doc['image']
            ..name = doc['name']
            ..email = doc['email']);
          list = list.rebuild((p0) => p0..add(friend));
        }
      });
    });
    return list;
  }

  @override
  Future<BuiltList<RecentMessage>> getRecentFriend(User user) async {
    var setList = BuiltList<RecentMessage>([]);
    var messSnapshot =
        await firebase.collection("messages").doc(user.email).get();

    for (var i in messSnapshot.data()!.keys) {
      var textList = messSnapshot.data()![i];
      if (textList.length != 0) {
        var lastMess = textList.last['body'];
        var typeMess = textList.last['type'];
        var seen = textList.last['seen'];
        var _timeSend = textList.last['timeSend'].toDate();
        if (DateFormat.yMd().format((_timeSend)) ==
            DateFormat.yMd().format(Timestamp.now().toDate())) {
          _timeSend = DateFormat.Hm().format(_timeSend).toString();
        } else {
          _timeSend = DateFormat.yMd().format(_timeSend).toString();
        }
        var ava;
        await getAvatar(i.replaceAll('_', '.').toString())
            .then((value) => ava = value);
        var recentMess = new RecentMessage((b) => b
          ..body = lastMess
          ..type = typeMess
          ..time = _timeSend
          ..sender = i.replaceAll('_', '.')
          ..image = ava
          ..seen = seen
          ..realTime = textList.last['timeSend']);
        setList = setList.rebuild((p0) => p0..add(recentMess));
      }
    }
    setList = setList.rebuild(
      (p0) => p0
        ..sort((a, b) {
          return b.time.compareTo(a.time);
        }),
    );
    return setList;
  }

  @override
  Future getAvatar(String name) async {
    var snapshot = await firebase.collection("users").doc(name).get();
    if (snapshot.data() != null) {
      return snapshot.data()!['image'];
    }
  }

  @override
  Future<File?> getImage() async {
    File? image;
    final ImagePicker _picker = ImagePicker();
    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        image = File(xFile.path);
      }
    });
    return image;
  }

  @override
  Future uploadChatImage(var image) async {
    Reference firebaseRef = FirebaseStorage.instance
        .ref('chatImage')
        .child(Random().nextInt(100000).toString());
    await firebaseRef.putFile(image!);

    var url = await firebaseRef.getDownloadURL();
    return url;
  }

  @override
  Future uploadUserAva(image, AppUser user, BuildContext context) async {
    Reference firebaseRef =
        FirebaseStorage.instance.ref('profileImage').child(user.email);
    await firebaseRef.putFile(image!);
    var url = await firebaseRef.getDownloadURL();
    await firebase.collection('users').doc(user.email).update({'image': url});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile picture uploaded'),
      ),
    );
    return url;
  }

  @override
  Future sendMess(String message, String sender, String receiver, String type,
      Timestamp timeSend, bool seen) async {
    if (message.length > 0) {
      var map = new Map<String, dynamic>();
      map['body'] = message;
      map['from'] = sender;
      map['to'] = receiver;
      map['type'] = type;
      map['timeSend'] = timeSend.toDate();
      map['seen'] = seen;

      var receiver2 = receiver.replaceAll('.', '_');
      var sender2 = sender.replaceAll('.', '_');
      await firebase.collection('messages').doc(sender).set({
        receiver2: FieldValue.arrayUnion([map]),
      }, SetOptions(merge: true));

      map['seen'] = !seen;

      await firebase.collection('messages').doc(receiver).set({
        sender2: FieldValue.arrayUnion([map]),
      }, SetOptions(merge: true));
    }
  }
}
